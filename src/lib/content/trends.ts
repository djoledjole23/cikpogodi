/**
 * Čitanje data/trends.json (Google Trends, Srbija, poslednjih 12 meseci) i pravljenje parova.
 *
 * Pojmovi se porede samo unutar iste grupe, jer su samo tu na zajedničkoj skali.
 * Brojevi se ne izmišljaju i ne dopunjavaju: par koji nije jasan se izbacuje.
 */

export type Par = {
  tema: string;
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
  parovi: Par[];
  izbaceni: { par: string; razlog: string }[];
};

/** Ispod ovog proseka Trends zaokružuje pregrubo da bi poređenje bilo pouzdano. */
const NAJMANJI_PROSEK = 2;
/** Manji pojam mora da bude bar ovoliko (10%) većeg: inače je pitanje preočigledno. */
const NAJMANJI_ODNOS = 0.1;
/** ...i najviše ovoliko (90%): bliže od toga je praktično nerešeno, pa nije fer pitati. */
const NAJVECI_ODNOS = 0.9;

const jeTekst = (x: unknown): x is string => typeof x === "string" && x.trim().length > 0;
const jeBroj = (x: unknown): x is number => typeof x === "number" && Number.isFinite(x) && x >= 0;

function semeIzTeksta(tekst: string): number {
  let h = 2166136261;
  for (let i = 0; i < tekst.length; i++) {
    h ^= tekst.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return h >>> 0;
}

export function ucitajTrendove(json: unknown): UcitaniTrendovi {
  const koren = json as { period?: unknown; datum_preuzimanja?: unknown; grupe?: unknown };
  if (!koren || !Array.isArray(koren.grupe)) throw new Error("trends.json: fali niz „grupe”.");
  if (!jeTekst(koren.period)) throw new Error("trends.json: fali „period”.");
  if (!jeTekst(koren.datum_preuzimanja) || !/^\d{4}-\d{2}-\d{2}$/.test(koren.datum_preuzimanja)) {
    throw new Error("trends.json: fali „datum_preuzimanja” u obliku YYYY-MM-DD.");
  }

  const parovi: Par[] = [];
  const izbaceni: UcitaniTrendovi["izbaceni"] = [];
  const vidjeni = new Set<string>();

  for (const grupa of koren.grupe as { tema?: unknown; pojmovi?: unknown }[]) {
    if (!jeTekst(grupa.tema) || !Array.isArray(grupa.pojmovi)) throw new Error("trends.json: grupa bez teme ili pojmova.");
    const pojmovi = grupa.pojmovi as { naziv?: unknown; upit?: unknown; prosek?: unknown }[];
    for (const p of pojmovi) {
      if (!jeTekst(p.naziv) || !jeTekst(p.upit) || !jeBroj(p.prosek)) {
        throw new Error(`trends.json: pojam u grupi „${grupa.tema}” nema naziv, upit ili prosek.`);
      }
    }

    for (let i = 0; i < pojmovi.length; i++) {
      for (let j = i + 1; j < pojmovi.length; j++) {
        const x = pojmovi[i] as { naziv: string; upit: string; prosek: number };
        const y = pojmovi[j] as { naziv: string; upit: string; prosek: number };
        const ime = `${x.naziv} / ${y.naziv}`;
        const manji = Math.min(x.prosek, y.prosek);
        const veci = Math.max(x.prosek, y.prosek);
        if (manji < NAJMANJI_PROSEK) { izbaceni.push({ par: ime, razlog: "premalo pretraga za pouzdano poređenje" }); continue; }
        const odnos = manji / veci;
        if (odnos > NAJVECI_ODNOS) { izbaceni.push({ par: ime, razlog: "praktično nerešeno" }); continue; }
        if (odnos < NAJMANJI_ODNOS) { izbaceni.push({ par: ime, razlog: "preočigledno" }); continue; }

        // Ko je levo, a ko desno: zavisi samo od naziva, da tačan odgovor ne bude uvek na istoj strani.
        const obrni = semeIzTeksta(`${x.upit}|${y.upit}`) % 2 === 1;
        const [prvi, drugi] = obrni ? [y, x] : [x, y];
        const kljuc = [prvi.upit, drugi.upit].sort().join("|");
        if (vidjeni.has(kljuc)) continue;
        vidjeni.add(kljuc);
        parovi.push({
          tema: grupa.tema,
          a: prvi.naziv,
          b: drugi.naziv,
          upitA: prvi.upit,
          upitB: drugi.upit,
          indeksA: Math.round((prvi.prosek / veci) * 100),
          indeksB: Math.round((drugi.prosek / veci) * 100),
          period: koren.period,
          preuzeto: koren.datum_preuzimanja,
        });
      }
    }
  }
  return { period: koren.period, preuzeto: koren.datum_preuzimanja, parovi, izbaceni };
}
