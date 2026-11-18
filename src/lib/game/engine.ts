import { MAX_UKUPNO, SEGMENTI, TOLERANCIJA_MREZE_MS } from "@/config/quiz.config";
import type { Db } from "@/lib/db/types";
import { RUKOVAOCI } from "./segments";
import { bezOdgovora } from "./types";
import type { Identitet, OdgovorServera, SegmentStanje, Stanje, StanjeListe, StavkaRezultata, Trenutno } from "./types";

/**
 * Srce igre. Sve odluke se donose ovde, na serveru:
 * ko sme da igra, koje je pitanje na redu, koliko je vremena prošlo i koliko poena odgovor nosi.
 * Browser dobija samo `Stanje` i `Ocena`, nikad tačan odgovor unapred.
 *
 * Svaka funkcija radi u jednoj transakciji i zaključava red igre, pa dupli klik
 * ili dva taba ne mogu da odgovore dvaput na isto pitanje.
 */

type RedIgre = {
  id: string;
  user_id: string | null;
  status: "in_progress" | "finished";
  /** none: nije na rang listi (gost) · pending: čeka potvrdu mejla · counted: na listi */
  lista: StanjeListe;
};

const KOLONE_IGRE = `id::text as id, user_id::text as user_id, status, leaderboard_status as lista`;

/**
 * Završena igra koja ima nalog ide na rang listu: odmah ako je mejl potvrđen, inače „na čekanju”
 * (kad se mejl potvrdi, okidač u bazi je prebacuje na listu). Igra gosta ostaje van liste.
 */
async function upisiNaListu(db: Db, playId: string): Promise<StanjeListe> {
  const [red] = await db.query<{ lista: StanjeListe }>(
    `update public.plays p set leaderboard_status = case
         when p.user_id is null or p.status <> 'finished' then p.leaderboard_status
         when exists (select 1 from auth.users u where u.id = p.user_id and u.email_confirmed_at is not null) then 'counted'
         else 'pending' end
     where p.id = $1::uuid
     returning leaderboard_status as lista`,
    [playId],
  );
  return red?.lista ?? "none";
}

type RedStavke = {
  id: number;
  segment: number;
  position: number;
  snapshot: unknown;
  served: boolean;
  answered: boolean;
  elapsed_ms: number | null;
  points: number | null;
  answer: unknown;
  answer_ms: number | null;
  /** Pesma: do sada preslušano (bez dela koji upravo svira). */
  listened_ms: number;
  /** Pesma: koliko dugo svira od poslednjeg „pusti”, ili null ako je pauzirana. */
  playing_ms: number | null;
};

const konfig = (n: number) => SEGMENTI.find((s) => s.n === n)!;
const limitMs = (n: number) => konfig(n).limitS * 1000;

/**
 * Koliko je vremena „potrošeno” na pitanje. Za većinu segmenata to je vreme od slanja pitanja,
 * a za pesmu ukupno preslušano vreme (pauza se ne računa).
 */
function utroseno(s: RedStavke): number {
  if (RUKOVAOCI[s.segment].meriSlusanje) return s.listened_ms + Math.max(0, s.playing_ms ?? 0);
  return s.elapsed_ms ?? 0;
}

// ───────────────────────── čitanje ─────────────────────────

async function ucitajStavke(db: Db, datum: string, playId: string | null): Promise<RedStavke[]> {
  const redovi = await db.query<RedStavke>(
    `select i.id::int as id, i.segment::int as segment, i.position::int as position, i.snapshot,
            (a.id is not null) as served,
            (a.answered_at is not null) as answered,
            (extract(epoch from (now() - a.served_at)) * 1000)::float8 as elapsed_ms,
            a.points::int as points, a.answer, a.answer_ms::int as answer_ms,
            coalesce(a.listened_ms, 0)::int as listened_ms,
            (extract(epoch from (now() - a.playing_since)) * 1000)::float8 as playing_ms
     from public.daily_quiz_items i
     join public.daily_quiz q on q.quiz_date = i.quiz_date and q.status = 'published'
     left join public.play_answers a on a.item_id = i.id and a.play_id = $2::uuid
     where i.quiz_date = $1::date
     order by i.segment, i.position`,
    [datum, playId],
  );
  // Segmenti koji još nemaju rukovaoca se preskaču.
  return redovi.filter((r) => RUKOVAOCI[r.segment]).map((r) => ({ ...r, answer: procitajJson(r.answer) }));
}

