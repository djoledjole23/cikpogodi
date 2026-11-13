import type { PGlite, Transaction } from "@electric-sql/pglite";
import type { Db, Param } from "./types";

/**
 * Minimalna zamena za ono što Supabase već ima u svakom projektu: šemu `auth` i uloge.
 * Treba samo PGlite-u (testovi i lokalni razvoj), nikad pravoj bazi.
 */
export const SUPABASE_ZAMENA = `
  create schema if not exists auth;
  create table if not exists auth.users (
    id uuid primary key default gen_random_uuid(),
    email text,
    email_confirmed_at timestamptz,
    raw_user_meta_data jsonb
  );
  create or replace function auth.uid() returns uuid language sql stable as $$
    select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid
  $$;
  do $$ begin
    if not exists (select 1 from pg_roles where rolname = 'anon') then create role anon nologin; end if;
    if not exists (select 1 from pg_roles where rolname = 'authenticated') then create role authenticated nologin; end if;
    if not exists (select 1 from pg_roles where rolname = 'service_role') then create role service_role nologin bypassrls; end if;
  end $$;
  grant usage on schema public to anon, authenticated, service_role;
  alter default privileges in schema public grant all on tables to anon, authenticated, service_role;
  alter default privileges in schema public grant all on sequences to anon, authenticated, service_role;
  alter default privileges in schema public grant execute on functions to anon, authenticated, service_role;
`;

/** Omotač oko PGlite-a u oblik `Db`. */
export function omotajPglite(pg: PGlite): Db {
  const omotaj = (izvor: PGlite | Transaction, uTransakciji: boolean): Db => ({
    async query<T>(tekst: string, params: Param[] = []) {
      const r = await izvor.query<T>(tekst, params);
      return r.rows;
    },
    async transaction<T>(fn: (tx: Db) => Promise<T>) {
      if (uTransakciji) return fn(omotaj(izvor, true));
      return (izvor as PGlite).transaction((tx) => fn(omotaj(tx, true))) as Promise<T>;
    },
  });
  return omotaj(pg, false);
}
