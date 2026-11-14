import type { Ocena, Pitanje, Prikaz } from "../types";
import { cena } from "./cena";
import { film } from "./film";
import { gugla } from "./gugla";
import { pesma } from "./pesma";

/**
 * Svaki segment ima svog „rukovaoca”: zna šta od pitanja sme da ode u browser,
 * kako se odgovor ocenjuje i kako se sačuvan odgovor prikazuje na rezultatu.
 * Novi segment = novi fajl ovde + red u RUKOVAOCI.
 */
export type Rukovalac = {
  maxPoena: number;
  /** Vreme pitanja je preslušano vreme (pusti/pauza), a ne vreme od slanja pitanja. */
  meriSlusanje?: boolean;
  /** Odakle se pušta zvuk (samo segmenti sa zvukom). Ne ide u browser: koristi ga ruta /api/track. */
  audio?(snapshot: unknown): { deezerId: number | null; itunesId: number | null };
  /** Pitanje bez tačnog odgovora. */
  javno(snapshot: unknown): Pitanje;
  /** Ocenjuje odgovor. `sacuvaj` ide u bazu (play_answers.answer). */
  oceni(
    snapshot: unknown,
    odgovor: unknown,
    kontekst: { protekloMs: number; istek: boolean },
  ): { ocena: Ocena; sacuvaj: unknown };
  /** Prikaz već odgovorenog pitanja (za ekran rezultata). */
  izSacuvanog(snapshot: unknown, sacuvano: unknown): Prikaz;
};

/** Ključ je broj segmenta. Stavke kviza za segmente kojih ovde nema se preskaču. */
export const RUKOVAOCI: Record<number, Rukovalac> = {
  1: pesma,
  2: cena,
  3: gugla,
  4: film,
};
