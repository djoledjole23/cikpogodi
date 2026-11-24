import { NextResponse, type NextRequest } from "next/server";
import { nadjiKlip } from "@/lib/audio";
import { getDb } from "@/lib/db";
import type { Db } from "@/lib/db/types";
import type { SnapshotPesma } from "@/lib/game/segments/pesma";
import { beogradskiDatum, dodajDane } from "@/lib/time";

/**
 * Svake večeri proverava da li pesme za danas i naredne dane imaju klip od 30 s.
 * - Ako zapamćeni Deezer/iTunes ID više nema klip, a ista pesma se nađe po izvođaču i naslovu,
 *   novi ID se upiše uz pitanje i u katalog pesama.
 * - Ako pesme nigde nema, a pitanje još niko nije dobio, pesma se zameni drugom koja ima klip
 *   i nije korišćena u poslednjih/narednih 60 dana.
 * Vercel ga zove po rasporedu iz vercel.json, uz `Authorization: Bearer <CRON_SECRET>`.
 * Izveštaj je u odgovoru i u Vercel logovima („[klipovi]”).
 */

export const maxDuration = 60;

/** Koliko dana unapred (uključujući danas) se proverava. */
const DANA = 4;

type Stavka = { id: number; quiz_date: string; position: number; snapshot: SnapshotPesma | string; dobili: number };
type Pesma = { id: number; artist: string; title: string; aliases: string[] | null; deezer_id: number | null; itunes_id: number | null; cover_url: string | null };

const procitaj = (s: SnapshotPesma | string): SnapshotPesma => (typeof s === "string" ? (JSON.parse(s) as SnapshotPesma) : s);

async function zamena(db: Db, danas: string): Promise<{ pesma: Pesma; deezerId: number | null; itunesId: number | null } | null> {
  const kandidati = await db.query<Pesma>(
    `select s.id::int as id, s.artist, s.title, s.aliases, s.deezer_id::float8 as deezer_id, s.itunes_id::float8 as itunes_id, s.cover_url
     from public.songs s
     where s.active and not exists (
       select 1 from public.daily_quiz_items i
       where i.segment = 1 and i.song_id = s.id and i.quiz_date between ($1::date - 60) and ($1::date + 60))
     order by random() limit 15`,
    [danas],
  );
  for (const p of kandidati) {
    const k = await nadjiKlip({ deezerId: p.deezer_id, itunesId: p.itunes_id, izvodjac: p.artist, naslov: p.title });
    if (k) return { pesma: p, deezerId: k.deezerId, itunesId: k.itunesId };
  }
  return null;
}

export async function GET(request: NextRequest) {
  const tajna = process.env.CRON_SECRET;
  if (!tajna) return NextResponse.json({ greska: "CRON_SECRET nije podešen" }, { status: 503 });
  if (request.headers.get("authorization") !== `Bearer ${tajna}`) {
    return NextResponse.json({ greska: "nije dozvoljeno" }, { status: 401 });
  }
  const db = await getDb();
  if (!db) return NextResponse.json({ greska: "nema baze" }, { status: 503 });

  const danas = beogradskiDatum();
  const stavke = await db.query<Stavka>(
    `select i.id::int as id, i.quiz_date::text as quiz_date, i.position::int as position, i.snapshot,
            (select count(*)::int from public.play_answers a where a.item_id = i.id) as dobili
     from public.daily_quiz_items i
     where i.segment = 1 and i.quiz_date between $1::date and $2::date
     order by i.quiz_date, i.position`,
    [danas, dodajDane(danas, DANA - 1)],
  );

  const izvestaj: { datum: string; mesto: number; pesma: string; ishod: string }[] = [];
  let ispravno = 0;
  for (const st of stavke) {
    const s = procitaj(st.snapshot);
    const ime = `${s.izvodjac} – ${s.naslov}`;
    const k = await nadjiKlip({ deezerId: s.deezerId ?? null, itunesId: s.itunesId ?? null, izvodjac: s.izvodjac, naslov: s.naslov });
    if (k && !k.pretraga) { ispravno++; continue; }

    if (k) {
      const novi = { ...s, deezerId: k.deezerId, itunesId: k.itunesId };
      await db.query("update public.daily_quiz_items set snapshot = $2::text::jsonb where id = $1", [st.id, JSON.stringify(novi)]);
      if (s.songId) {
        await db.query("update public.songs set deezer_id = $2, itunes_id = $3 where id = $1 and not exists (select 1 from public.songs x where x.id <> $1 and x.deezer_id = $2)", [s.songId, k.deezerId, k.itunesId]).catch(() => undefined);
      }
      izvestaj.push({ datum: st.quiz_date, mesto: st.position, pesma: ime, ishod: `novi izvor (deezer ${k.deezerId ?? "-"}, itunes ${k.itunesId ?? "-"})` });
      continue;
    }

    if (st.dobili > 0) {
      izvestaj.push({ datum: st.quiz_date, mesto: st.position, pesma: ime, ishod: "NEMA KLIPA, a igrači su već dobili ovo pitanje — ostavljeno" });
      continue;
    }
    const z = await zamena(db, danas);
    if (!z) {
      izvestaj.push({ datum: st.quiz_date, mesto: st.position, pesma: ime, ishod: "NEMA KLIPA i nije nađena zamena" });
      continue;
    }
    const p = z.pesma;
    const snapshot: SnapshotPesma = {
      songId: p.id, izvodjac: p.artist, naslov: p.title, alias: p.aliases ?? [],
      deezerId: z.deezerId, itunesId: z.itunesId, omot: p.cover_url ?? s.omot,
    };
    await db.query(
      "update public.daily_quiz_items set song_id = $2, snapshot = $3::text::jsonb where id = $1 and not exists (select 1 from public.play_answers a where a.item_id = $1)",
      [st.id, p.id, JSON.stringify(snapshot)],
    );
    if (s.songId) await db.query("update public.songs set active = false where id = $1", [s.songId]);
    izvestaj.push({ datum: st.quiz_date, mesto: st.position, pesma: ime, ishod: `zamenjena: ${p.artist} – ${p.title}` });
  }

  const odgovor = { ok: true, provereno: stavke.length, ispravno, izmene: izvestaj };
  console.log("[klipovi]", JSON.stringify(odgovor));
  return NextResponse.json(odgovor);
}
