/**
 * Ponovo pravi „Pogodi pesmu” i „Pogodi cenu” za dane koji su već u bazi, a još niko ih nije igrao,
 * tako da se pitanje ne ponovi dok ima neiskorišćenih. Polazi od onoga što je STVARNO bilo u igri
 * (izvoz iz baze, npr. supabase/seed/istorija-do-2026-11-20.json), a ne od simulacije od sidra.
 *
 *   npx tsx scripts/preplaniraj.ts supabase/seed/istorija-do-2026-11-20.json 2026-11-21 30
 *
 * Pravi SQL u supabase/seed/. Za svaki dan briše stavke segmenata 1 i 2 i upisuje nove,
 * ali SAMO ako taj dan još niko nije igrao (dan koji je počeo ostaje kakav je bio).
 *
 * Pravila (ista kao u seed-u, plus redosled po tome kad je nešto poslednji put bilo):
 *   - prvo ono što nikad nije bilo, pa ono što je najdavnije bilo; među jednakima nasumično po datumu
 *   - pesme: po jedna folk, rok, pop i trep + peta iz žanra koji se smenjuje, bez istog izvođača u danu
 *   - cene: bez istog naziva u danu, najviše 4 iz iste kategorije, bez artikla od juče
 */
import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import { SEGMENTI } from "../src/config/quiz.config";
import { normalizuj } from "../src/lib/match";
import { ucitajProizvode, type Proizvod } from "../src/lib/content/products";
import { snapshotCena, snapshotPesma } from "../src/lib/content/seed";
import { sopstveneSlike } from "../src/lib/content/slike";
import { ucitajPesme, ZANROVI, type Pesma, type Zanr } from "../src/lib/content/songs";
import { dodajDane } from "../src/lib/time";

const [, , argIstorija, argPocetak, argDana] = process.argv;
if (!argIstorija || !/^\d{4}-\d{2}-\d{2}$/.test(argPocetak ?? "") || !(Number(argDana) > 0)) {
  console.error("Upotreba: npx tsx scripts/preplaniraj.ts <istorija.json> YYYY-MM-DD <broj dana>");
  process.exit(1);
}
const pocetak = argPocetak!;
const dana = Number(argDana);

const koren = join(__dirname, "..");
const istorija = JSON.parse(readFileSync(join(koren, argIstorija), "utf8")) as { pesme: Record<string, string[]>; cene: Record<string, string[]> };
const ucitani = ucitajProizvode(JSON.parse(readFileSync(join(koren, "data", "products.json"), "utf8")), sopstveneSlike(koren));
const pesme = ucitajPesme(JSON.parse(readFileSync(join(koren, "data", "songs.json"), "utf8"))).pesme;
const proizvodi = ucitani.proizvodi;

const PESAMA = SEGMENTI.find((s) => s.key === "pesma")!.pitanja;
const ARTIKALA = SEGMENTI.find((s) => s.key === "cena")!.pitanja;
const NAJVISE_PO_KATEGORIJI = 4;

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
function seme(tekst: string): number {
  let h = 2166136261;
  for (let i = 0; i < tekst.length; i++) h = Math.imul(h ^ tekst.charCodeAt(i), 16777619);
  return h >>> 0;
}

/** Poslednji datum kad je nešto bilo u igri ("" = nikad). Datumi u obliku YYYY-MM-DD se porede kao tekst. */
function poslednjiPut(dnevnik: Record<string, string[]>): Map<string, string> {
  const m = new Map<string, string>();
  for (const [datum, kljucevi] of Object.entries(dnevnik)) for (const k of kljucevi) if ((m.get(k) ?? "") < datum) m.set(k, datum);
  return m;
}

/** Redosled kandidata: nikad pre svega, pa najdavnije; među jednakima nasumično (isto za isti datum). */
function poRedu<T>(lista: T[], kljuc: (x: T) => string, poslednji: Map<string, string>, rnd: () => number, prednost?: (x: T) => number): T[] {
  return lista
    .map((x) => ({ x, p: poslednji.get(kljuc(x)) ?? "", r: rnd() }))
    .sort((a, b) => a.p.localeCompare(b.p) || (prednost ? prednost(b.x) - prednost(a.x) : 0) || a.r - b.r)
    .map((o) => o.x);
}

const poslednjaPesma = poslednjiPut(istorija.pesme);
const poslednjiArtikal = poslednjiPut(istorija.cene);
const planPesama: { datum: string; pesme: Pesma[] }[] = [];
const planCena: { datum: string; artikli: Proizvod[] }[] = [];
const ponovljeno: string[] = [];
const peti: Zanr[] = ["folk", "rok", "pop"];
let juce = new Set<string>(istorija.cene[dodajDane(pocetak, -1)] ?? []);

