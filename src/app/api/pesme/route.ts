import { connection, NextResponse } from "next/server";
import { getDb } from "@/lib/db";

/**
 * Katalog pesama za biranje odgovora u „Pogodi pesmu”: ceo spisak, pa ne odaje šta je u današnjem kvizu.
 * Red je [id, izvođač, naslov].
 */
export async function GET() {
  // Katalog se čita iz baze pri svakom zahtevu (ne „peče” se u vreme builda), pa nova pesma iz admina odmah važi.
  await connection();
  const db = await getDb();
  if (!db) return NextResponse.json({ pesme: [] });
  const redovi = await db.query<{ id: number; artist: string; title: string }>(
    `select id::int as id, artist, title from public.songs where active order by artist, title`,
  );
  return NextResponse.json(
    { pesme: redovi.map((r) => [r.id, r.artist, r.title]) },
    { headers: { "cache-control": "private, max-age=600" } },
  );
}
