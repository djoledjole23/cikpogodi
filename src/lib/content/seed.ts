import { SEGMENTI } from "@/config/quiz.config";
import { dodajDane } from "@/lib/time";
import { normalizuj } from "@/lib/match";
import type { Film } from "./films";
import type { Joker } from "./joker";
import type { Proizvod } from "./products";
import { ZANROVI, type Pesma, type Zanr } from "./songs";
import { ferDuel, napraviPar, type Par, type Pojam, type UcitaniTrendovi } from "./trends";

/**
 * Raspored artikala po danima i SQL koji ga upisuje.
 * Isti kod puni lokalnu bazu i pravi fajl za Supabase (`npm run seed`).
 * Raspored zavisi samo od datuma i spiska artikala, pa svako pokretanje daje isto.
 */

const PO_DANU = SEGMENTI.find((s) => s.key === "cena")!.pitanja;
const PAROVA_PO_DANU = SEGMENTI.find((s) => s.key === "gugla")!.pitanja;
const PESAMA_PO_DANU = SEGMENTI.find((s) => s.key === "pesma")!.pitanja;
const FILMOVA_PO_DANU = SEGMENTI.find((s) => s.key === "film")!.pitanja;
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

export type DnevniPlanGugla = { datum: string; dueli: Par[] };

/** Koliko puta u danu izazivač treba da pobedi (da „uvek tapni šampiona” ne bude taktika). */
const POBEDE_IZAZIVACA = { cilj: 4, najmanje: 3, najvise: 5 };

/**
 * Za svaki dan pravi lanac od 8 duela u kome pobednik ostaje:
 * pojam koji se više gugla ostaje na svom mestu (gore ili dole), a na mesto gubitnika dolazi novi izazivač.
 * Svih 9 pojmova u danu je iz različitih tema, svaki duel ima jasnog pobednika (vidi `ferDuel`)
 * i nijedan duel se ne ponavlja u celom periodu.
 */
export function planGugla(
  trendovi: Pick<UcitaniTrendovi, "pojmovi" | "period" | "preuzeto">,
  pocetak: string,
  dana: number,
): DnevniPlanGugla[] {
  const { pojmovi, period, preuzeto } = trendovi;
  const kljuc = (x: Pojam, y: Pojam) => [x.upit, y.upit].sort().join("|");
  const iskoriscenDuel = new Set<string>();
  const koriscen = new Map<string, number>(pojmovi.map((p) => [p.upit, 0]));
  const plan: DnevniPlanGugla[] = [];

  for (let d = 0; d < dana; d++) {
    const datum = dodajDane(pocetak, d);
    let dueli: { gore: Pojam; dole: Pojam }[] | null = null;

    for (let pokusaj = 0; pokusaj < 400 && !dueli; pokusaj++) {
      const rnd = slucajni(semeIzTeksta(`gugla:${datum}:${pokusaj}`));
      // Najređe korišćeni pojmovi idu prvi, uz malo slučajnosti.
      const poRedu = (lista: Pojam[]) =>
        lista.map((p) => ({ p, k: koriscen.get(p.upit)! + rnd() * 0.9 })).sort((x, y) => x.k - y.k).map((x) => x.p);

      // Prvi pojam: iz slabije polovine, da lanac ima kuda da raste.
      const poJacini = [...pojmovi].sort((x, y) => x.jacina - y.jacina);
      let sampion = poRedu(poJacini.slice(0, Math.ceil(poJacini.length * 0.55)))[0];
      let sampionGore = rnd() < 0.5;
      const teme = new Set([sampion.tema]);
      const lanac: { gore: Pojam; dole: Pojam }[] = [];
      let pobede = 0;

      for (let k = 0; k < PAROVA_PO_DANU; k++) {
        const kandidati = pojmovi.filter((p) => !teme.has(p.tema) && ferDuel(sampion, p) && !iskoriscenDuel.has(kljuc(sampion, p)));
        const jaci = poRedu(kandidati.filter((p) => p.jacina > sampion.jacina));
        const slabiji = poRedu(kandidati.filter((p) => p.jacina < sampion.jacina));
        const zeliPobedu = rnd() < (POBEDE_IZAZIVACA.cilj - pobede) / (PAROVA_PO_DANU - k);
        const izbor = zeliPobedu ? (jaci[0] ?? slabiji[0]) : (slabiji[0] ?? jaci[0]);
        if (!izbor) break;
        lanac.push(sampionGore ? { gore: sampion, dole: izbor } : { gore: izbor, dole: sampion });
        teme.add(izbor.tema);
        if (izbor.jacina > sampion.jacina) {
          sampion = izbor;
          sampionGore = !sampionGore;
          pobede++;
        }
      }
      if (lanac.length === PAROVA_PO_DANU && pobede >= POBEDE_IZAZIVACA.najmanje && pobede <= POBEDE_IZAZIVACA.najvise) dueli = lanac;
    }
    if (!dueli) throw new Error(`Ne mogu da složim lanac duela za ${datum}: treba još pojmova u trends.json.`);

    for (const x of dueli) iskoriscenDuel.add(kljuc(x.gore, x.dole));
    for (const p of new Set(dueli.flatMap((x) => [x.gore, x.dole]))) koriscen.set(p.upit, koriscen.get(p.upit)! + 1);
    plan.push({ datum, dueli: dueli.map((x) => napraviPar(x.gore, x.dole, period, preuzeto)) });
  }
  return plan;
}