for (let d = 0; d < dana; d++) {
  const datum = dodajDane(pocetak, d);

  // ── pesme
  const rndP = slucajni(seme(`preplan-pesma:${datum}`));
  const redP = poRedu(pesme, (p) => String(p.deezerId), poslednjaPesma, rndP, (p) => Number(p.prioritet));
  const izabrane: Pesma[] = [];
  const zauzeti = new Set<string>();
  const uzmi = (zanr: Zanr | null) => {
    const p = redP.find((x) => !izabrane.includes(x) && (zanr === null || x.zanr === zanr) && x.izvodjaci.every((i) => !zauzeti.has(normalizuj(i))));
    if (!p) return false;
    izabrane.push(p);
    for (const i of p.izvodjaci) zauzeti.add(normalizuj(i));
    return true;
  };
  const dan = Math.round((Date.parse(datum) - Date.parse("2026-11-01")) / 86_400_000);
  for (const zanr of [...ZANROVI, peti[dan % peti.length]]) if (izabrane.length < PESAMA && !uzmi(zanr)) uzmi(null);
  while (izabrane.length < PESAMA && uzmi(null));
  if (izabrane.length < PESAMA) throw new Error(`Nema dovoljno pesama za ${datum}.`);
  for (const p of izabrane) {
    if (poslednjaPesma.has(String(p.deezerId))) ponovljeno.push(`${datum} pesma: ${p.izvodjac} – ${p.naslov} (bila ${poslednjaPesma.get(String(p.deezerId))})`);
    poslednjaPesma.set(String(p.deezerId), datum);
  }
  planPesama.push({ datum, pesme: izabrane.map((p) => ({ p, k: rndP() })).sort((a, b) => a.k - b.k).map((x) => x.p) });

  // ── cene
  const rndC = slucajni(seme(`preplan-cena:${datum}`));
  const redC = poRedu(proizvodi, (p) => p.barkod, poslednjiArtikal, rndC);
  const artikli: Proizvod[] = [];
  const nazivi = new Set<string>();
  const poKategoriji = new Map<string, number>();
  for (const prolaz of [0, 1, 2]) {
    for (const p of redC) {
      if (artikli.length === ARTIKALA) break;
      if (artikli.includes(p) || nazivi.has(p.naziv)) continue;
      if (prolaz === 0 && juce.has(p.barkod)) continue;
      if (prolaz < 2 && (poKategoriji.get(p.kategorija) ?? 0) >= NAJVISE_PO_KATEGORIJI) continue;
      artikli.push(p);
      nazivi.add(p.naziv);
      poKategoriji.set(p.kategorija, (poKategoriji.get(p.kategorija) ?? 0) + 1);
    }
  }
  if (artikli.length < ARTIKALA) throw new Error(`Nema dovoljno artikala za ${datum}.`);
  for (const p of artikli) {
    if (poslednjiArtikal.has(p.barkod)) ponovljeno.push(`${datum} cena: ${p.naziv} ${p.kolicina} (bio ${poslednjiArtikal.get(p.barkod)})`);
    poslednjiArtikal.set(p.barkod, datum);
  }
  juce = new Set(artikli.map((p) => p.barkod));
  planCena.push({ datum, artikli: artikli.map((p) => ({ p, k: rndC() })).sort((a, b) => a.k - b.k).map((x) => x.p) });
}

// ── SQL
const q = (s: string | null | undefined) => (s == null ? "null" : `'${String(s).replace(/'/g, "''")}'`);
const redovi: string[] = [
  `-- Ponovo napravljeni segmenti 1 (pesme) i 2 (cene) za ${pocetak} + ${dana} dana (scripts/preplaniraj.ts).`,
  "-- Dan koji je neko već igrao se NE menja (brisanje i upis rade samo za dane bez ijedne igre).",
  "begin;",
  "",
  "-- Katalog pesama i artikala (postojeći se osvežavaju).",
];
for (const p of pesme) {
  const alias = p.alias.length ? `array[${p.alias.map(q).join(", ")}]::text[]` : "'{}'::text[]";
  redovi.push(
    `insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values (${q(p.izvodjac)}, ${q(p.naslov)}, ${alias}, ${p.deezerId}, ${p.itunesId ?? "null"}, ${q(p.omot)}, ${q(p.zanr)})
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;`,
  );
}
for (const p of proizvodi) {
  redovi.push(
    `insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values (${q(p.barkod)}, ${q(p.naziv)}, ${q(p.kolicina)}, ${q(p.slika)}, ${p.cenaTacna}, ${p.cenaMin}, ${p.cenaMax}, ${q(p.najjeftinijeU)}, ${q(ucitani.datumCenovnika)})
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();`,
  );
}
for (let d = 0; d < dana; d++) {
  const datum = planPesama[d].datum;
  const neIgran = `not exists (select 1 from public.plays where quiz_date = ${q(datum)})`;
  redovi.push(
    "",
    `-- ${datum}`,
    `insert into public.daily_quiz (quiz_date, status, published_at) values (${q(datum)}, 'published', now()) on conflict (quiz_date) do nothing;`,
    `delete from public.daily_quiz_items where quiz_date = ${q(datum)} and segment in (1, 2) and ${neIgran};`,
  );
  planPesama[d].pesme.forEach((p, i) =>
    redovi.push(
      `insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select ${q(datum)}, 1, ${i + 1}, id, ${q(JSON.stringify(snapshotPesma(p)))}::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = ${p.deezerId} and ${neIgran}
  on conflict (quiz_date, segment, position) do nothing;`,
    ),
  );
  planCena[d].artikli.forEach((p, i) =>
    redovi.push(
      `insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select ${q(datum)}, 2, ${i + 1}, id, ${q(JSON.stringify(snapshotCena(p, ucitani.datumCenovnika)))}::jsonb
  from public.products where barcode = ${q(p.barkod)} and ${neIgran}
  on conflict (quiz_date, segment, position) do nothing;`,
    ),
  );
}
redovi.push("", "commit;", "");

const dir = join(koren, "supabase", "seed");
mkdirSync(dir, { recursive: true });
const ime = join(dir, `preplan-${pocetak}-${dana}d.sql`);
writeFileSync(ime, redovi.join("\n"));
console.log(`Upisano: ${ime}`);
console.log(`Pesama u katalogu: ${pesme.length}, artikala u igri: ${proizvodi.length}`);
console.log(ponovljeno.length ? `Ponavlja se (${ponovljeno.length}):\n  ${ponovljeno.join("\n  ")}` : "Ništa se ne ponavlja.");
