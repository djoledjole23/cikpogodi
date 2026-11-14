/**
 * Čitanje data/trends.json (Google Trends, Srbija, poslednjih 12 meseci).
 *
 * Pojam se meri kao TEMA (sve pretrage o njemu, kako god da su ukucane) kad god Trends ima temu koja
 * hvata bar koliko i sam tekst; inače kao TAČAN TEKST pretrage. Tako „Nikola Jokić” broji i „jokic” i „jokić mvp”,
 * a ne samo pretrage u kojima piše puno ime.
 *
 * U fajlu su „grupe” (jedno poređenje do 5 pojmova, zajednička skala unutar grupe) i „mostovi”
 * (poređenja u kojima su zajedno pojmovi iz različitih grupa). Preko mostova se sve grupe svode
 * na jednu skalu, pa mogu da se porede i pojmovi iz različitih tema.
 *
 * Brojevi se ne izmišljaju i ne dopunjavaju: pojam ili duel koji nije pouzdan se izbacuje.
 */

export type Pojam = {
  tema: string;
  naziv: string;
  upit: string;
  /** Prosek unutar svoje grupe (kako je izmeren). */
  prosekUGrupi: number;
  /** Isti prosek sveden na zajedničku skalu svih grupa. Samo odnos dve jačine ima smisla. */
  jacina: number;
  /**
   * Koliko najviše jačina može da omaši (0,1 = 10%).
   * Trends daje cele brojeve 0–100 po nedelji, pa mali prosek nosi veliku grešku zaokruživanja.
   * Pojam meren kao tačan tekst (a ne kao tema) dobija dodatak: tekst ne hvata sve oblike i pisanja.
   */
  nesigurnost: number;
  /** Da li je meren kao tema u Google Trends-u (sve pretrage o pojmu) ili kao tačan tekst pretrage. */
  mera: "tema" | "tekst";
};

/** Jedan duel: dva pojma i njihov odnos. */
export type Par = {
  a: string;
  b: string;
  upitA: string;
  upitB: string;
  /** Indeks 0–100 unutar para: češće traženi pojam je 100, drugi srazmerno manje. */
  indeksA: number;
  indeksB: number;
  period: string;
  preuzeto: string;
};

export type UcitaniTrendovi = {
  period: string;
  preuzeto: string;
  /** Pojmovi koji mogu u igru (dovoljno pretraga da je merenje pouzdano). */
  pojmovi: Pojam[];
  izbaceni: { naziv: string; razlog: string }[];
  /** Najveće neslaganje između dva merenja istog odnosa (0,03 = 3%). Mera pouzdanosti zajedničke skale. */
  najveceOdstupanje: number;
};

/** Ispod ovog proseka Trends zaokružuje pregrubo da bi poređenje bilo pouzdano. */
const NAJMANJI_PROSEK = 2;
/** Merenje u mostu se koristi samo ako je bar ovoliko (inače je zaokruživanje preveliko). */
const NAJMANJE_U_MOSTU = 7;
/** Duel je fer samo ako je slabiji pojam najviše 80% jačeg... */
export const NAJVECI_ODNOS = 0.8;
/** ...i ako pobednik ostaje isti i kad se obe jačine pomere za svoju najveću grešku, uz još 10% rezerve za zajedničku skalu. */
const REZERVA_SKALE = 0.9;
/** Dodatna nesigurnost za pojam meren kao tačan tekst. */
const NESIGURNOST_TEKSTA = 0.25;
/** Upit koji počinje kosom crtom je oznaka teme u Google Trends-u (npr. /m/0110q02h). */
const jeTema = (upit: string) => upit.startsWith("/");
/** ...i bar 20% jačeg: ispod toga je preočigledno. */
export const NAJMANJI_ODNOS = 0.2;

const jeTekst = (x: unknown): x is string => typeof x === "string" && x.trim().length > 0;
const jeBroj = (x: unknown): x is number => typeof x === "number" && Number.isFinite(x) && x >= 0;

