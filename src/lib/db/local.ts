import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { ucitajProizvode } from "@/lib/content/products";
import { seedSql } from "@/lib/content/seed";
import { sopstveneSlike } from "@/lib/content/slike";
import { ucitajTrendove } from "@/lib/content/trends";
import { beogradskiDatum } from "@/lib/time";
import { omotajPglite, SUPABASE_ZAMENA } from "./pglite";
import type { Db } from "./types";

/**
 * Lokalna baza za razvoj: Postgres u memoriji sa pravom migracijom i seed-om od danas.
 * Briše se kad se server ugasi. Nalozi ovde ne postoje (to je Supabase Auth), pa se igra kao gost.
 */
export async function napraviLokalnuBazu(): Promise<Db> {
  const { PGlite } = await import("@electric-sql/pglite");
  const pg = new PGlite();
  await pg.exec(SUPABASE_ZAMENA);

  const dir = join(process.cwd(), "supabase", "migrations");
  for (const fajl of readdirSync(dir).filter((f) => f.endsWith(".sql")).sort()) {
    await pg.exec(readFileSync(join(dir, fajl), "utf8"));
  }

  const podaci = (ime: string) => JSON.parse(readFileSync(join(process.cwd(), "data", ime), "utf8"));
  const proizvodi = ucitajProizvode(podaci("products.json"), sopstveneSlike());
  const trendovi = ucitajTrendove(podaci("trends.json"));
  await pg.exec(
    seedSql({
      proizvodi: proizvodi.proizvodi,
      datumCenovnika: proizvodi.datumCenovnika,
      trendovi,
      pocetak: beogradskiDatum(),
      dana: 14,
    }),
  );

  console.log(
    `[lokalna baza] spremna: ${proizvodi.proizvodi.length} artikala, ${trendovi.pojmovi.length} pojmova za guglanje, kviz za 14 dana od ${beogradskiDatum()}`,
  );
  return omotajPglite(pg);
}
