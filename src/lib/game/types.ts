import type { SegmentKey } from "@/config/quiz.config";

/**
 * Sve što putuje između servera i browsera tokom igre.
 * Ovde NEMA tačnih odgovora za pitanja koja još nisu odgovorena:
 * `Pitanje` nosi samo ono što igrač sme da vidi.
 */

export type Identitet = {
  /** Ulogovani igrač ili null za gosta. */
  userId: string | null;
  /** Nasumična oznaka uređaja (kolačić + localStorage). */
  deviceId: string;
};

// ───── pitanja (bez odgovora) ─────

export type PitanjeCena = {
  vrsta: "cena";
  naziv: string;
  kolicina: string;
  slika: string;
};

export type Pitanje = PitanjeCena;

// ───── odgovori koje šalje browser ─────

export type OdgovorCena = { unos: number };
export type Odgovor = OdgovorCena;

// ───── šta se prikazuje posle odgovora ─────

export type PrikazCena = {
  vrsta: "cena";
  naziv: string;
  kolicina: string;
  /** Šta je igrač uneo, ili null ako je isteklo vreme. */
  unos: number | null;
  prava: number;
  /** „+10%”, „−13%”, „u dinar”; prazno kad nema unosa. */
  procenat: string;
  min: number;
  max: number;
  najjeftinije: string;
};

export type Prikaz = PrikazCena;

export type Ocena = {
  /** Za zvuk i niz tačnih: da li je pitanje donelo poene. */
  tacno: boolean;
  poeni: number;
  /** Najviše poena koje je pitanje moglo da donese. */
  maxPoena: number;
  istek: boolean;
  prikaz: Prikaz;
};

// ───── stanje igre ─────

export type SegmentStanje = {
  n: number;
  key: SegmentKey;
  naziv: string;
  pravilo: string;
  pitanja: number;
  odgovoreno: number;
  poeni: number;
  max: number;
  bonus: boolean;
};

export type Trenutno = {
  itemId: number;
  segment: number;
  pozicija: number;
  ukupno: number;
  /**
   * uvod: prvo pitanje segmenta, čeka se „Kreni” ·
   * sledece: sledeće pitanje je spremno, čeka se da ga browser zatraži ·
   * pitanje: pitanje je poslato i vreme teče
   */
  faza: "uvod" | "sledece" | "pitanje";
  pitanje?: Pitanje;
  limitMs?: number;
  preostaloMs?: number;
};

export type StavkaRezultata = {
  segment: number;
  pozicija: number;
  poeni: number;
  maxPoena: number;
  istek: boolean;
  prikaz: Prikaz;
};

export type Stanje = {
  status:
    | "nije_povezano" // nema baze
    | "nema_kviza" // za danas nema objavljenog kviza
    | "nije_poceo"
    | "u_toku"
    | "zavrseno"
    | "uredjaj_igrao"; // gost na uređaju sa kog je danas već igrao neki nalog
  datum: string;
  score: number;
  maxUkupno: number;
  segmenti: SegmentStanje[];
  trenutno?: Trenutno;
  /** Samo kad je igra završena. */
  rezultat?: StavkaRezultata[];
};

export type OdgovorServera = {
  ocena: Ocena;
  /** Popunjeno kad je ovim odgovorom završen segment. */
  krajSegmenta?: SegmentStanje;
  stanje: Stanje;
};
