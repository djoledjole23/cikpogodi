import { PESMA_PRAGOVI } from "@/config/quiz.config";
import { slicno, tacniObliciPesme } from "@/lib/match";
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

function procitaj(odgovor: unknown): { songId: number | null; tekst: string | null; neZnam: boolean } {
  if (!odgovor || typeof odgovor !== "object") return { songId: null, tekst: null, neZnam: false };
  const o = odgovor as { songId?: unknown; tekst?: unknown; neZnam?: unknown };
  const tekst = typeof o.tekst === "string" && o.tekst.trim() ? o.tekst.trim().slice(0, NAJDUZI_ODGOVOR) : null;
  const songId = typeof o.songId === "number" && Number.isInteger(o.songId) ? o.songId : null;
  return { songId, tekst, neZnam: o.neZnam === true };
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
    return { deezerId: s.deezerId ?? null, itunesId: s.itunesId ?? null };
  },

  oceni(snapshot, odgovor, { protekloMs, istek }): { ocena: Ocena; sacuvaj: SacuvanoPesma } {
    const s = snapshot as SnapshotPesma;
    const o = istek ? { songId: null, tekst: null, neZnam: false } : procitaj(odgovor);

    let tacno = false;
    if (!o.neZnam) {
      // Pesma izabrana iz kataloga se poredi po broju; ukucan tekst tolerantno, po naslovu (sa izvođačem ili bez njega).
      if (o.songId !== null) tacno = o.songId === s.songId;
      else if (o.tekst) tacno = slicno(o.tekst, tacniObliciPesme(s));
    }
    const poeni = poeniPesma(tacno, protekloMs);
    const sacuvaj: SacuvanoPesma = {
      odgovor: o.neZnam ? null : (o.tekst ?? (o.songId !== null ? "druga pesma" : null)),
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
