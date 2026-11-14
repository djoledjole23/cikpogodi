import "server-only";
import type { Db } from "./types";

export type { Db } from "./types";

/**
 * Veza sa bazom za serverski kod igre.
 *
 * - Produkcija: `DATABASE_URL` (Supabase → Connect → Transaction pooler). Ide pravo na Postgres,
 *   pa ceo odgovor na pitanje može da bude jedna transakcija.
 * - Razvoj bez Supabase-a: ako `DATABASE_URL` nije podešen, pravi se Postgres u memoriji (PGlite)
 *   sa istom migracijom i seed-om, pa igra radi i lokalno. U produkciji se to pali samo uz
 *   `CP_LOKALNA_BAZA=1` (koristi se za proveru build-a, nikad na pravom sajtu).
 *
 * Vraća null kad baze nema: igra tada javlja da nije povezana.
 */

type Kes = { db?: Promise<Db | null> };
const kes = globalThis as unknown as { __cpDb?: Kes };

/**
 * Da li igra radi na privremenoj bazi u memoriji (nema DATABASE_URL).
 * Tada nalozi i igra ne mogu da se spoje: u toj bazi nema naloga, pa se igra uvek vodi kao gost.
 */
export function privremenaBaza(): boolean {
  return !process.env.DATABASE_URL;
}

export function bazaPodesena(): boolean {
  return Boolean(process.env.DATABASE_URL) || lokalnaDozvoljena();
}

function lokalnaDozvoljena(): boolean {
  return process.env.NODE_ENV !== "production" || process.env.CP_LOKALNA_BAZA === "1";
}

export function getDb(): Promise<Db | null> {
  kes.__cpDb ??= {};
  kes.__cpDb.db ??= napravi();
  return kes.__cpDb.db;
}

async function napravi(): Promise<Db | null> {
  const url = process.env.DATABASE_URL;
  if (url) {
    const { napraviPostgres } = await import("./postgres");
    return napraviPostgres(url);
  }
  if (lokalnaDozvoljena()) {
    const { napraviLokalnuBazu } = await import("./local");
    return napraviLokalnuBazu();
  }
  return null;
}
