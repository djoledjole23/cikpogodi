import { CENA_PRAGOVI } from "@/config/quiz.config";
import { poeniCena, procenatZaPrikaz } from "@/lib/scoring";
import type { Ocena, PitanjeCena, PrikazCena } from "../types";
import type { Rukovalac } from "./index";

/** Ono što je zamrznuto uz pitanje kad je kviz napravljen (vidi lib/content/seed.ts). */
type SnapshotCena = {
  naziv: string;
  kolicina: string;
  slika: string;
  cena: number;
  min: number;
  max: number;
  najjeftinije: string;
};

/** Šta se čuva u play_answers.answer. */
type SacuvanoCena = { unos: number | null };

const MAX_POENA = Math.max(...CENA_PRAGOVI.map((p) => p.poeni));
/** Najveći unos koji ima smisla (da neko ne pošalje 1e308). */
const NAJVECI_UNOS = 1_000_000;

function procitajUnos(odgovor: unknown): number | null {
  if (!odgovor || typeof odgovor !== "object") return null;
  const unos = (odgovor as { unos?: unknown }).unos;
  if (typeof unos !== "number" || !Number.isFinite(unos) || unos <= 0 || unos > NAJVECI_UNOS) return null;
  // Igrač unosi cele dinare.
  return Math.round(unos);
}

function prikaz(s: SnapshotCena, unos: number | null): PrikazCena {
  return {
    vrsta: "cena",
    naziv: s.naziv,
    kolicina: s.kolicina,
    unos,
    prava: s.cena,
    procenat: unos === null ? "" : procenatZaPrikaz(unos, s.cena),
    min: s.min,
    max: s.max,
    najjeftinije: s.najjeftinije,
  };
}

export const cena: Rukovalac = {
  maxPoena: MAX_POENA,

  javno(snapshot): PitanjeCena {
    const s = snapshot as SnapshotCena;
    // Namerno se nabraja polje po polje: cena, min i max ne smeju da odu u browser.
    return { vrsta: "cena", naziv: s.naziv, kolicina: s.kolicina, slika: s.slika };
  },

  oceni(snapshot, odgovor, { istek }): { ocena: Ocena; sacuvaj: SacuvanoCena } {
    const s = snapshot as SnapshotCena;
    const unos = istek ? null : procitajUnos(odgovor);
    const poeni = unos === null ? 0 : poeniCena(unos, s.cena);
    return {
      ocena: { tacno: poeni > 0, poeni, maxPoena: MAX_POENA, istek, prikaz: prikaz(s, unos) },
      sacuvaj: { unos },
    };
  },

  izSacuvanog(snapshot, sacuvano) {
    const unos = (sacuvano as SacuvanoCena | null)?.unos ?? null;
    return prikaz(snapshot as SnapshotCena, unos);
  },
};
