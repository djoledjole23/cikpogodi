import { SEGMENTI } from "@/config/quiz.config";
import { dodajDane } from "@/lib/time";
import type { Proizvod } from "./products";
import type { Par } from "./trends";

/**
 * Raspored artikala po danima i SQL koji ga upisuje.
 * Isti kod puni lokalnu bazu i pravi fajl za Supabase (`npm run seed`).
 * Raspored zavisi samo od datuma i spiska artikala, pa svako pokretanje daje isto.
 */

const PO_DANU = SEGMENTI.find((s) => s.key === "cena")!.pitanja;
const PAROVA_PO_DANU = SEGMENTI.find((s) => s.key === "gugla")!.pitanja;
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

export type DnevniPlanGugla = { datum: string; parovi: Par[] };

/**
 * Za svaki dan bira 8 parova: svaki iz druge teme (pa se nijedan pojam ne javlja dvaput u danu),
 * i nijedan par se ne ponavlja u celom periodu.
 */
export function planGugla(parovi: Par[], pocetak: string, dana: number): DnevniPlanGugla[] {
  const poTemi = new Map<string, Par[]>();
  for (const p of parovi) poTemi.set(p.tema, [...(poTemi.get(p.tema) ?? []), p]);
  const kljuc = (p: Par) => `${p.upitA}|${p.upitB}`;
  const iskoriscen = new Set<string>();
  const plan: DnevniPlanGugla[] = [];

  for (let d = 0; d < dana; d++) {
    const datum = dodajDane(pocetak, d);
    const rnd = slucajni(semeIzTeksta(`gugla:${datum}`));
    // Teme sa najviše neiskorišćenih parova idu prve (uz malo slučajnosti), da nijedna ne presuši pre kraja.
    const teme = [...poTemi.entries()]
      .map(([tema, lista]) => ({ tema, slobodni: lista.filter((p) => !iskoriscen.has(kljuc(p))), tezina: rnd() * 3 }))
      .filter((t) => t.slobodni.length > 0)
      .sort((x, y) => y.slobodni.length + y.tezina - (x.slobodni.length + x.tezina))
      .slice(0, PAROVA_PO_DANU);
    if (teme.length < PAROVA_PO_DANU) {
      throw new Error(`Nema dovoljno parova za ${datum}: treba ${PAROVA_PO_DANU} različitih tema, a ostalo ih je ${teme.length}.`);
    }
    const izabrani = teme
      .map((t) => t.slobodni[Math.floor(rnd() * t.slobodni.length)])
      .map((p) => ({ p, k: rnd() }))
      .sort((x, y) => x.k - y.k)
      .map((x) => x.p);
    for (const p of izabrani) iskoriscen.add(kljuc(p));
    plan.push({ datum, parovi: izabrani });
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

/** Ono što se zamrzava uz pitanje „Šta se više gugla”. */
export function snapshotGugla(p: Par) {
  return { a: p.a, b: p.b, indeksA: p.indeksA, indeksB: p.indeksB, period: p.period, preuzeto: p.preuzeto };
}

export function seedSql(opcije: {
  proizvodi: Proizvod[];
  datumCenovnika: string;
  /** Parovi za „Šta se više gugla”. Bez njih se pravi samo segment 2. */
  parovi?: Par[];
  pocetak: string;
  dana: number;
}): string {
  const { proizvodi, datumCenovnika, parovi = [], pocetak, dana } = opcije;
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

  if (parovi.length) {
    redovi.push(
      "",
      "-- Isto što i migracija 0002: ponovljeno ovde da seed radi i ako ona nije puštena.",
      "create unique index if not exists trend_pairs_par_idx on public.trend_pairs (term_a, term_b, period);",
      "",
      "-- Parovi pojmova (trends.json). Postojeći se osvežavaju.",
    );
    for (const p of parovi) {
      redovi.push(
        `insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values (${q(p.a)}, ${q(p.b)}, ${p.indeksA}, ${p.indeksB}, ${q(p.period)}, ${q(p.preuzeto)})
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;`,
      );
    }
    redovi.push("", "-- Dnevni kviz: segment 3 (Šta se više gugla).");
    for (const dan of planGugla(parovi, pocetak, dana)) {
      redovi.push(
        `insert into public.daily_quiz (quiz_date, status, published_at) values (${q(dan.datum)}, 'published', now())
  on conflict (quiz_date) do nothing;`,
      );
      dan.parovi.forEach((p, i) => {
        redovi.push(
          `insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select ${q(dan.datum)}, 3, ${i + 1}, id, ${q(JSON.stringify(snapshotGugla(p)))}::jsonb
  from public.trend_pairs where term_a = ${q(p.a)} and term_b = ${q(p.b)} and period = ${q(p.period)}
  on conflict (quiz_date, segment, position) do nothing;`,
        );
      });
    }
  }
  return redovi.join("\n") + "\n";
}
