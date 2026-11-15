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

/** Film ili serija: samo kadar. Adresa slike ne odaje naslov. */
export type PitanjeFilm = { vrsta: "film"; slika: string };

/** Joker: samo tekst pitanja. Odgovor, fotografija i broj za otkrivanje ostaju na serveru. */
export type PitanjeJoker = { vrsta: "joker"; pitanje: string; slika?: string | null };

export type Pitanje = PitanjePesma | PitanjeCena | PitanjeGugla | PitanjeFilm | PitanjeJoker;

// ───── odgovori koje šalje browser ─────

export type OdgovorCena = { unos: number };
export type OdgovorGugla = { izbor: "a" | "b" };
/** Pesma izabrana sa spiska (`izbor`, uz tekst radi prikaza), slobodno ukucan tekst ili „Ne znam”. */
export type OdgovorPesma = { izbor?: { izvodjac: string; naslov: string }; tekst?: string; neZnam?: boolean };
/** Ukucan naslov ili „Ne znam”. */
export type OdgovorFilm = { tekst?: string; neZnam?: boolean };
/** Ukucan odgovor ili „Ne znam”. */
export type OdgovorJoker = { tekst?: string; neZnam?: boolean };
export type Odgovor = OdgovorPesma | OdgovorCena | OdgovorGugla | OdgovorFilm | OdgovorJoker;

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

export type PrikazFilm = {
  vrsta: "film";
  naslov: string;
  slika: string;
  /** Šta je igrač ukucao; null za „Ne znam” i istek vremena. */
  odgovor: string | null;
  neZnam: boolean;
  tacno: boolean;
};

export type PrikazJoker = {
  vrsta: "joker";
  pitanje: string;
  /** Tačan odgovor, onako kako se piše. */
  resenje: string;
  /** Fotografija, veliki broj i natpis ispod broja: stižu tek sa ocenom. */
  slika: string | null;
  broj: string | null;
  natpis: string | null;
  /** Šta je igrač ukucao; null za „Ne znam” i istek vremena. */
  odgovor: string | null;
  neZnam: boolean;
  tacno: boolean;
};

export type Prikaz = PrikazPesma | PrikazCena | PrikazGugla | PrikazFilm | PrikazJoker;

/** Da li je pitanje ostalo bez odgovora (isteklo vreme). */
export function bezOdgovora(p: Prikaz): boolean {
  if (p.vrsta === "pesma" || p.vrsta === "film" || p.vrsta === "joker") return p.odgovor === null && !p.neZnam;
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

/** none: rezultat nije na rang listi (gost) · pending: čeka potvrdu mejla · counted: na listi */
export type StanjeListe = "none" | "pending" | "counted";

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
  /** Samo kad je igra završena: da li je rezultat na rang listi. */
  lista?: StanjeListe;
  /** Mesto na današnjoj listi (samo kad je rezultat na listi). */
  mesto?: number | null;
  /** Da li je igrač prijavljen i da li nalozi uopšte rade (Supabase povezan). Dodaje ih API ruta. */
  prijavljen?: boolean;
  nalozi?: boolean;
  /** Baza je privremena (u memoriji): rezultat ne može da se sačuva. Samo na razvojnom računaru. */
  probnaBaza?: boolean;
};

export type OdgovorServera = {
  ocena: Ocena;
  /** Popunjeno kad je ovim odgovorom završen segment. */
  krajSegmenta?: SegmentStanje;
  stanje: Stanje;
};
