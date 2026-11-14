import { connection, NextResponse } from "next/server";
import katalogJson from "../../../../data/katalog.json";
import { spojiKatalog, ucitajKatalog } from "@/lib/content/katalog";
import { getDb } from "@/lib/db";

/** Dodatne pesme (ne puštaju se, samo otežavaju izbor): čitaju se jednom, pri prvom zahtevu. */
let dodatne: ReturnType<typeof ucitajKatalog> | null = null;

/**
 * Spisak pesama za biranje odgovora u „Pogodi pesmu”: pesme iz kviza pomešane sa nekoliko hiljada drugih,
 * bez ikakve oznake koja je koja, pa spisak ne odaje ni šta je danas u kvizu ni šta se uopšte pušta.
 * Oblik: { izvodjaci: [[izvođač, [naslovi]], …] }.
 */
export async function GET() {
  // Pesme iz kviza se čitaju iz baze pri svakom zahtevu (ne „peku” se u vreme builda), pa nova pesma iz admina odmah važi.
  await connection();
  const db = await getDb();
  if (!db) return NextResponse.json({ izvodjaci: [] });
  const redovi = await db.query<{ artist: string; title: string }>(`select artist, title from public.songs where active`);
  dodatne ??= ucitajKatalog(katalogJson);
  return NextResponse.json(
    { izvodjaci: spojiKatalog(redovi, dodatne) },
    { headers: { "cache-control": "private, max-age=600" } },
  );
}
