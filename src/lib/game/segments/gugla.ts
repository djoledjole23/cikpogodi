import { GUGLA_POENI } from "@/config/quiz.config";
import { poeniGugla } from "@/lib/scoring";
import type { Ocena, PitanjeGugla, PrikazGugla } from "../types";
import type { Rukovalac } from "./index";

/** Ono što je zamrznuto uz pitanje kad je kviz napravljen (vidi lib/content/seed.ts). */
type SnapshotGugla = {
  a: string;
  b: string;
  indeksA: number;
  indeksB: number;
  period: string;
};

/** Šta se čuva u play_answers.answer. */
type SacuvanoGugla = { izbor: "a" | "b" | null };

function procitajIzbor(odgovor: unknown): "a" | "b" | null {
  if (!odgovor || typeof odgovor !== "object") return null;
  const izbor = (odgovor as { izbor?: unknown }).izbor;
  return izbor === "a" || izbor === "b" ? izbor : null;
}

function prikaz(s: SnapshotGugla, izbor: "a" | "b" | null): PrikazGugla {
  return {
    vrsta: "gugla",
    a: s.a,
    b: s.b,
    indeksA: s.indeksA,
    indeksB: s.indeksB,
    puta: Math.round((Math.max(s.indeksA, s.indeksB) / Math.max(1, Math.min(s.indeksA, s.indeksB))) * 10) / 10,
    izbor,
    tacan: s.indeksA > s.indeksB ? "a" : "b",
    period: s.period,
  };
}

export const gugla: Rukovalac = {
  maxPoena: GUGLA_POENI,

  javno(snapshot): PitanjeGugla {
    const s = snapshot as SnapshotGugla;
    // Samo dva naziva: indeksi ne smeju da odu u browser pre odgovora.
    return { vrsta: "gugla", a: s.a, b: s.b };
  },

  oceni(snapshot, odgovor, { istek }): { ocena: Ocena; sacuvaj: SacuvanoGugla } {
    const s = snapshot as SnapshotGugla;
    const izbor = istek ? null : procitajIzbor(odgovor);
    const p = prikaz(s, izbor);
    const tacno = izbor !== null && izbor === p.tacan;
    return {
      ocena: { tacno, poeni: poeniGugla(tacno), maxPoena: GUGLA_POENI, istek, prikaz: p },
      sacuvaj: { izbor },
    };
  },

  izSacuvanog(snapshot, sacuvano) {
    return prikaz(snapshot as SnapshotGugla, (sacuvano as SacuvanoGugla | null)?.izbor ?? null);
  },
};
