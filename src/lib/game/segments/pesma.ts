import { PESMA_PRAGOVI } from "@/config/quiz.config";
import { normalizuj, slicno, tacniObliciPesme } from "@/lib/match";
import { poeniPesma } from "@/lib/scoring";
import type { Ocena, PitanjePesma, PrikazPesma } from "../types";
import type { Rukovalac } from "./index";

/** Ono što je zamrznuto uz pitanje kad je kviz napravljen (vidi lib/content/seed.ts). */
export type SnapshotPesma = {
  songId: number;
  izvodjac: string;
  naslov: string;
  /** Drugi oblici naslova koji se priznaju. */
  alias: string[];
  deezerId: number | null;
  itunesId: number | null;
  omot: string;
};

/** Šta se čuva u play_answers.answer. */
type SacuvanoPesma = { odgovor: string | null; neZnam: boolean; tacno: boolean; ms: number };

const MAX_POENA = Math.max(...PESMA_PRAGOVI.map((p) => p.poeni));
const NAJDUZI_ODGOVOR = 120;

type Izbor = { izvodjac: string; naslov: string };

function procitaj(odgovor: unknown): { izbor: Izbor | null; tekst: string | null; neZnam: boolean } {
  if (!odgovor || typeof odgovor !== "object") return { izbor: null, tekst: null, neZnam: false };
  const o = odgovor as { izbor?: unknown; tekst?: unknown; neZnam?: unknown };
  const tekst = typeof o.tekst === "string" && o.tekst.trim() ? o.tekst.trim().slice(0, NAJDUZI_ODGOVOR) : null;
  const i = o.izbor as { izvodjac?: unknown; naslov?: unknown } | null | undefined;
  const izbor =
    i && typeof i === "object" && typeof i.izvodjac === "string" && typeof i.naslov === "string" && i.naslov.trim()
      ? { izvodjac: i.izvodjac.slice(0, NAJDUZI_ODGOVOR), naslov: i.naslov.slice(0, NAJDUZI_ODGOVOR) }
      : null;
  return { izbor, tekst, neZnam: o.neZnam === true };
}

/** Pesma izabrana sa spiska je tačna samo ako je baš ta: isti izvođač i isti naslov (ili priznati oblik naslova). */
function istaPesma(izbor: Izbor, s: SnapshotPesma): boolean {
  if (normalizuj(izbor.izvodjac) !== normalizuj(s.izvodjac)) return false;
  const naslov = normalizuj(izbor.naslov);
  return [s.naslov, ...(s.alias ?? [])].some((n) => normalizuj(n) === naslov);
}

function prikaz(s: SnapshotPesma, c: SacuvanoPesma): PrikazPesma {
  return {
    vrsta: "pesma",
    izvodjac: s.izvodjac,
    naslov: s.naslov,
    omot: s.omot,
    odgovor: c.odgovor,
    neZnam: c.neZnam,
    tacno: c.tacno,
    slusanoMs: c.ms,
  };
}

export const pesma: Rukovalac = {
  maxPoena: MAX_POENA,
  meriSlusanje: true,

  javno(): PitanjePesma {
    // Ništa o pesmi ne ide u browser: ni naslov, ni izvođač, ni Deezer ID.
    return { vrsta: "pesma" };
  },

  audio(snapshot) {
    const s = snapshot as SnapshotPesma;
    return { deezerId: s.deezerId ?? null, itunesId: s.itunesId ?? null, izvodjac: s.izvodjac, naslov: s.naslov };
  },

  oceni(snapshot, odgovor, { protekloMs, istek }): { ocena: Ocena; sacuvaj: SacuvanoPesma } {
    const s = snapshot as SnapshotPesma;
    const o = istek ? { izbor: null, tekst: null, neZnam: false } : procitaj(odgovor);

    let tacno = false;
    if (!o.neZnam) {
      // Pesma izabrana sa spiska mora da bude baš ta; ukucan tekst se poredi tolerantno, po naslovu (sa izvođačem ili bez njega).
      if (o.izbor) tacno = istaPesma(o.izbor, s);
      else if (o.tekst) tacno = slicno(o.tekst, tacniObliciPesme(s));
    }
    const poeni = poeniPesma(tacno, protekloMs);
    const sacuvaj: SacuvanoPesma = {
      odgovor: o.neZnam ? null : (o.tekst ?? (o.izbor ? `${o.izbor.izvodjac} – ${o.izbor.naslov}`.slice(0, NAJDUZI_ODGOVOR) : null)),
      neZnam: o.neZnam,
      tacno,
      ms: protekloMs,
    };
    return { ocena: { tacno: poeni > 0, poeni, maxPoena: MAX_POENA, istek, prikaz: prikaz(s, sacuvaj) }, sacuvaj };
  },

  izSacuvanog(snapshot, sacuvano) {
    const c = (sacuvano as SacuvanoPesma | null) ?? { odgovor: null, neZnam: false, tacno: false, ms: 0 };
    return prikaz(snapshot as SnapshotPesma, c);
  },
};
