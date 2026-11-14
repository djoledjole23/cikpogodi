/**
 * Pravi SQL koji u Supabase upisuje artikle, parove pojmova i dnevni kviz
 * (za sada segmenti „Pogodi cenu” i „Šta se više gugla”).
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
import { ucitajFilmove } from "../src/lib/content/films";
import { ucitajJokere } from "../src/lib/content/joker";
import { planCena, planFilmova, planGugla, planPesama, seedSql } from "../src/lib/content/seed";
import { postojeceSlikeJokera, postojeciKadrovi, sopstveneSlike } from "../src/lib/content/slike";
import { ucitajPesme } from "../src/lib/content/songs";
import { ucitajTrendove } from "../src/lib/content/trends";
import { beogradskiDatum, dodajDane } from "../src/lib/time";

const [, , argDatum, argDana] = process.argv;
const pocetak = argDatum ?? dodajDane(beogradskiDatum(), 1);
const dana = Number(argDana ?? 14);
if (!/^\d{4}-\d{2}-\d{2}$/.test(pocetak) || !Number.isInteger(dana) || dana < 1 || dana > 366) {
  console.error("Upotreba: npm run seed -- YYYY-MM-DD <broj dana>");
  process.exit(1);
}

const koren = join(__dirname, "..");
const slike = sopstveneSlike(koren);
const ucitani = ucitajProizvode(JSON.parse(readFileSync(join(koren, "data", "products.json"), "utf8")), slike);
const trendovi = ucitajTrendove(JSON.parse(readFileSync(join(koren, "data", "trends.json"), "utf8")));
const pesme = ucitajPesme(JSON.parse(readFileSync(join(koren, "data", "songs.json"), "utf8")));
const filmovi = ucitajFilmove(JSON.parse(readFileSync(join(koren, "data", "films.json"), "utf8")), postojeciKadrovi(koren));
const jokeri = ucitajJokere(JSON.parse(readFileSync(join(koren, "data", "joker.json"), "utf8")), postojeceSlikeJokera(koren));
const sql = seedSql({ proizvodi: ucitani.proizvodi, datumCenovnika: ucitani.datumCenovnika, pesme: pesme.pesme, filmovi: filmovi.filmovi, jokeri: jokeri.pitanja, trendovi, pocetak, dana });

const dir = join(koren, "supabase", "seed");
mkdirSync(dir, { recursive: true });
const fajl = join(dir, `seed-${pocetak}-${dana}d.sql`);
writeFileSync(fajl, `-- Čik Pogodi! seed: ${dana} dana od ${pocetak}. Cenovnik od ${ucitani.datumCenovnika}.\n-- Napravljeno komandom: npm run seed -- ${pocetak} ${dana}\n\n${sql}`);

console.log(`Artikala u igri (imaju sliku i cenu): ${ucitani.proizvodi.length}`);
console.log(`Sopstvenih fotografija u public/artikli: ${slike.size}`);
if (ucitani.izbaceni.length) {
  console.log(`Izbačeno: ${ucitani.izbaceni.length}`);
  for (const x of ucitani.izbaceni) console.log(`  - ${x.naziv}: ${x.razlog}`);
}
const plan = planCena(ucitani.proizvodi, pocetak, dana);
console.log(`\nKviz: ${plan[0].datum} → ${plan.at(-1)!.datum}`);
console.log(`Primer (${plan[0].datum}): ${plan[0].artikli.map((a) => `${a.naziv} ${a.kolicina}`).join(", ")}`);
const guglaPlan = planGugla(trendovi, pocetak, dana);
console.log(
  `\nPojmova za „Šta se više gugla”: ${trendovi.pojmovi.length} (Google Trends, ${trendovi.period}, preuzeto ${trendovi.preuzeto}; ` +
    `najveće neslaganje merenja ${(trendovi.najveceOdstupanje * 100).toFixed(1)}%)`,
);
if (trendovi.izbaceni.length) console.log(`Izbačeno: ${trendovi.izbaceni.map((x) => x.naziv).join(", ")}`);
console.log(`Primer (${guglaPlan[0].datum}): ${guglaPlan[0].dueli.map((p) => `${p.a} ${p.indeksA}:${p.indeksB} ${p.b}`).join(" → ")}`);
const planP = planPesama(pesme.pesme, pocetak, dana);
const poZanru = (z: string) => pesme.pesme.filter((p) => p.zanr === z).length;
console.log(
  `\nPesama u katalogu: ${pesme.pesme.length} (folk ${poZanru("folk")}, rok ${poZanru("rok")}, pop ${poZanru("pop")}, trep ${poZanru("trep")}; ` +
    `klipovi provereni na Deezeru ${pesme.provereno})`,
);
if (pesme.izbaceni.length) console.log(`Izbačeno: ${pesme.izbaceni.map((x) => `${x.naziv} (${x.razlog})`).join(", ")}`);
console.log(`Primer (${planP[0].datum}): ${planP[0].pesme.map((p) => `${p.izvodjac} – ${p.naslov} [${p.zanr}]`).join(", ")}`);
const planF = planFilmova(filmovi.filmovi, pocetak, dana);
console.log(`\nKadrova za „Pogodi domaći film/seriju”: ${filmovi.filmovi.length} (dovoljno za ${Math.floor(filmovi.filmovi.length / 3)} dana bez ponavljanja)`);
if (filmovi.izbaceni.length) console.log(`Izbačeno: ${filmovi.izbaceni.map((x) => `${x.naziv} (${x.razlog})`).join(", ")}`);
console.log(`Primer (${planF[0].datum}): ${planF[0].filmovi.map((f) => f.naslov).join(", ")}`);
const jokeriUPeriodu = jokeri.pitanja.filter((j) => j.datum >= pocetak && j.datum <= planF[planF.length - 1].datum);
console.log(`\nJoker pitanja u ovom periodu: ${jokeriUPeriodu.length} od ${dana} dana (ostali dani nemaju Jokera)`);
for (const j of jokeriUPeriodu) console.log(`  ${j.datum}: ${j.pitanje} → ${j.odgovor}${j.broj ? ` (${j.broj}${j.natpis ? ` ${j.natpis}` : ""})` : ""}`);
if (jokeri.izbaceni.length) console.log(`Napomena: ${jokeri.izbaceni.map((x) => `${x.naziv} (${x.razlog})`).join(", ")}`);
console.log(`\nSQL je u: ${fajl}\nNalepi ga u Supabase → SQL Editor → Run.`);
