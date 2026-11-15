/**
 * Sva podešavanja kviza na jednom mestu.
 * Menjaj ovde: limite, pragove i poene. Server i klijent čitaju isti fajl.
 */

export const TIME_ZONE = "Europe/Belgrade";

export type SegmentKey = "pesma" | "cena" | "gugla" | "film" | "joker";

export type SegmentConfig = {
  /** Redni broj u igri (1–5). */
  n: 1 | 2 | 3 | 4 | 5;
  key: SegmentKey;
  naziv: string;
  /** Pravilo u jednoj rečenici, za ekran pre segmenta. */
  pravilo: string;
  /** Kratak opis bodovanja, za tabelu na početnoj. */
  bodovanje: string;
  pitanja: number;
  max: number;
  /** Limit po pitanju u sekundama. Za pesmu je to dužina klipa (vreme slušanja). */
  limitS: number;
  bonus?: boolean;
};

export const SEGMENTI: SegmentConfig[] = [
  {
    n: 1,
    key: "pesma",
    naziv: "Pogodi pesmu",
    pravilo: "Pusti pesmu i pogodi je što pre: što kraće slušaš, to više poena.",
    bodovanje: "5 pesama · 20, 15, 10 ili 5: što kraće slušaš, to više",
    pitanja: 5,
    max: 100,
    limitS: 30,
  },
  {
    n: 2,
    key: "cena",
    naziv: "Pogodi cenu",
    pravilo: "Upiši koliko košta artikal. Što bliže pravoj ceni, to bolje.",
    bodovanje: "5 artikala · promašiš do 10%: 20, do 15%: 10",
    pitanja: 5,
    max: 100,
    limitS: 20,
  },
  {
    n: 3,
    key: "gugla",
    naziv: "Šta se više gugla",
    pravilo: "Tapni pojam koji se u Srbiji više guglao.",
    bodovanje: "5 parova · tačno: 8",
    pitanja: 5,
    max: 40,
    limitS: 10,
  },
  {
    n: 4,
    key: "film",
    naziv: "Pogodi domaći film/seriju",
    pravilo: "Pogledaj kadar i upiši iz kog je domaćeg filma ili serije.",
    bodovanje: "3 kadra · tačno: 20",
    pitanja: 3,
    max: 60,
    limitS: 30,
  },
  {
    n: 5,
    key: "joker",
    naziv: "Joker pitanje",
    pravilo: "Jedno pitanje za bonus. Upiši odgovor i pokupi 50 preko svega.",
    bodovanje: "1 pitanje · tačno: +50 preko svega",
    pitanja: 1,
    max: 50,
    limitS: 30,
    bonus: true,
  },
];

export const MAX_OSNOVNO = 300;
export const MAX_BONUS = 50;
export const MAX_UKUPNO = MAX_OSNOVNO + MAX_BONUS;

/**
 * Pesma: poeni po ukupnom preslušanom vremenu (granica uključena: tačno 2,0 s je još uvek 20).
 */
export const PESMA_PRAGOVI: { doMs: number; poeni: number }[] = [
  { doMs: 2000, poeni: 20 },
  { doMs: 4000, poeni: 15 },
  { doMs: 6000, poeni: 10 },
  { doMs: 30000, poeni: 5 },
];

/**
 * Cena: poeni po odstupanju u procentima (granica uključena: tačno 10% je još uvek 10).
 */
export const CENA_PRAGOVI: { doProcenata: number; poeni: number }[] = [
  { doProcenata: 10, poeni: 20 },
  { doProcenata: 15, poeni: 10 },
];

export const GUGLA_POENI = 8;
export const FILM_POENI = 20;
export const JOKER_POENI = 50;

/** Koliko server toleriše kašnjenje mreže kad proverava vremena (ms). */
export const TOLERANCIJA_MREZE_MS = 1500;

export const KORISNICKO_IME = { min: 3, max: 20 } as const;
export const SIFRA_MIN = 6;