type SiroviPojam = { tema: string; naziv: string; upit: string; prosek: number };

export function ucitajTrendove(json: unknown): UcitaniTrendovi {
  const koren = json as { period?: unknown; datum_preuzimanja?: unknown; grupe?: unknown; mostovi?: unknown };
  if (!koren || !Array.isArray(koren.grupe)) throw new Error("trends.json: fali niz „grupe”.");
  if (!jeTekst(koren.period)) throw new Error("trends.json: fali „period”.");
  if (!jeTekst(koren.datum_preuzimanja) || !/^\d{4}-\d{2}-\d{2}$/.test(koren.datum_preuzimanja)) {
    throw new Error("trends.json: fali „datum_preuzimanja” u obliku YYYY-MM-DD.");
  }

  // ───── grupe ─────
  const sirovi: SiroviPojam[] = [];
  const teme: string[] = [];
  for (const grupa of koren.grupe as { tema?: unknown; pojmovi?: unknown }[]) {
    if (!jeTekst(grupa.tema) || !Array.isArray(grupa.pojmovi)) throw new Error("trends.json: grupa bez teme ili pojmova.");
    teme.push(grupa.tema);
    for (const p of grupa.pojmovi as { naziv?: unknown; upit?: unknown; prosek?: unknown }[]) {
      if (!jeTekst(p.naziv) || !jeTekst(p.upit) || !jeBroj(p.prosek)) {
        throw new Error(`trends.json: pojam u grupi „${grupa.tema}” nema naziv, upit ili prosek.`);
      }
      if (sirovi.some((s) => s.upit === p.upit)) throw new Error(`trends.json: upit „${p.upit}” se javlja dvaput.`);
      sirovi.push({ tema: grupa.tema, naziv: p.naziv, upit: p.upit, prosek: p.prosek });
    }
  }
  const poUpitu = new Map(sirovi.map((s) => [s.upit, s]));

  // ───── mostovi → jedna skala ─────
  // Svako upotrebljivo merenje kaže: prosek_u_grupi × faktor_grupe = vrednost_u_mostu × skala_mosta.
  // Nepoznate (faktor svake grupe, skala svakog mosta) se nalaze uzastopnim usrednjavanjem u logaritmima.
  type Merenje = { most: number; tema: string; razlika: number; tezina: number };
  const merenja: Merenje[] = [];
  const mostovi = Array.isArray(koren.mostovi) ? (koren.mostovi as { upiti?: unknown; prosek?: unknown }[]) : [];
  mostovi.forEach((m, i) => {
    if (!Array.isArray(m.upiti) || !Array.isArray(m.prosek) || m.upiti.length !== m.prosek.length) {
      throw new Error(`trends.json: most ${i + 1} nije ispravan.`);
    }
    m.upiti.forEach((upit, k) => {
      const vrednost = (m.prosek as unknown[])[k];
      const pojam = jeTekst(upit) ? poUpitu.get(upit) : undefined;
      if (!pojam || !jeBroj(vrednost)) throw new Error(`trends.json: most ${i + 1} ima nepoznat upit ili lošu vrednost.`);
      if (vrednost < NAJMANJE_U_MOSTU || pojam.prosek < NAJMANJE_U_MOSTU) return;
      // razlika = log(vrednost u mostu) − log(prosek u grupi) = log(faktor grupe) − log(skala mosta)
      merenja.push({ most: i, tema: pojam.tema, razlika: Math.log(vrednost) - Math.log(pojam.prosek), tezina: Math.min(vrednost, 30) });
    });
  });

  const logFaktor = new Map<string, number>(teme.map((t) => [t, 0]));
  const logSkala = new Map<number, number>();
  const sidro = teme[0];
  const prosekTezinski = (lista: { v: number; w: number }[]) =>
    lista.reduce((z, x) => z + x.v * x.w, 0) / lista.reduce((z, x) => z + x.w, 0);
  const povezane = new Set<string>([sidro]);
  // Koje su teme uopšte povezane sa sidrom preko mostova?
  for (let promena = true; promena; ) {
    promena = false;
    for (let i = 0; i < mostovi.length; i++) {
      const uMostu = merenja.filter((m) => m.most === i).map((m) => m.tema);
      if (uMostu.some((t) => povezane.has(t))) {
        for (const t of uMostu) if (!povezane.has(t)) { povezane.add(t); promena = true; }
      }
    }
  }
  for (let krug = 0; krug < 300; krug++) {
    for (let i = 0; i < mostovi.length; i++) {
      const svoja = merenja.filter((m) => m.most === i && povezane.has(m.tema));
      if (svoja.length) logSkala.set(i, prosekTezinski(svoja.map((m) => ({ v: logFaktor.get(m.tema)! - m.razlika, w: m.tezina }))));
    }
    for (const tema of povezane) {
      if (tema === sidro) continue;
      const svoja = merenja.filter((m) => m.tema === tema && logSkala.has(m.most));
      if (svoja.length) logFaktor.set(tema, prosekTezinski(svoja.map((m) => ({ v: m.razlika + logSkala.get(m.most)!, w: m.tezina }))));
    }
  }
  const najveceOdstupanje = merenja
    .filter((m) => povezane.has(m.tema) && logSkala.has(m.most))
    .reduce((max, m) => Math.max(max, Math.abs(Math.exp(logFaktor.get(m.tema)! - logSkala.get(m.most)! - m.razlika) - 1)), 0);

  // ───── pojmovi za igru ─────
  const pojmovi: Pojam[] = [];
  const izbaceni: UcitaniTrendovi["izbaceni"] = [];
  for (const s of sirovi) {
    if (!povezane.has(s.tema)) { izbaceni.push({ naziv: s.naziv, razlog: `tema „${s.tema}” nije povezana mostom sa ostalima` }); continue; }
    if (s.prosek < NAJMANJI_PROSEK) { izbaceni.push({ naziv: s.naziv, razlog: "premalo pretraga za pouzdano poređenje" }); continue; }
    pojmovi.push({
      tema: s.tema,
      naziv: s.naziv,
      upit: s.upit,
      prosekUGrupi: s.prosek,
      jacina: s.prosek * Math.exp(logFaktor.get(s.tema)!),
      nesigurnost: 0.5 / s.prosek + (jeTema(s.upit) ? 0 : NESIGURNOST_TEKSTA),
      mera: jeTema(s.upit) ? "tema" : "tekst",
    });
  }

  return { period: koren.period, preuzeto: koren.datum_preuzimanja, pojmovi, izbaceni, najveceOdstupanje };
}

