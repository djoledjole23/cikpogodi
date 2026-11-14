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

export type PitanjeGugla = {
  vrsta: "gugla";
  /** Gornji pojam. */
  a: string;
  /** Donji pojam. Pobednik duela ostaje na svom mestu i u sledećem pitanju. */
  b: string;
};

/** Pesma: u browser ne ide ništa o njoj. Zvuk se pušta sa /api/track/<itemId>. */
export type PitanjePesma = { vrsta: "pesma" };

export type Pitanje = PitanjePesma | PitanjeCena | PitanjeGugla;

// ───── odgovori koje šalje browser ─────

export type OdgovorCena = { unos: number };
export type OdgovorGugla = { izbor: "a" | "b" };
/** Izabrana pesma iz kataloga (`songId`, uz tekst radi prikaza), slobodno ukucan tekst ili „Ne znam”. */
export type OdgovorPesma = { songId?: number; tekst?: string; neZnam?: boolean };
export type Odgovor = OdgovorPesma | OdgovorCena | OdgovorGugla;

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

export type PrikazGugla = {
  vrsta: "gugla";
  a: string;
  b: string;
  /** Indeks 0–100 unutar para (češće traženi pojam je 100). */
  indeksA: number;
  indeksB: number;
  /** Koliko puta se pobednik više gugla od drugog pojma (npr. 2,4). */
  puta: number;
  /** Šta je igrač tapnuo, ili null ako je isteklo vreme. */
  izbor: "a" | "b" | null;
  tacan: "a" | "b";
  period: string;
};

export type PrikazPesma = {
  vrsta: "pesma";
  izvodjac: string;
  naslov: string;
  /** Omot albuma (Deezer). */
  omot: string;
  /** Šta je igrač odgovorio („Izvođač – Naslov” ili ukucan tekst); null za „Ne znam” i istek klipa. */
  odgovor: string | null;
  neZnam: boolean;
  tacno: boolean;
  /** Ukupno preslušano vreme. */
  slusanoMs: number;
};

export type Prikaz = PrikazPesma | PrikazCena | PrikazGugla;

/** Da li je pitanje ostalo bez odgovora (isteklo vreme). */
export function bezOdgovora(p: Prikaz): boolean {
  if (p.vrsta === "pesma") return p.odgovor === null && !p.neZnam;
  return p.vrsta === "cena" ? p.unos === null : p.izbor === null;
}

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
  /** Kako su prošla dosadašnja pitanja, redom: 2 = svi poeni, 1 = deo poena, 0 = ništa. */
  tok: (0 | 1 | 2)[];
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
  /** Pesma: server misli da klip upravo svira (posle osvežavanja strane browser javlja da je stao). */
  svira?: boolean;
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