/**
 * Stariji odgovori su u bazi sačuvani kao JSON tekst unutar jsonb („"{\"unos\":220}"”),
 * jer je postgres drajver tekst sam još jednom pretvorio u JSON. Ovde se raspakuju, pa i stare igre
 * na kraju pokazuju šta je igrač odgovorio.
 */
function procitajJson(vrednost: unknown): unknown {
  if (typeof vrednost !== "string") return vrednost;
  try {
    return JSON.parse(vrednost);
  } catch {
    return vrednost;
  }
}

/**
 * Nalazi današnju igru za ovog igrača i zaključava je.
 * - ulogovan: igra njegovog naloga; ako je nema, preuzima gostujuću igru sa ovog uređaja
 * - gost: gostujuća igra sa ovog uređaja
 * Vraća `blokiran` kad je gost na uređaju sa kog je danas već igrao neki nalog.
 */
async function nadjiIgru(
  db: Db,
  ident: Identitet,
  datum: string,
): Promise<{ igra: RedIgre | null; blokiran: boolean }> {
  if (ident.userId) {
    const [svoja] = await db.query<RedIgre>(
      `select ${KOLONE_IGRE} from public.plays
       where quiz_date = $1::date and user_id = $2::uuid for update`,
      [datum, ident.userId],
    );
    if (svoja) {
      // Mejl je možda potvrđen u međuvremenu: igra „na čekanju” tada ulazi na listu.
      if (svoja.status === "finished" && svoja.lista !== "counted") svoja.lista = await upisiNaListu(db, svoja.id);
      return { igra: svoja, blokiran: false };
    }
  }

  const [gostujuca] = await db.query<RedIgre>(
    `select ${KOLONE_IGRE} from public.plays
     where quiz_date = $1::date and device_id = $2::uuid and user_id is null for update`,
    [datum, ident.deviceId],
  );
  if (gostujuca) {
    if (ident.userId) {
      // Igrač se prijavio usred igre (ili posle nje): igra postaje njegova, a završena ide na rang listu.
      await db.query(`update public.plays set user_id = $2::uuid where id = $1::uuid`, [gostujuca.id, ident.userId]);
      gostujuca.user_id = ident.userId;
      gostujuca.lista = await upisiNaListu(db, gostujuca.id);
    }
    return { igra: gostujuca, blokiran: false };
  }

  if (!ident.userId) {
    const [tudja] = await db.query<RedIgre>(
      `select ${KOLONE_IGRE} from public.plays
       where quiz_date = $1::date and device_id = $2::uuid and user_id is not null
       order by started_at desc limit 1`,
      [datum, ident.deviceId],
    );
    // Igrač je posle igre napravio nalog, ali mejl još nije potvrdio (pa ne može ni da se prijavi):
    // na uređaju na kom je igrao i dalje vidi svoj rezultat.
    if (tudja && tudja.status === "finished" && tudja.lista === "pending") return { igra: tudja, blokiran: false };
    if (tudja) return { igra: null, blokiran: true };
  }
  return { igra: null, blokiran: false };
}

/**
 * Posle registracije: završena gostujuća igra sa ovog uređaja postaje igra novog naloga i čeka potvrdu mejla.
 * (Novi nalog još nema sesiju, pa ovo ne može da sačeka prvu prijavu.) Igra u toku se ne dira:
 * nju preuzima prva prijava. Vraća broj preuzetih igara.
 */
