import { FILM_POENI } from "@/config/quiz.config";
import { slicno } from "@/lib/match";
import { poeniFilm } from "@/lib/scoring";
import type { Ocena, PitanjeFilm, PrikazFilm } from "../types";
import type { Rukovalac } from "./index";

/** Ono što je zamrznuto uz pitanje kad je kviz napravljen (vidi lib/content/seed.ts). */
type SnapshotFilm = { naslov: string; alias: string[]; slika: string };

/** Šta se čuva u play_answers.answer. */
type SacuvanoFilm = { odgovor: string | null; neZnam: boolean; tacno: boolean };

const NAJDUZI_ODGOVOR = 120;

function procitaj(odgovor: unknown): { tekst: string | null; neZnam: boolean } {
  if (!odgovor || typeof odgovor !== "object") return { tekst: null, neZnam: false };
  const o = odgovor as { tekst?: unknown; neZnam?: unknown };
  const tekst = typeof o.tekst === "string" && o.tekst.trim() ? o.tekst.trim().slice(0, NAJDUZI_ODGOVOR) : null;
  return { tekst, neZnam: o.neZnam === true };
}

function prikaz(s: SnapshotFilm, c: SacuvanoFilm): PrikazFilm {
  return { vrsta: "film", naslov: s.naslov, slika: s.slika, odgovor: c.odgovor, neZnam: c.neZnam, tacno: c.tacno };
}

/**
 * „Pogodi domaći film/seriju”: igrač vidi kadar i kuca naslov. Nema ponuđenih odgovora,
 * ali se kucanje poredi tolerantno (kvačice, ćirilica, omaška), pa „balkanski spijun” prolazi.
 */
export const film: Rukovalac = {
  maxPoena: FILM_POENI,

  javno(snapshot): PitanjeFilm {
    // Samo slika: naslov i dodatni oblici naslova ostaju na serveru.
    return { vrsta: "film", slika: (snapshot as SnapshotFilm).slika };
  },

  oceni(snapshot, odgovor, { istek }): { ocena: Ocena; sacuvaj: SacuvanoFilm } {
    const s = snapshot as SnapshotFilm;
    const o = istek ? { tekst: null, neZnam: false } : procitaj(odgovor);
    const tacno = !o.neZnam && o.tekst !== null && slicno(o.tekst, [s.naslov, ...(s.alias ?? [])]);
    const sacuvaj: SacuvanoFilm = { odgovor: o.neZnam ? null : o.tekst, neZnam: o.neZnam, tacno };
    return { ocena: { tacno, poeni: poeniFilm(tacno), maxPoena: FILM_POENI, istek, prikaz: prikaz(s, sacuvaj) }, sacuvaj };
  },

  izSacuvanog(snapshot, sacuvano) {
    const c = (sacuvano as SacuvanoFilm | null) ?? { odgovor: null, neZnam: false, tacno: false };
    return prikaz(snapshot as SnapshotFilm, c);
  },
};
