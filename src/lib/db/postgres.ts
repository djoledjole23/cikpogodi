import postgres from "postgres";
import type { Db, Param } from "./types";

/** Prava baza (Supabase Postgres preko „Transaction pooler” adrese). */
export function napraviPostgres(url: string): Db {
  const sql = postgres(url, {
    // Pooler u transakcionom režimu ne podržava pripremljene upite.
    prepare: false,
    // Serverless: svaka instanca drži najviše jednu vezu, pooler deli ostalo.
    max: 1,
    idle_timeout: 20,
    connect_timeout: 10,
    ssl: "require",
  });

  const omotaj = (izvor: postgres.Sql | postgres.TransactionSql): Db => ({
    async query<T>(tekst: string, params: Param[] = []) {
      const redovi = await izvor.unsafe(tekst, params as postgres.ParameterOrJSON<never>[]);
      return redovi as unknown as T[];
    },
    async transaction<T>(fn: (tx: Db) => Promise<T>) {
      // Već smo u transakciji: nastavi u istoj.
      if (izvor !== sql) return fn(omotaj(izvor));
      return sql.begin((tx) => fn(omotaj(tx))) as Promise<T>;
    },
  });

  return omotaj(sql);
}