/** Odnos slabijeg i jačeg pojma (0–1). */
export function odnos(x: Pojam, y: Pojam): number {
  return Math.min(x.jacina, y.jacina) / Math.max(x.jacina, y.jacina);
}

/** Da li je duel fer: jasan pobednik, ali ne preočigledan. */
export function ferDuel(x: Pojam, y: Pojam): boolean {
  if (x.upit === y.upit) return false;
  const r = odnos(x, y);
  if (r < NAJMANJI_ODNOS || r > NAJVECI_ODNOS) return false;
  const [jaci, slabiji] = x.jacina >= y.jacina ? [x, y] : [y, x];
  return slabiji.jacina * (1 + slabiji.nesigurnost) <= jaci.jacina * (1 - jaci.nesigurnost) * REZERVA_SKALE;
}

/** Duel sa pojmom `a` levo i `b` desno. Jači dobija 100, slabiji srazmerno manje. */
export function napraviPar(a: Pojam, b: Pojam, period: string, preuzeto: string): Par {
  const veci = Math.max(a.jacina, b.jacina);
  return {
    a: a.naziv,
    b: b.naziv,
    upitA: a.upit,
    upitB: b.upit,
    indeksA: Math.round((a.jacina / veci) * 100),
    indeksB: Math.round((b.jacina / veci) * 100),
    period,
    preuzeto,
  };
}