export async function prikljuciZavrseneIgre(db: Db, userId: string, deviceId: string, datumi: string[]): Promise<number> {
  return db.transaction(async (tx) => {
    const redovi = await tx.query<{ id: string }>(
      `update public.plays p set user_id = $1::uuid
       where p.device_id = $2::uuid and p.user_id is null and p.status = 'finished' and p.quiz_date = any(string_to_array($3::text, ',')::date[])
         and not exists (select 1 from public.plays x where x.user_id = $1::uuid and x.quiz_date = p.quiz_date)
       returning p.id::text as id`,
      [userId, deviceId, datumi.join(",")],
    );
    for (const r of redovi) await upisiNaListu(tx, r.id);
    return redovi.length;
  });
}

// ───────────────────────── pomoćne ─────────────────────────

function pregledSegmenata(stavke: RedStavke[]): SegmentStanje[] {
  const brojevi = [...new Set(stavke.map((s) => s.segment))].sort((a, b) => a - b);
  return brojevi.map((n) => {
    const k = konfig(n);
    const svoje = stavke.filter((s) => s.segment === n);
    return {
      n,
      key: k.key,
      naziv: k.naziv,
      pravilo: k.pravilo,
      pitanja: svoje.length,
      odgovoreno: svoje.filter((s) => s.answered).length,
      poeni: svoje.reduce((z, s) => z + (s.points ?? 0), 0),
      tok: svoje
        .filter((s) => s.answered)
        .map((s): 0 | 1 | 2 => ((s.points ?? 0) >= RUKOVAOCI[n].maxPoena ? 2 : (s.points ?? 0) > 0 ? 1 : 0)),
      max: svoje.length * RUKOVAOCI[n].maxPoena,
      bonus: Boolean(k.bonus),
    };
  });
}

/**
 * Pitanje kome je vreme isteklo dok igrač nije bio tu (zatvoren tab, nema mreže) računa se kao netačno.
 * Kod pesme „vreme” je preslušano vreme: ako je ostala da svira do kraja klipa, pitanje je gotovo.
 */
async function zatvoriIstekla(db: Db, playId: string, stavke: RedStavke[]): Promise<boolean> {
  const tekuca = stavke.find((s) => !s.answered);
  if (!tekuca || !tekuca.served || tekuca.elapsed_ms === null) return false;
  const limit = limitMs(tekuca.segment);
  if (utroseno(tekuca) <= limit + TOLERANCIJA_MREZE_MS) return false;

  const slusanje = Boolean(RUKOVAOCI[tekuca.segment].meriSlusanje);
  const { sacuvaj } = RUKOVAOCI[tekuca.segment].oceni(tekuca.snapshot, null, { protekloMs: limit, istek: true });
  await db.query(
    `update public.play_answers
       set answered_at = case when $5::boolean then now() else served_at + ($3::int * interval '1 millisecond') end,
           answer = $4::text::jsonb, is_correct = false, points = 0, answer_ms = $3::int,
           listened_ms = case when $5::boolean then $3::int else listened_ms end, playing_since = null
     where play_id = $1::uuid and item_id = $2::int and answered_at is null`,
    [playId, tekuca.id, limit, JSON.stringify(sacuvaj), slusanje],
  );
  return true;
}

/** Posle svakog odgovora: prepiši zbir, a ako nema više pitanja, zatvori igru (i upiši je na rang listu ako ima nalog). */
async function osveziIgru(db: Db, playId: string, stavke: RedStavke[]): Promise<StanjeListe> {
  const sveOdgovoreno = stavke.length > 0 && stavke.every((s) => s.answered);
  const sledeca = stavke.find((s) => !s.answered);
  await db.query(
    `update public.plays p set
       score = coalesce((select sum(points) from public.play_answers where play_id = p.id), 0),
       total_answer_ms = coalesce((select sum(answer_ms) from public.play_answers where play_id = p.id), 0),
       current_segment = $2::int, current_position = $3::int,
       status = case when $4::boolean then 'finished' else p.status end,
       finished_at = case when $4::boolean and p.finished_at is null then now() else p.finished_at end
     where p.id = $1::uuid`,
    [playId, sledeca?.segment ?? stavke.at(-1)?.segment ?? 1, sledeca?.position ?? stavke.at(-1)?.position ?? 1, sveOdgovoreno],
  );
  return sveOdgovoreno ? upisiNaListu(db, playId) : "none";
}

