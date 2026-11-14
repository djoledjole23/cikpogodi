import "server-only";
import { connection } from "next/server";
import { getDb } from "./db";
import { stanjeIgre } from "./game/engine";
import { procitajIdentitet } from "./game/identity";
import type { Stanje } from "./game/types";
import { beogradskiDatum } from "./time";

/**
 * Današnja igra posetioca (ulogovanog ili gosta), za početnu stranu.
 * Vraća null kad nema baze, kad posetilac još nema oznaku uređaja ili kad nešto pukne:
 * početna tada samo prikaže „Započni igru”.
 */
export async function getDanasnjaIgra(): Promise<Stanje | null> {
  // Ovaj deo strane zavisi od posetioca i od trenutnog datuma, pa se uvek računa pri zahtevu (nikad unapred).
  await connection();
  // Čitanje kolačića ostaje van try/catch: tokom pravljenja statičkog dela strane Next ga namerno prekida,
  // i taj prekid mora da stigne do Reacta (ne sme da se „proguta” kao greška).
  const ident = await procitajIdentitet();
  if (!ident) return null;
  try {
    const db = await getDb();
    if (!db) return null;
    return await stanjeIgre(db, ident, beogradskiDatum());
  } catch (e) {
    console.error("[pocetna]", e);
    return null;
  }
}
