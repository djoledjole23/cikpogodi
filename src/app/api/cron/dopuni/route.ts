import { readFileSync } from "node:fs";
import { join } from "node:path";
import { NextResponse, type NextRequest } from "next/server";
import { ucitajFilmove } from "@/lib/content/films";
import { ucitajJokere } from "@/lib/content/joker";
import { ucitajProizvode } from "@/lib/content/products";
import { seedSql } from "@/lib/content/seed";
import { postojeceSlikeJokera, postojeciKadrovi, sopstveneSlike } from "@/lib/content/slike";
import { ucitajPesme } from "@/lib/content/songs";
import { ucitajTrendove } from "@/lib/content/trends";
import { getDb } from "@/lib/db";
import { beogradskiDatum, dodajDane } from "@/lib/time";

/**
 * Dopunjava kviz da uvek ima pitanja bar HORIZONT dana unapred.
 * Vercel ga zove jednom dnevno (vidi `crons` u vercel.json) i šalje
 * zaglavlje `Authorization: Bearer <CRON_SECRET>`.
 *
 * Dan koji već ima pitanja se ne dira, pa je bezbedno pustiti ga koliko god puta.
 * Pitanja za jedan datum ne zavise od toga kad su napravljena (vidi SIDRO u lib/content/seed.ts),
 * pa ispadnu ista bez obzira na to da li ih upiše ovaj posao ili `npm run seed` sa računara.
 */

export const maxDuration = 60;

/** Koliko dana unapred kviz uvek mora da ima. */
const HORIZONT = 30;

export async function GET(request: NextRequest) {
  const tajna = process.env.CRON_SECRET;
  if (!tajna) return NextResponse.json({ greska: "CRON_SECRET nije podešen" }, { status: 503 });
  if (request.headers.get("authorization") !== `Bearer ${tajna}`) {
    return NextResponse.json({ greska: "nije dozvoljeno" }, { status: 401 });
  }

  const db = await getDb();
  if (!db) return NextResponse.json({ greska: "nema baze" }, { status: 503 });

  const danas = beogradskiDatum();
  const dokle = dodajDane(danas, HORIZONT);

  const [red] = await db.query<{ poslednji: string | null }>(
    "select max(quiz_date)::text as poslednji from public.daily_quiz",
  );
  const poslednji = red?.poslednji ?? null;
  // Kreni od dana posle poslednjeg upisanog, a ako je baza prazna ili zaostala — od danas.
  const pocetak = poslednji && poslednji >= danas ? dodajDane(poslednji, 1) : danas;
  if (pocetak > dokle) {
    return NextResponse.json({ ok: true, dana: 0, poslednjiDanUBazi: poslednji, poruka: "već ima dovoljno dana" });
  }

  const koren = process.cwd();
  const json = (ime: string) => JSON.parse(readFileSync(join(koren, "data", ime), "utf8"));
  const dana = Math.round((Date.parse(dokle) - Date.parse(pocetak)) / 86_400_000) + 1;

  const proizvodi = ucitajProizvode(json("products.json"), sopstveneSlike(koren));
  const pesme = ucitajPesme(json("songs.json"));
  const filmovi = ucitajFilmove(json("films.json"), postojeciKadrovi(koren));
  const jokeri = ucitajJokere(json("joker.json"), postojeceSlikeJokera(koren));

  const sql = seedSql({
    proizvodi: proizvodi.proizvodi,
    datumCenovnika: proizvodi.datumCenovnika,
    pesme: pesme.pesme,
    filmovi: filmovi.filmovi,
    jokeri: jokeri.pitanja,
    trendovi: ucitajTrendove(json("trends.json")),
    pocetak,
    dana,
  });

  await db.exec(sql);

  const [posle] = await db.query<{ poslednji: string | null }>(
    "select max(quiz_date)::text as poslednji from public.daily_quiz",
  );
  const [saJokerom] = await db.query<{ n: number }>(
    `select count(*)::int as n from public.daily_quiz_items where segment = 5 and quiz_date >= '${danas}'::date`,
  );
  console.log(`[cron] dopunjeno od ${pocetak} do ${dokle} (${dana} dana)`);
  return NextResponse.json({
    ok: true,
    od: pocetak,
    do: dokle,
    dana,
    poslednjiDanUBazi: posle?.poslednji ?? null,
    danaSaJokerom: saJokerom?.n ?? 0,
  });
}