function sastaviStanje(datum: string, igra: RedIgre | null, stavke: RedStavke[]): Stanje {
  const segmenti = pregledSegmenata(stavke);
  const osnova = {
    datum,
    score: segmenti.reduce((z, s) => z + s.poeni, 0),
    maxUkupno: MAX_UKUPNO,
    segmenti,
  };

  if (stavke.length === 0) return { ...osnova, status: "nema_kviza" };
  if (!igra) return { ...osnova, status: "nije_poceo" };

  const tekuca = stavke.find((s) => !s.answered);
  if (!tekuca) {
    const rezultat: StavkaRezultata[] = stavke.map((s) => {
      const r = RUKOVAOCI[s.segment];
      const prikaz = r.izSacuvanog(s.snapshot, s.answer);
      return {
        segment: s.segment,
        pozicija: s.position,
        poeni: s.points ?? 0,
        maxPoena: r.maxPoena,
        istek: bezOdgovora(prikaz),
        prikaz,
      };
    });
    return { ...osnova, status: "zavrseno", rezultat, lista: igra.lista };
  }

  const uSegmentu = stavke.filter((s) => s.segment === tekuca.segment);
  const trenutno: Trenutno = {
    itemId: tekuca.id,
    segment: tekuca.segment,
    pozicija: uSegmentu.indexOf(tekuca) + 1,
    ukupno: uSegmentu.length,
    faza: tekuca.served ? "pitanje" : uSegmentu.indexOf(tekuca) === 0 ? "uvod" : "sledece",
  };
  if (tekuca.served) {
    const limit = limitMs(tekuca.segment);
    trenutno.pitanje = RUKOVAOCI[tekuca.segment].javno(tekuca.snapshot);
    trenutno.limitMs = limit;
    trenutno.preostaloMs = Math.max(0, Math.round(limit - utroseno(tekuca)));
    if (RUKOVAOCI[tekuca.segment].meriSlusanje) trenutno.svira = tekuca.playing_ms !== null;
  }
  return { ...osnova, status: "u_toku", trenutno };
}

/** Učitaj sve, zatvori isteklo pitanje ako ga ima, i vrati sveže stanje. */
async function sveze(db: Db, ident: Identitet, datum: string) {
  const { igra, blokiran } = await nadjiIgru(db, ident, datum);
  let stavke = await ucitajStavke(db, datum, igra?.id ?? null);
  if (igra && igra.status === "in_progress") {
    if (await zatvoriIstekla(db, igra.id, stavke)) {
      stavke = await ucitajStavke(db, datum, igra.id);
      const lista = await osveziIgru(db, igra.id, stavke);
      if (stavke.every((s) => s.answered)) igra.lista = lista;
    }
  }
  return { igra, blokiran, stavke };
}

function blokirano(datum: string): Stanje {
  return { status: "uredjaj_igrao", datum, score: 0, maxUkupno: MAX_UKUPNO, segmenti: [] };
}

// ───────────────────────── javne funkcije ─────────────────────────

/** Gde je igrač stao. Zove se pri svakom otvaranju strane, pa osvežavanje nastavlja od istog pitanja. */
export function stanjeIgre(db: Db, ident: Identitet, datum: string): Promise<Stanje> {
  return db.transaction(async (tx) => {
    const { igra, blokiran, stavke } = await sveze(tx, ident, datum);
    if (blokiran) return blokirano(datum);
    return sastaviStanje(datum, igra, stavke);
  });
}