export type DnevniPlanPesama = { datum: string; pesme: Pesma[] };

/**
 * Za svaki dan bira 5 pesama, po malo od svega: po jedna folk, rok, pop i trep,
 * a peta je svaki dan iz drugog žanra (folk, rok, pop, pa ukrug).
 * U jednom danu se nijedan izvođač ne javlja dvaput (ni kao gost na tuđoj pesmi).
 * Pesme sa spiska vlasnika sajta (prioritet) idu pre ostalih, a pesma se ne ponavlja
 * dok ima neiskorišćenih u tom žanru.
 */
export function planPesama(pesme: Pesma[], pocetak: string, dana: number): DnevniPlanPesama[] {
  const koriscena = new Map<number, number>(pesme.map((p) => [p.deezerId, 0]));
  const peti: Zanr[] = ["folk", "rok", "pop"];
  const plan: DnevniPlanPesama[] = [];

  for (let d = 0; d < dana; d++) {
    const datum = dodajDane(pocetak, d);
    const rnd = slucajni(semeIzTeksta(`pesma:${datum}`));
    const kljuc = new Map(pesme.map((p) => [p.deezerId, rnd()]));
    // Najmanje puta korišćene prve; među njima prvo one sa prioritetom, pa nasumično.
    const poRedu = [...pesme].sort(
      (a, b) =>
        koriscena.get(a.deezerId)! - koriscena.get(b.deezerId)! ||
        Number(b.prioritet) - Number(a.prioritet) ||
        kljuc.get(a.deezerId)! - kljuc.get(b.deezerId)!,
    );

    const izabrane: Pesma[] = [];
    const zauzeti = new Set<string>();
    const uzmi = (zanr: Zanr | null) => {
      const p = poRedu.find(
        (x) => !izabrane.includes(x) && (zanr === null || x.zanr === zanr) && x.izvodjaci.every((i) => !zauzeti.has(normalizuj(i))),
      );
      if (!p) return false;
      izabrane.push(p);
      for (const i of p.izvodjaci) zauzeti.add(normalizuj(i));
      return true;
    };

    for (const zanr of [...ZANROVI, peti[d % peti.length]]) {
      if (izabrane.length < PESAMA_PO_DANU && !uzmi(zanr)) uzmi(null); // žanr je ispražnjen: uzmi bilo koju
    }
    while (izabrane.length < PESAMA_PO_DANU && uzmi(null));
    if (izabrane.length < PESAMA_PO_DANU) throw new Error(`Nema dovoljno pesama različitih izvođača za ${datum}.`);

    const redosled = izabrane.map((p) => ({ p, k: rnd() })).sort((a, b) => a.k - b.k).map((x) => x.p);
    for (const p of redosled) koriscena.set(p.deezerId, koriscena.get(p.deezerId)! + 1);
    plan.push({ datum, pesme: redosled });
  }
  return plan;
}

