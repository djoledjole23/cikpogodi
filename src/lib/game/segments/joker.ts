import { JOKER_POENI } from "@/config/quiz.config";
import { slicno } from "@/lib/match";
import { poeniJoker } from "@/lib/scoring";
import type { Ocena, PitanjeJoker, PrikazJoker } from "../types";
import type { Rukovalac } from "./index";

/** Ono što je zamrznuto uz pitanje kad je kviz napravljen (vidi lib/content/seed.ts). */
export type SnapshotJoker = {
  pitanje: string;
  odgovor: string;
  alias: string[];
  slika: string | null;
  broj: string | null;
  natpis: string | null;
};

/** Šta se čuva u play_answers.answer. */
type SacuvanoJoker = { odgovor: string | null; neZnam: boolean; tacno: boolean };

const NAJDUZI_ODGOVOR = 120;

function procitaj(odgovor: unknown): { tekst: string | null; neZnam: boolean } {
  if (!odgovor || typeof odgovor !== "object") return { tekst: null, neZnam: false };
  const o = odgovor as { tekst?: unknown; neZnam?: unknown };
  const tekst = typeof o.tekst === "string" && o.tekst.trim() ? o.tekst.trim().slice(0, NAJDUZI_ODGOVOR) : null;
  return { tekst, neZnam: o.neZnam === true };
}

function prikaz(s: SnapshotJoker, c: SacuvanoJoker): PrikazJoker {
  return {
    vrsta: "joker",
    pitanje: s.pitanje,
    resenje: s.odgovor,
    slika: s.slika ?? null,
    broj: s.broj ?? null,
    natpis: s.natpis ?? null,
    odgovor: c.odgovor,
    neZnam: c.neZnam,
    tacno: c.tacno,
  };
}

/**
 * „Joker pitanje”: jedno pitanje dnevno za bonus. Igrač kuca odgovor, a poredi se tolerantno
 * (kvačice, ćirilica, omaška, priznati oblici kao „Anthony”). Tačno nosi 50 preko svega, sve ostalo 0.
 */
export const joker: Rukovalac = {
  maxPoena: JOKER_POENI,

  javno(snapshot): PitanjeJoker {
    // Samo tekst pitanja: odgovor, fotografija i broj se šalju tek sa ocenom.
    return { vrsta: "joker", pitanje: (snapshot as SnapshotJoker).pitanje };
  },

  oceni(snapshot, odgovor, { istek }): { ocena: Ocena; sacuvaj: SacuvanoJoker } {
    const s = snapshot as SnapshotJoker;
    const o = istek ? { tekst: null, neZnam: false } : procitaj(odgovor);
    const tacno = !o.neZnam && o.tekst !== null && slicno(o.tekst, [s.odgovor, ...(s.alias ?? [])]);
    const sacuvaj: SacuvanoJoker = { odgovor: o.neZnam ? null : o.tekst, neZnam: o.neZnam, tacno };
    return { ocena: { tacno, poeni: poeniJoker(tacno), maxPoena: JOKER_POENI, istek, prikaz: prikaz(s, sacuvaj) }, sacuvaj };
  },

  izSacuvanog(snapshot, sacuvano) {
    const c = (sacuvano as SacuvanoJoker | null) ?? { odgovor: null, neZnam: false, tacno: false };
    return prikaz(snapshot as SnapshotJoker, c);
  },
};