/** Počinje današnju igru. Ako već postoji, samo vraća stanje (nema druge igre istog dana). */
export function zapocniIgru(db: Db, ident: Identitet, datum: string): Promise<Stanje> {
  return db.transaction(async (tx) => {
    const { igra, blokiran, stavke } = await sveze(tx, ident, datum);
    if (blokiran) return blokirano(datum);
    if (igra || stavke.length === 0) return sastaviStanje(datum, igra, stavke);

    // Jedinstveni indeksi u bazi su poslednja odbrana od dve igre istog dana.
    const [nova] = await tx.query<RedIgre>(
      `insert into public.plays (quiz_date, user_id, device_id, current_segment, current_position)
       values ($1::date, $2::uuid, $3::uuid, $4::int, 1)
       on conflict do nothing
       returning ${KOLONE_IGRE}`,
      [datum, ident.userId, ident.deviceId, stavke[0].segment],
    );
    if (!nova) {
      // Neko je u istom trenutku napravio igru (drugi tab): uzmi tu.
      const ponovo = await sveze(tx, ident, datum);
      return sastaviStanje(datum, ponovo.igra, ponovo.stavke);
    }
    return sastaviStanje(datum, nova, stavke);
  });
}

/** Šalje tekuće pitanje i pokreće mu vreme (samo prvi put; ponovni poziv vraća isto pitanje i preostalo vreme). */
export function posaljiPitanje(db: Db, ident: Identitet, datum: string): Promise<Stanje> {
  return db.transaction(async (tx) => {
    const { igra, blokiran, stavke } = await sveze(tx, ident, datum);
    if (blokiran) return blokirano(datum);
    if (!igra || igra.status !== "in_progress") return sastaviStanje(datum, igra, stavke);

    const tekuca = stavke.find((s) => !s.answered);
    if (tekuca && !tekuca.served) {
      await tx.query(
        `insert into public.play_answers (play_id, item_id) values ($1::uuid, $2::int)
         on conflict (play_id, item_id) do nothing`,
        [igra.id, tekuca.id],
      );
    }
    return sastaviStanje(datum, igra, await ucitajStavke(tx, datum, igra.id));
  });
}

/**
 * Pesma: igrač je pustio ili pauzirao klip. Server po svom satu sabira preslušano vreme,
 * pa ono preživljava osvežavanje strane i ne zavisi od toga šta browser tvrdi.
 */
export function slusanje(db: Db, ident: Identitet, datum: string, ulaz: { itemId: number; pusteno: boolean }): Promise<Stanje> {
  return db.transaction(async (tx) => {
    const { igra, blokiran, stavke } = await sveze(tx, ident, datum);
    if (blokiran) return blokirano(datum);
    if (!igra || igra.status !== "in_progress") return sastaviStanje(datum, igra, stavke);

    const tekuca = stavke.find((s) => !s.answered);
    if (!tekuca || tekuca.id !== ulaz.itemId || !tekuca.served || !RUKOVAOCI[tekuca.segment].meriSlusanje) {
      return sastaviStanje(datum, igra, stavke);
    }
    if (ulaz.pusteno && tekuca.playing_ms === null) {
      await tx.query(`update public.play_answers set playing_since = now() where play_id = $1::uuid and item_id = $2::int`, [
        igra.id,
        tekuca.id,
      ]);
    } else if (!ulaz.pusteno && tekuca.playing_ms !== null) {
      await tx.query(
        `update public.play_answers
           set listened_ms = coalesce(listened_ms, 0) + greatest(0, (extract(epoch from (now() - playing_since)) * 1000)::int),
               playing_since = null
         where play_id = $1::uuid and item_id = $2::int`,
        [igra.id, tekuca.id],
      );
    }
    return sastaviStanje(datum, igra, await ucitajStavke(tx, datum, igra.id));
  });
}

/**
 * Odakle se pušta zvuk za pitanje. Vraća se samo za pitanje koje je ovom igraču već poslato,
 * pa niko ne može da „preslušava” pesme unapred.
 */
