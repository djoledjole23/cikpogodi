/**
 * Pravi SQL koji u Supabase upisuje artikle i dnevni kviz (za sada segment „Pogodi cenu”).
 *
 *   npm run seed                      → 14 dana od sutra (po beogradskom vremenu)
 *   npm run seed -- 2026-12-01 30     → 30 dana od 1. decembra
 *
 * Rezultat je fajl u supabase/seed/. Otvori ga, nalepi u Supabase → SQL Editor i klikni Run.
 * Bezbedno je pustiti ga više puta: dan koji već ima pitanja se ne dira.
 */
import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import { ucitajProizvode } from "../src/lib/content/products";
import { planCena, seedSql } from "../src/lib/content/seed";
import { beogradskiDatum, dodajDane } from "../src/lib/time";

const [, , argDatum, argDana] = process.argv;
const pocetak = argDatum ?? dodajDane(beogradskiDatum(), 1);
const dana = Number(argDana ?? 14);
if (!/^\d{4}-\d{2}-\d{2}$/.test(pocetak) || !Number.isInteger(dana) || dana < 1 || dana > 366) {
  console.error("Upotreba: npm run seed -- YYYY-MM-DD <broj dana>");
  process.exit(1);
}

const koren = join(__dirname, "..");
const ucitani = ucitajProizvode(JSON.parse(readFileSync(join(koren, "data", "products.json"), "utf8")));
const sql = seedSql({ proizvodi: ucitani.proizvodi, datumCenovnika: ucitani.datumCenovnika, pocetak, dana });

const dir = join(koren, "supabase", "seed");
mkdirSync(dir, { recursive: true });
const fajl = join(dir, `seed-${pocetak}-${dana}d.sql`);
writeFileSync(fajl, `-- Čik Pogodi! seed: ${dana} dana od ${pocetak}. Cenovnik od ${ucitani.datumCenovnika}.\n-- Napravljeno komandom: npm run seed -- ${pocetak} ${dana}\n\n${sql}`);

console.log(`Artikala u igri (imaju sliku i cenu): ${ucitani.proizvodi.length}`);
if (ucitani.izbaceni.length) {
  console.log(`Izbačeno: ${ucitani.izbaceni.length}`);
  for (const x of ucitani.izbaceni) console.log(`  - ${x.naziv}: ${x.razlog}`);
}
const plan = planCena(ucitani.proizvodi, pocetak, dana);
console.log(`\nKviz: ${plan[0].datum} → ${plan.at(-1)!.datum}`);
console.log(`Primer (${plan[0].datum}): ${plan[0].artikli.map((a) => `${a.naziv} ${a.kolicina}`).join(", ")}`);
console.log(`\nSQL je u: ${fajl}\nNalepi ga u Supabase → SQL Editor → Run.`);
