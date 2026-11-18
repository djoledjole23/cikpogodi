/**
 * Najmanji zajednički oblik baze: običan SQL sa parametrima ($1, $2...).
 * Isti SQL radi na Supabase Postgresu (produkcija) i na PGlite-u (testovi i lokalni razvoj),
 * pa testovi proveravaju baš one upite koji rade na sajtu.
 *
 * Pravila za upite, da oba drajvera vrate isto:
 * - brojeve vraćaj sa `::int` ili `::float8`, datume sa `::text`
 * - jsonb parametre šalji kao JSON tekst uz `$n::text::jsonb` (sa samim `$n::jsonb` postgres drajver
 *   tekst još jednom pretvori u JSON, pa se u bazi nađe string umesto objekta)
 * - bez nizova kao parametara
 */
export type Param = string | number | boolean | null;

export type Db = {
  query<T = Record<string, unknown>>(sql: string, params?: Param[]): Promise<T[]>;
  /** Pusti ceo SQL skript odjednom (više naredbi, bez parametara). Za seed i migracije. */
  exec(sql: string): Promise<void>;
  /** Sve unutar `fn` je jedna transakcija: ili prođe sve, ili ništa. */
  transaction<T>(fn: (tx: Db) => Promise<T>): Promise<T>;
};
