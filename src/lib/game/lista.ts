import type { Db } from "@/lib/db/types";
import { botoviZaDan, botovaIspred } from "./botovi";
import { dodajDane, pocetakNedelje } from "@/lib/time";
import type { Identitet, Stanje } from "./types";

/**
 * Rang lista: Danas / Ova nedelja / Ukupno. Sabira završene igre koje su „na listi”
 * (nalog sa potvrđenim mejlom i korisničkim imenom). Kod istog broja poena bolji je onaj
 * ko je ukupno brže odgovarao; sve to radi funkcija public.leaderboard u bazi.
 */

export const PERIODI = ["danas", "nedelja", "ukupno"] as const;
export type Period = (typeof PERIODI)[number];
export const NAZIV_PERIODA: Record<Period, string> = { danas: "Danas", nedelja: "Ova nedelja", ukupno: "Ukupno" };
export const NAJVISE_NA_LISTI = 50;

export type RedListe = {
  mesto: number;
  userId: string;
  username: string;
  poeni: number;
  /** Ukupno vreme odgovaranja (za izjednačenje). */
  vremeMs: number;
  /** Koliko igara ulazi u zbir (za nedelju i ukupno). */
  igara: number;
  /** Red igrača koji gleda listu. */
  ja: boolean;
};

export const jePeriod = (x: unknown): x is Period => PERIODI.includes(x as Period);

/** Od kog do kog dana važi period (null = bez granice). Nedelja je ponedeljak–nedelja po beogradskom vremenu. */
export function granicePerioda(period: Period, danas: string): { od: string | null; do: string | null } {
  if (period === "danas") return { od: danas, do: danas };
  if (period === "nedelja") {
    const ponedeljak = pocetakNedelje(danas);
    return { od: ponedeljak, do: dodajDane(ponedeljak, 6) };
  }
  return { od: null, do: null };
}

/** Prvih 50 i, ako je prijavljen, red igrača čak i kad nije među njima. */
export async function rangLista(db: Db, period: Period, danas: string, userId: string | null): Promise<RedListe[]> {
  const { od, do: doDana } = granicePerioda(period, danas);
  const redovi = await db.query<{ rank: number; user_id: string; username: string; score: number; ms: number; games: number }>(
    `select rank::int as rank, user_id::text as user_id, username, score::int as score, total_answer_ms::float8 as ms, games::int as games
     from public.leaderboard($1::date, $2::date, $3::int, $4::uuid)`,
    [od, doDana, NAJVISE_NA_LISTI, userId],
  );
  return redovi.map((r) => ({
    mesto: r.rank,
    userId: r.user_id,
    username: r.username,
    poeni: r.score,
    vremeMs: Math.round(r.ms),
    igara: r.games,
    ja: userId !== null && r.user_id === userId,
  }));
}

/** Mesto igrača na listi za jedan dan, ili null ako nije na njoj. */
export async function mestoNaListi(db: Db, userId: string, datum: string): Promise<number | null> {
  const [red] = await db.query<{ rank: number }>(
    `select rank::int as rank from public.leaderboard($1::date, $1::date, 1, $2::uuid) where user_id = $2::uuid`,
    [datum, userId],
  );
  return red?.rank ?? null;
}

/** Dodaje stanju ono što igra sama ne zna: da li je igrač prijavljen, da li nalozi rade i koje je mesto na listi. */
export async function dopuniStanje(db: Db, ident: Identitet, stanje: Stanje, nalozi: boolean, probnaBaza = false): Promise<Stanje> {
  const dopunjeno: Stanje = { ...stanje, prijavljen: Boolean(ident.userId), nalozi, probnaBaza };
  if (stanje.status === "zavrseno" && stanje.lista === "counted" && ident.userId) {
    const mesto = await mestoNaListi(db, ident.userId, stanje.datum);
    // Isto mesto kao na dnevnoj listi, gde su i botovi.
    dopunjeno.mesto = mesto === null ? null : mesto + botovaIspred(botoviZaDan(stanje.datum), stanje.score);
  }
  if (stanje.status === "zavrseno") {
    const [red] = await db.query<{ n: number }>(
      "select count(*)::int as n from public.plays where quiz_date = $1::date and status = 'finished'",
      [stanje.datum],
    );
    dopunjeno.igralo = red?.n ?? 0;
  }
  return dopunjeno;
}
