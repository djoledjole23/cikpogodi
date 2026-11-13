import { SEGMENTI } from "@/config/quiz.config";
import { dodajDane } from "@/lib/time";
import type { Proizvod } from "./products";

/**
 * Raspored artikala po danima i SQL koji ga upisuje.
 * Isti kod puni lokalnu bazu i pravi fajl za Supabase (`npm run seed`).
 * Raspored zavisi samo od datuma i spiska artikala, pa svako pokretanje daje isto.
 */

const PO_DANU = SEGMENTI.find((s) => s.key === "cena")!.pitanja;
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

export function seedSql(opcije: { proizvodi: Proizvod[]; datumCenovnika: string; pocetak: string; dana: number }): string {
  const { proizvodi, datumCenovnika, pocetak, dana } = opcije;
  const redovi: string[] = [];

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
  return redovi.join("\n") + "\n";
}