export type DnevniPlanFilmova = { datum: string; filmovi: Film[] };

/**
 * Za svaki dan bira 3 kadra: prvo filmovi koji su najmanje puta bili, nasumično među jednakima.
 * Film se ne ponavlja dok ima neiskorišćenih, a kad se krug završi, ne ponavlja se onaj od juče.
 */
export function planFilmova(filmovi: Film[], pocetak: string, dana: number): DnevniPlanFilmova[] {
  if (filmovi.length < FILMOVA_PO_DANU) throw new Error("Premalo filmova za jedan dan.");
  const koriscen = new Map<string, number>(filmovi.map((f) => [f.slika, 0]));
  let juce = new Set<string>();
  const plan: DnevniPlanFilmova[] = [];
  for (let d = 0; d < dana; d++) {
    const datum = dodajDane(pocetak, d);
    const rnd = slucajni(semeIzTeksta(`film:${datum}`));
    const kljuc = new Map(filmovi.map((f) => [f.slika, rnd()]));
    const poRedu = [...filmovi].sort(
      (a, b) =>
        koriscen.get(a.slika)! - koriscen.get(b.slika)! ||
        Number(juce.has(a.slika)) - Number(juce.has(b.slika)) ||
        kljuc.get(a.slika)! - kljuc.get(b.slika)!,
    );
    const izabrani = poRedu.slice(0, FILMOVA_PO_DANU);
    for (const f of izabrani) koriscen.set(f.slika, koriscen.get(f.slika)! + 1);
    juce = new Set(izabrani.map((f) => f.slika));
    plan.push({ datum, filmovi: izabrani });
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

/** Ono što se zamrzava uz pitanje „Pogodi pesmu” (broj pesme u bazi dodaje sam SQL). */
export function snapshotPesma(p: Pesma) {
  return { izvodjac: p.izvodjac, naslov: p.naslov, alias: p.alias, deezerId: p.deezerId, itunesId: p.itunesId, omot: p.omot };
}

export function seedSql(opcije: {
  proizvodi: Proizvod[];
  datumCenovnika: string;
  /** Katalog pesama za „Pogodi pesmu”. Bez njega se segment 1 ne pravi. */
  pesme?: Pesma[];
  /** Kadrovi za „Pogodi domaći film/seriju”. Bez njih se segment 4 ne pravi. */
  filmovi?: Film[];
  /** Joker pitanja (po datumu). Dan bez pitanja nema segment 5. */
  jokeri?: Joker[];
  /** Pojmovi za „Šta se više gugla”. Bez njih se pravi samo segment 2. */
  trendovi?: Pick<UcitaniTrendovi, "pojmovi" | "period" | "preuzeto">;
  pocetak: string;
  dana: number;
}): string {
  const { proizvodi, datumCenovnika, pesme, filmovi, jokeri, trendovi, pocetak, dana } = opcije;
  const redovi: string[] = [
    "-- Isto što i migracije 0004 i 0005: ponovljeno ovde da seed radi i ako one nisu puštene.",
    `create table if not exists public.film_stills (
  id bigint generated always as identity primary key,
  film_id bigint not null references public.films (id) on delete cascade,
  image_url text not null unique,
  note text,
  created_at timestamptz not null default now()
);`,
    "alter table public.film_stills enable row level security;",
    "create unique index if not exists films_title_idx on public.films (title);",
    `drop policy if exists "katalog filmova je javan" on public.films;`,
    `create table if not exists public.joker_questions (
  id bigint generated always as identity primary key,
  question text not null unique,
  answer text not null,
  aliases text[] not null default '{}',
  image_url text,
  reveal_number text,
  reveal_label text,
  created_at timestamptz not null default now()
);`,
    "alter table public.joker_questions enable row level security;",
    "alter table public.joker_questions add column if not exists question_image_url text;",
    "alter table public.daily_quiz_items add column if not exists film_still_id bigint references public.film_stills (id);",
    "alter table public.daily_quiz_items add column if not exists joker_id bigint references public.joker_questions (id);",
    "alter table public.daily_quiz_items drop constraint if exists stavka_odgovara_segmentu;",
    `alter table public.daily_quiz_items add constraint stavka_odgovara_segmentu check (
  num_nonnulls(song_id, product_id, trend_pair_id, film_clip_id, film_still_id, rebus_id, joker_id) = 1
  and ((segment = 1 and song_id is not null) or (segment = 2 and product_id is not null) or (segment = 3 and trend_pair_id is not null)
    or (segment = 4 and (film_clip_id is not null or film_still_id is not null)) or (segment = 5 and (rebus_id is not null or joker_id is not null)))
);`,
    "",
  ];

  if (pesme?.length) {
    redovi.push(
      "-- Isto što i migracija 0003: ponovljeno ovde da seed radi i ako ona nije puštena.",
      "alter table public.songs add column if not exists genre text;",
      "alter table public.play_answers add column if not exists playing_since timestamptz;",
      "",
      "-- Katalog pesama (songs.json). Postojeće se osvežavaju po Deezer ID-u.",
    );
    for (const p of pesme) {
      const alias = p.alias.length ? `array[${p.alias.map(q).join(", ")}]::text[]` : "'{}'::text[]";
      redovi.push(
        `insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values (${q(p.izvodjac)}, ${q(p.naslov)}, ${alias}, ${p.deezerId}, ${p.itunesId ?? "null"}, ${q(p.omot)}, ${q(p.zanr)})
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;`,
      );
    }
    redovi.push("", "-- Dnevni kviz: segment 1 (Pogodi pesmu). Dan koji već ima stavke se ne dira.");
    for (const dan of planPesama(pesme, pocetak, dana)) {
      redovi.push(
        `insert into public.daily_quiz (quiz_date, status, published_at) values (${q(dan.datum)}, 'published', now())
  on conflict (quiz_date) do nothing;`,
      );
      dan.pesme.forEach((p, i) => {
        redovi.push(
          `insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select ${q(dan.datum)}, 1, ${i + 1}, id, ${q(JSON.stringify(snapshotPesma(p)))}::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = ${p.deezerId}
  on conflict (quiz_date, segment, position) do nothing;`,
        );
      });
    }
    redovi.push("");
  }

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

  if (trendovi) {
    const plan = planGugla(trendovi, pocetak, dana);
    redovi.push(
      "",
      "-- Isto što i migracija 0002: ponovljeno ovde da seed radi i ako ona nije puštena.",
      "create unique index if not exists trend_pairs_par_idx on public.trend_pairs (term_a, term_b, period);",
      "",
      "-- Dueli pojmova (trends.json). Postojeći se osvežavaju.",
    );
    for (const p of plan.flatMap((dan) => dan.dueli)) {
      redovi.push(
        `insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values (${q(p.a)}, ${q(p.b)}, ${p.indeksA}, ${p.indeksB}, ${q(p.period)}, ${q(p.preuzeto)})
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;`,
      );
    }
    redovi.push("", "-- Dnevni kviz: segment 3 (Šta se više gugla). Pobednik duela ostaje i u sledećem.");
    for (const dan of plan) {
      redovi.push(
        `insert into public.daily_quiz (quiz_date, status, published_at) values (${q(dan.datum)}, 'published', now())
  on conflict (quiz_date) do nothing;`,
      );
      dan.dueli.forEach((p, i) => {
        redovi.push(
          `insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select ${q(dan.datum)}, 3, ${i + 1}, id, ${q(JSON.stringify(snapshotGugla(p)))}::jsonb
  from public.trend_pairs where term_a = ${q(p.a)} and term_b = ${q(p.b)} and period = ${q(p.period)}
  on conflict (quiz_date, segment, position) do nothing;`,
        );
      });
    }
  }
  if (filmovi?.length) {
    redovi.push(
      "",
      "-- Filmovi i serije (films.json) i njihovi kadrovi.",
    );
    for (const f of filmovi) {
      const alias = f.alias.length ? `array[${f.alias.map(q).join(", ")}]::text[]` : "'{}'::text[]";
      redovi.push(
        `insert into public.films (title, aliases) values (${q(f.naslov)}, ${alias})
  on conflict (title) do update set aliases = excluded.aliases, active = true;`,
        `insert into public.film_stills (film_id, image_url) select id, ${q(f.slika)} from public.films where title = ${q(f.naslov)}
  on conflict (image_url) do nothing;`,
      );
    }
    redovi.push("", "-- Dnevni kviz: segment 4 (Pogodi domaći film/seriju). Dan koji već ima stavke se ne dira.");
    for (const dan of planFilmova(filmovi, pocetak, dana)) {
      redovi.push(
        `insert into public.daily_quiz (quiz_date, status, published_at) values (${q(dan.datum)}, 'published', now())
  on conflict (quiz_date) do nothing;`,
      );
      dan.filmovi.forEach((f, i) => {
        const snapshot = { naslov: f.naslov, alias: f.alias, slika: f.slika };
        redovi.push(
          `insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select ${q(dan.datum)}, 4, ${i + 1}, id, ${q(JSON.stringify(snapshot))}::jsonb
  from public.film_stills where image_url = ${q(f.slika)}
  on conflict (quiz_date, segment, position) do nothing;`,
        );
      });
    }
  }

  // Joker pitanja za dane iz ovog perioda (poređenje datuma kao teksta radi jer su oblika YYYY-MM-DD).
  const poslednji = dodajDane(pocetak, dana - 1);
  const uPeriodu = (jokeri ?? []).filter((j) => j.datum >= pocetak && j.datum <= poslednji);
  if (uPeriodu.length) {
    redovi.push(
      "",
      "-- Dnevni kviz: segment 5 (Joker pitanje). Dan koji već ima Jokera se ne dira.",
    );
    for (const j of uPeriodu) {
      const alias = j.alias.length ? `array[${j.alias.map(q).join(", ")}]::text[]` : "'{}'::text[]";
      const ili = (x: string | null) => (x === null ? "null" : q(x));
      const snapshot = {
        pitanje: j.pitanje,
        odgovor: j.odgovor,
        alias: j.alias,
        slika: j.slika,
        slikaPitanja: j.slikaPitanja,
        broj: j.broj,
        natpis: j.natpis,
      };
      redovi.push(
        `insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values (${q(j.pitanje)}, ${q(j.odgovor)}, ${alias}, ${ili(j.slika)}, ${ili(j.slikaPitanja)}, ${ili(j.broj)}, ${ili(j.natpis)})
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;`,
        `insert into public.daily_quiz (quiz_date, status, published_at) values (${q(j.datum)}, 'published', now())
  on conflict (quiz_date) do nothing;`,
        `insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select ${q(j.datum)}, 5, 1, id, ${q(JSON.stringify(snapshot))}::jsonb
  from public.joker_questions where question = ${q(j.pitanje)}
  on conflict (quiz_date, segment, position) do nothing;`,
      );
    }
  }

  return redovi.join("\n") + "\n";
}