export function audioZaPitanje(db: Db, ident: Identitet, datum: string, itemId: number) {
  return db.transaction(async (tx) => {
    const { igra, blokiran } = await nadjiIgru(tx, ident, datum);
    if (blokiran || !igra) return null;
    const stavke = await ucitajStavke(tx, datum, igra.id);
    const stavka = stavke.find((s) => s.id === itemId && s.served);
    if (!stavka) return null;
    return RUKOVAOCI[stavka.segment].audio?.(stavka.snapshot) ?? null;
  });
}

export class GreskaIgre extends Error {
  constructor(
    public kod: "nema_igre" | "nije_na_redu" | "nije_poslato",
    poruka: string,
  ) {
    super(poruka);
  }
}

/**
 * Prima odgovor na tekuće pitanje, ocenjuje ga i pomera igru dalje.
 * Vreme meri server (od slanja pitanja do prijema odgovora), browseru se ne veruje.
 */
export function odgovori(
  db: Db,
  ident: Identitet,
  datum: string,
  ulaz: { itemId: number; odgovor: unknown; istek?: boolean; slusanoMs?: number },
): Promise<OdgovorServera> {
  return db.transaction(async (tx) => {
    const { igra, blokiran, stavke } = await sveze(tx, ident, datum);
    if (blokiran || !igra) throw new GreskaIgre("nema_igre", "Igra nije započeta.");

    const tekuca = stavke.find((s) => !s.answered);
    if (!tekuca || tekuca.id !== ulaz.itemId) {
      // Već odgovoreno (dupli klik, drugi tab) ili je vreme isteklo pa je pitanje zatvoreno.
      throw new GreskaIgre("nije_na_redu", "To pitanje više nije na redu.");
    }
    if (!tekuca.served || tekuca.elapsed_ms === null) {
      throw new GreskaIgre("nije_poslato", "Pitanje još nije poslato.");
    }

    const limit = limitMs(tekuca.segment);
    const rukovalac = RUKOVAOCI[tekuca.segment];
    const slusanje = Boolean(rukovalac.meriSlusanje);
    // `sveze` je već zatvorilo pitanja koja su prešla limit + toleranciju, pa je ovo u roku.
    const istek = Boolean(ulaz.istek);
    let proteklo = Math.max(0, Math.round(utroseno(tekuca)));
    if (slusanje && typeof ulaz.slusanoMs === "number" && Number.isFinite(ulaz.slusanoMs) && ulaz.slusanoMs >= 0) {
      // Server meri slušanje po svom satu, pa mu se zbog mreže potkrade koja desetinka više.
      // Veruje se plejeru u browseru, ali samo dok je unutar tolerancije: manje od (server − tolerancija) ne prolazi.
      proteklo = Math.max(Math.round(ulaz.slusanoMs), proteklo - TOLERANCIJA_MREZE_MS);
    }
    const protekloMs = Math.min(proteklo, limit);

    const { ocena, sacuvaj } = rukovalac.oceni(tekuca.snapshot, istek ? null : ulaz.odgovor, { protekloMs, istek });

    await tx.query(
      `update public.play_answers
         set answered_at = now(), answer = $3::text::jsonb, is_correct = $4::boolean, points = $5::int, answer_ms = $6::int,
             listened_ms = case when $7::boolean then $6::int else listened_ms end, playing_since = null
       where play_id = $1::uuid and item_id = $2::int and answered_at is null`,
      [igra.id, tekuca.id, JSON.stringify(sacuvaj), ocena.tacno, ocena.poeni, protekloMs, slusanje],
    );

    const posle = await ucitajStavke(tx, datum, igra.id);
    const lista = await osveziIgru(tx, igra.id, posle);

    const segmentGotov = posle.filter((s) => s.segment === tekuca.segment).every((s) => s.answered);
    const gotova = posle.every((s) => s.answered);
    const stanje = sastaviStanje(datum, { ...igra, status: gotova ? "finished" : "in_progress", lista: gotova ? lista : igra.lista }, posle);
    return {
      ocena,
      krajSegmenta: segmentGotov ? stanje.segmenti.find((s) => s.n === tekuca.segment) : undefined,
      stanje,
    };
  });
}
