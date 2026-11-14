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
      try {
        const redovi = await izvor.unsafe(tekst, params as postgres.ParameterOrJSON<never>[]);
        return redovi as unknown as T[];
      } catch (e) {
        objasni(e);
        throw e;
      }
    },
    async transaction<T>(fn: (tx: Db) => Promise<T>) {
      // Već smo u transakciji: nastavi u istoj.
      if (izvor !== sql) return fn(omotaj(izvor));
      return sql.begin((tx) => fn(omotaj(tx))) as Promise<T>;
    },
  });

  return omotaj(sql);
}

/** Česte greške u DATABASE_URL: ispiši u konzoli šta da se uradi, umesto gole poruke iz Postgresa. */
let objasnjeno = false;
function objasni(e: unknown) {
  if (objasnjeno) return;
  const kod = (e as { code?: string })?.code;
  const poruke: Record<string, string> = {
    "28P01": "Sifra baze u DATABASE_URL nije tacna. U Supabase-u: Settings -> Database -> Reset database password,\n" +
      "   pa novu sifru upisi u .env.local umesto [YOUR-PASSWORD]. Koristi samo slova i brojeve\n" +
      "   (znaci kao @ : / ? # kvare adresu). Posle izmene ugasi crni prozor i pokreni pokreni.bat ponovo.",
    "28000": "Korisnicko ime u DATABASE_URL nije tacno. Kopiraj adresu ponovo: Supabase -> Connect -> Transaction pooler.",
    ENOTFOUND: "Adresa baze iz DATABASE_URL ne postoji. Kopiraj je ponovo: Supabase -> Connect -> Transaction pooler.",
    ETIMEDOUT: "Baza se ne javlja. Proveri internet i da li je Supabase projekat upaljen (ne spava).",
  };
  const poruka = kod ? poruke[kod] : undefined;
  if (!poruka) return;
  objasnjeno = true;
  console.error(`\n[baza] ${poruka}\n`);
}
