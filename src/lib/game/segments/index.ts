import type { Ocena, Pitanje, Prikaz } from "../types";
import { cena } from "./cena";

/**
 * Svaki segment ima svog „rukovaoca”: zna šta od pitanja sme da ode u browser,
 * kako se odgovor ocenjuje i kako se sačuvan odgovor prikazuje na rezultatu.
 * Novi segment = novi fajl ovde + red u RUKOVAOCI.
 */
export type Rukovalac = {
  maxPoena: number;
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
  2: cena,
};
