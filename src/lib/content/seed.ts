import { SEGMENTI } from "@/config/quiz.config";
import { dodajDane } from "@/lib/time";
import { normalizuj } from "@/lib/match";
import type { Proizvod } from "./products";
import { ZANROVI, type Pesma, type Zanr } from "./songs";
import { ferDuel, napraviPar, type Par, type Pojam, type UcitaniTrendovi } from "./trends";

/**
 * Raspored artikala po danima i SQL koji ga upisuje.
 * Isti kod puni lokalnu bazu i pravi fajl za Supabase (`npm run seed`).
 * Raspored zavisi samo od datuma i spiska artikala, pa svako pokretanje daje isto.
 */

const PO_DANU = SEGMENTI.find((s) => s.key === "cena")!.pitanja;
const PAROVA_PO_DANU = SEGMENTI.find((s) => s.key === "gugla")!.pitanja;
const PESAMA_PO_DANU = SEGMENTI.find((s) => s.key === "pesma")!.pitanja;
const NAJVISE_PO_KATEGORIJI = 4;

/** Mali generator slučajnih brojeva sa semenom (mulberry32): isti datum → isti izbor. */
function slucajni(seme: number) {
  let a = seme >>> 0;
  return () => {
    a = (a + 0x6d2b79f5) >>> 0;
    let t = a;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

function semeIzTeksta(tekst: string): number {
  let h = 2166136261;
  for (let i = 0; i < tekst.length; i++) {
    h ^= tekst.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return h >>> 0;
}

export type DnevniPlan = { datum: string; artikli: Proizvod[] };

/**
 * Za svaki dan bira 10 artikala:
 * prvo oni koji su najmanje puta bili, bez istog naziva dvaput u danu (npr. dva Smokija),
 * najviše 4 iz iste kategorije i, kad može, bez ponavljanja od juče.
 */
export function planCena(proizvodi: Proizvod[], pocetak: string, dana: number): DnevniPlan[] {
  if (proizvodi.length < PO_DANU) {
    throw new Error(`Za dnevni kviz treba bar ${PO_DANU} artikala sa slikom i cenom, a ima ih ${proizvodi.length}.`);
  }
  const koriscen = new Map<string, number>(proizvodi.map((p) => [p.barkod, 0]));
  let juce = new Set<string>();
  const plan: DnevniPlan[] = [];

  for (let d = 0; d < dana; d++) {
    const datum = dodajDane(pocetak, d);
    const rnd = slucajni(semeIzTeksta(`cena:${datum}`));
    const kandidati = proizvodi
      .map((p) => ({ p, kljuc: rnd() }))
      .sort((a, b) => koriscen.get(a.p.barkod)! - koriscen.get(b.p.barkod)! || a.kljuc - b.kljuc)
      .map((x) => x.p);

    const izabrani: Proizvod[] = [];
    const nazivi = new Set<string>();
    const poKategoriji = new Map<string, number>();
    // Tri prolaza: prvo sva pravila, pa bez pravila „nije bio juče”, pa bez ograničenja po kategoriji.
    for (const prolaz of [0, 1, 2]) {
      for (const p of kandidati) {
        if (izabrani.length === PO_DANU) break;
        if (izabrani.includes(p) || nazivi.has(p.naziv)) continue;
        if (prolaz === 0 && juce.has(p.barkod)) continue;
        if (prolaz < 2 && (poKategoriji.get(p.kategorija) ?? 0) >= NAJVISE_PO_KATEGORIJI) continue;
        izabrani.push(p);
        nazivi.add(p.naziv);
        poKategoriji.set(p.kategorija, (poKategoriji.get(p.kategorija) ?? 0) + 1);
      }
    }
    if (izabrani.length < PO_DANU) throw new Error(`Nema dovoljno različitih artikala za ${datum}.`);

    // Redosled u igri: promešano, da ne idu uvek najređe korišćeni prvi.
    const redosled = izabrani.map((p) => ({ p, kljuc: rnd() })).sort((a, b) => a.kljuc - b.kljuc).map((x) => x.p);
    for (const p of redosled) koriscen.set(p.barkod, koriscen.get(p.barkod)! + 1);
    juce = new Set(redosled.map((p) => p.barkod));
    plan.push({ datum, artikli: redosled });
  }
  return plan;
}

export type DnevniPlanGugla = { datum: string; dueli: Par[] };

/** Koliko puta u danu izazivač treba da pobedi (da „uvek tapni šampiona” ne bude taktika). */
const POBEDE_IZAZIVACA = { cilj: 4, najmanje: 3, najvise: 5 };

/**
 * Za svaki dan pravi lanac od 8 duela u kome pobednik ostaje:
 * pojam koji se više gugla ostaje na svom mestu (gore ili dole), a na mesto gubitnika dolazi novi izazivač.
 * Svih 9 pojmova u danu je iz različitih tema, svaki duel ima jasnog pobednika (vidi `ferDuel`)
 * i nijedan duel se ne ponavlja u celom periodu.
 */
export function planGugla(
  trendovi: Pick<UcitaniTrendovi, "pojmovi" | "period" | "preuzeto">,
  pocetak: string,
  dana: number,
): DnevniPlanGugla[] {
  const { pojmovi, period, preuzeto } = trendovi;
  const kljuc = (x: Pojam, y: Pojam) => [x.upit, y.upit].sort().join("|");
  const iskoriscenDuel = new Set<string>();
  const koriscen = new Map<string, number>(pojmovi.map((p) => [p.upit, 0]));
  const plan: DnevniPlanGugla[] = [];

  for (let d = 0; d < dana; d++) {
    const datum = dodajDane(pocetak, d);
    let dueli: { gore: Pojam; dole: Pojam }[] | null = null;

    for (let pokusaj = 0; pokusaj < 400 && !dueli; pokusaj++) {
      const rnd = slucajni(semeIzTeksta(`gugla:${datum}:${pokusaj}`));
      // Najređe korišćeni pojmovi idu prvi, uz malo slučajnosti.
      const poRedu = (lista: Pojam[]) =>
        lista.map((p) => ({ p, k: koriscen.get(p.upit)! + rnd() * 0.9 })).sort((x, y) => x.k - y.k).map((x) => x.p);

      // Prvi pojam: iz slabije polovine, da lanac ima kuda da raste.
      const poJacini = [...pojmovi].sort((x, y) => x.jacina - y.jacina);
      let sampion = poRedu(poJacini.slice(0, Math.ceil(poJacini.length * 0.55)))[0];
      let sampionGore = rnd() < 0.5;
      const teme = new Set([sampion.tema]);
      const lanac: { gore: Pojam; dole: Pojam }[] = [];
      let pobede = 0;

      for (let k = 0; k < PAROVA_PO_DANU; k++) {
        const kandidati = pojmovi.filter((p) => !teme.has(p.tema) && ferDuel(sampion, p) && !iskoriscenDuel.has(kljuc(sampion, p)));
        const jaci = poRedu(kandidati.filter((p) => p.jacina > sampion.jacina));
        const slabiji = poRedu(kandidati.filter((p) => p.jacina < sampion.jacina));
        const zeliPobedu = rnd() < (POBEDE_IZAZIVACA.cilj - pobede) / (PAROVA_PO_DANU - k);
        const izbor = zeliPobedu ? (jaci[0] ?? slabiji[0]) : (slabiji[0] ?? jaci[0]);
        if (!izbor) break;
        lanac.push(sampionGore ? { gore: sampion, dole: izbor } : { gore: izbor, dole: sampion });
        teme.add(izbor.tema);
        if (izbor.jacina > sampion.jacina) {
          sampion = izbor;
          sampionGore = !sampionGore;
          pobede++;
        }
      }
      if (lanac.length === PAROVA_PO_DANU && pobede >= POBEDE_IZAZIVACA.najmanje && pobede <= POBEDE_IZAZIVACA.najvise) dueli = lanac;
    }
    if (!dueli) throw new Error(`Ne mogu da složim lanac duela za ${datum}: treba još pojmova u trends.json.`);

    for (const x of dueli) iskoriscenDuel.add(kljuc(x.gore, x.dole));
    for (const p of new Set(dueli.flatMap((x) => [x.gore, x.dole]))) koriscen.set(p.upit, koriscen.get(p.upit)! + 1);
    plan.push({ datum, dueli: dueli.map((x) => napraviPar(x.gore, x.dole, period, preuzeto)) });
  }
  return plan;
}

export type DnevniPlanPesama = { datum: string; pesme: Pesma[] };

/**
 * Za svaki dan bira 5 pesama, po malo od svega: po jedna folk, rok, pop i trep,
 * a peta je svaki dan iz drugog žanra (folk, rok, pop, pa ukrug).
 * U jednom danu se nijedan izvođač ne javlja dvaput (ni kao gost na tuđoj pesmi).
 * Pesme sa spiska vlasnika sajta (prioritet) idu pre ostalih, a pesma se ne ponavlja
 * dok ima neiskorišćenih u tom žanru.
 */
export function planPesama(pesme: Pesma[], pocetak: string, dana: number): DnevniPlanPesama[] {
  const koriscena = new Map<number, number>(pesme.map((p) => [p.deezerId, 0]));
  const peti: Zanr[] = ["folk", "rok", "pop"];
  const plan: DnevniPlanPesama[] = [];

  for (let d = 0; d < dana; d++) {
    const datum = dodajDane(pocetak, d);
    const rnd = slucajni(semeIzTeksta(`pesma:${datum}`));
    const kljuc = new Map(pesme.map((p) => [p.deezerId, rnd()]));
    // Najmanje puta korišćene prve; među njima prvo one sa prioritetom, pa nasumično.
    const poRedu = [...pesme].sort(
      (a, b) =>
        koriscena.get(a.deezerId)! - koriscena.get(b.deezerId)! ||
        Number(b.prioritet) - Number(a.prioritet) ||
        kljuc.get(a.deezerId)! - kljuc.get(b.deezerId)!,
    );

    const izabrane: Pesma[] = [];
    const zauzeti = new Set<string>();
    const uzmi = (zanr: Zanr | null) => {
      const p = poRedu.find(
        (x) => !izabrane.includes(x) && (zanr === null || x.zanr === zanr) && x.izvodjaci.every((i) => !zauzeti.has(normalizuj(i))),
      );
      if (!p) return false;
      izabrane.push(p);
      for (const i of p.izvodjaci) zauzeti.add(normalizuj(i));
      return true;
    };

    for (const zanr of [...ZANROVI, peti[d % peti.length]]) {
      if (izabrane.length < PESAMA_PO_DANU && !uzmi(zanr)) uzmi(null); // žanr je ispražnjen: uzmi bilo koju
    }
    while (izabrane.length < PESAMA_PO_DANU && uzmi(null));
    if (izabrane.length < PESAMA_PO_DANU) throw new Error(`Nema dovoljno pesama različitih izvođača za ${datum}.`);

    const redosled = izabrane.map((p) => ({ p, k: rnd() })).sort((a, b) => a.k - b.k).map((x) => x.p);
    for (const p of redosled) koriscena.set(p.deezerId, koriscena.get(p.deezerId)! + 1);
    plan.push({ datum, pesme: redosled });
  }
  return plan;
}

/** SQL tekst u jednostrukim navodnicima. */
const q = (s: string) => `'${s.replace(/'/g, "''")}'`;

/** Ono što se zamrzava uz pitanje: cena na dan kviza i sve što treba za prikaz rezultata. */
export function snapshotCena(p: Proizvod, datumCenovnika: string) {
  return {
    naziv: p.naziv,
    kolicina: p.kolicina,
    slika: p.slika,
    cena: p.cena,
    min: p.cenaMin,
    max: p.cenaMax,
    najjeftinije: p.najjeftinijeU,
    datumCenovnika,
  };
}

/** Ono što se zamrzava uz pitanje „Šta se više gugla”. */
export function snapshotGugla(p: Par) {
  return { a: p.a, b: p.b, indeksA: p.indeksA, indeksB: p.indeksB, period: p.period, preuzeto: p.preuzeto };
}

/** Ono što se zamrzava uz pitanje „Pogodi pesmu” (broj pesme u bazi dodaje sam SQL). */
export function snapshotPesma(p: Pesma) {
  return { izvodjac: p.izvodjac, naslov: p.naslov, alias: p.alias, deezerId: p.deezerId, itunesId: p.itunesId, omot: p.omot };
}

export function seedSql(opcije: {
  proizvodi: Proizvod[];
  datumCenovnika: string;
  /** Katalog pesama za „Pogodi pesmu”. Bez njega se segment 1 ne pravi. */
  pesme?: Pesma[];
  /** Pojmovi za „Šta se više gugla”. Bez njih se pravi samo segment 2. */
  trendovi?: Pick<UcitaniTrendovi, "pojmovi" | "period" | "preuzeto">;
  pocetak: string;
  dana: number;
}): string {
  const { proizvodi, datumCenovnika, pesme, trendovi, pocetak, dana } = opcije;
  const redovi: string[] = [];

  if (pesme?.length) {
    redovi.push(
      "-- Isto što i migracija 0003: ponovljeno ovde da seed radi i ako ona nije puštena.",
      "alter table public.songs add column if not exists genre text;",
      "alter table public.play_answers add column if not exists playing_since timestamptz;",
      "",
      "-- Katalog pesama (songs.json). Postojeće se osvežavaju po Deezer ID-u.",
    );
    for (const p of pesme) {
      const alias = p.alias.length ? `array[${p.alias.map(q).join(", ")}]::text[]` : "'{}'::text[]";
      redovi.push(
        `insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values (${q(p.izvodjac)}, ${q(p.naslov)}, ${alias}, ${p.deezerId}, ${p.itunesId ?? "null"}, ${q(p.omot)}, ${q(p.zanr)})
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;`,
      );
    }
    redovi.push("", "-- Dnevni kviz: segment 1 (Pogodi pesmu). Dan koji već ima stavke se ne dira.");
    for (const dan of planPesama(pesme, pocetak, dana)) {
      redovi.push(
        `insert into public.daily_quiz (quiz_date, status, published_at) values (${q(dan.datum)}, 'published', now())
  on conflict (quiz_date) do nothing;`,
      );
      dan.pesme.forEach((p, i) => {
        redovi.push(
          `insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select ${q(dan.datum)}, 1, ${i + 1}, id, ${q(JSON.stringify(snapshotPesma(p)))}::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = ${p.deezerId}
  on conflict (quiz_date, segment, position) do nothing;`,
        );
      });
    }
    redovi.push("");
  }

  redovi.push("-- Artikli (products.json). Postojeći se osvežavaju po barkodu.");
  for (const p of proizvodi) {
    redovi.push(
      `insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values (${q(p.barkod)}, ${q(p.naziv)}, ${q(p.kolicina)}, ${q(p.slika)}, ${p.cenaTacna}, ${p.cenaMin}, ${p.cenaMax}, ${q(p.najjeftinijeU)}, ${q(datumCenovnika)})
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();`,
    );
  }

  redovi.push("", "-- Dnevni kviz: segment 2 (Pogodi cenu). Dan koji već ima stavke se ne dira.");
  for (const dan of planCena(proizvodi, pocetak, dana)) {
    redovi.push(
      `insert into public.daily_quiz (quiz_date, status, published_at) values (${q(dan.datum)}, 'published', now())
  on conflict (quiz_date) do nothing;`,
    );
    dan.artikli.forEach((p, i) => {
      redovi.push(
        `insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select ${q(dan.datum)}, 2, ${i + 1}, id, ${q(JSON.stringify(snapshotCena(p, datumCenovnika)))}::jsonb
  from public.products where barcode = ${q(p.barkod)}
  on conflict (quiz_date, segment, position) do nothing;`,
      );
    });
  }

  if (trendovi) {
    const plan = planGugla(trendovi, pocetak, dana);
    redovi.push(
      "",
      "-- Isto što i migracija 0002: ponovljeno ovde da seed radi i ako ona nije puštena.",
      "create unique index if not exists trend_pairs_par_idx on public.trend_pairs (term_a, term_b, period);",
      "",
      "-- Dueli pojmova (trends.json). Postojeći se osvežavaju.",
    );
    for (const p of plan.flatMap((dan) => dan.dueli)) {
      redovi.push(
        `insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values (${q(p.a)}, ${q(p.b)}, ${p.indeksA}, ${p.indeksB}, ${q(p.period)}, ${q(p.preuzeto)})
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;`,
      );
    }
    redovi.push("", "-- Dnevni kviz: segment 3 (Šta se više gugla). Pobednik duela ostaje i u sledećem.");
    for (const dan of plan) {
      redovi.push(
        `insert into public.daily_quiz (quiz_date, status, published_at) values (${q(dan.datum)}, 'published', now())
  on conflict (quiz_date) do nothing;`,
      );
      dan.dueli.forEach((p, i) => {
        redovi.push(
          `insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select ${q(dan.datum)}, 3, ${i + 1}, id, ${q(JSON.stringify(snapshotGugla(p)))}::jsonb
  from public.trend_pairs where term_a = ${q(p.a)} and term_b = ${q(p.b)} and period = ${q(p.period)}
  on conflict (quiz_date, segment, position) do nothing;`,
        );
      });
    }
  }
  return redovi.join("\n") + "\n";
}
