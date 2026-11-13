import { readFileSync } from "node:fs";
import { join } from "node:path";
import { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";

/**
 * Pokreće migraciju na pravom Postgresu u memoriji (PGlite), sa minimalnom zamenom
 * za Supabase `auth` šemu i uloge, i proverava ono što je bitno za fer igru.
 */
const SUPABASE_STUB = `
  create schema auth;
  create table auth.users (
    id uuid primary key default gen_random_uuid(),
    email text,
    email_confirmed_at timestamptz,
    raw_user_meta_data jsonb
  );
  create function auth.uid() returns uuid language sql stable as $$
    select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid
  $$;
  create role anon nologin;
  create role authenticated nologin;
  create role service_role nologin bypassrls;
  grant usage on schema public to anon, authenticated, service_role;
  alter default privileges in schema public grant all on tables to anon, authenticated, service_role;
  alter default privileges in schema public grant all on sequences to anon, authenticated, service_role;
  alter default privileges in schema public grant execute on functions to anon, authenticated, service_role;
`;

let db: PGlite;
const U1 = "00000000-0000-0000-0000-000000000001";
const U2 = "00000000-0000-0000-0000-000000000002";
const U3 = "00000000-0000-0000-0000-000000000003";
const DEV = "aaaaaaaa-0000-0000-0000-00000000000";

beforeAll(async () => {
  db = new PGlite();
  await db.exec(SUPABASE_STUB);
  const sql = readFileSync(join(__dirname, "../supabase/migrations/0001_init.sql"), "utf8");
  await db.exec(sql);

  await db.exec(`
    insert into auth.users (id, email, email_confirmed_at) values
      ('${U1}', 'a@test.rs', now()), ('${U2}', 'b@test.rs', now()), ('${U3}', 'c@test.rs', null);
    update public.profiles set username = 'Mika' where id = '${U1}';
    update public.profiles set username = 'Žika_22' where id = '${U2}';
    update public.profiles set username = 'Laza' where id = '${U3}';

    insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
      values ('860000000001', 'Test hleb', '500 g', 'https://example.com/h.jpg', 72.99, 65, 80, 'Lidl', '2026-11-13');
    insert into public.daily_quiz (quiz_date, status) values ('2026-11-13', 'published'), ('2026-11-14', 'published');
    insert into public.daily_quiz_items (quiz_date, segment, position, product_id) values ('2026-11-13', 2, 1, 1);

    insert into public.plays (quiz_date, user_id, device_id, status, score, total_answer_ms, leaderboard_status) values
      ('2026-11-13', '${U1}', '${DEV}1', 'finished', 200, 90000, 'counted'),
      ('2026-11-13', '${U2}', '${DEV}2', 'finished', 200, 60000, 'counted'),
      ('2026-11-13', '${U3}', '${DEV}3', 'finished', 340, 50000, 'pending'),
      ('2026-11-14', '${U1}', '${DEV}1', 'finished', 100, 40000, 'counted');
  `);
});

describe("šema", () => {
  it("novi nalog dobija prazan profil", async () => {
    const r = await db.query<{ n: number }>("select count(*)::int as n from public.profiles");
    expect(r.rows[0].n).toBe(3);
  });

  it("korisničko ime je jedinstveno bez obzira na velika i mala slova", async () => {
    await expect(db.exec(`update public.profiles set username = 'MIKA' where id = '${U2}'`)).rejects.toThrow();
    const r = await db.query<{ ok: boolean }>("select public.username_available('mika') as ok");
    expect(r.rows[0].ok).toBe(false);
    const r2 = await db.query<{ ok: boolean }>("select public.username_available('Pera') as ok");
    expect(r2.rows[0].ok).toBe(true);
  });

  it("odbija korisničko ime u pogrešnom formatu", async () => {
    await expect(db.exec(`update public.profiles set username = 'ab' where id = '${U2}'`)).rejects.toThrow();
    await expect(db.exec(`update public.profiles set username = 'ima razmak' where id = '${U2}'`)).rejects.toThrow();
  });

  it("stavka kviza mora da odgovara segmentu", async () => {
    await expect(
      db.exec("insert into public.daily_quiz_items (quiz_date, segment, position, product_id) values ('2026-11-13', 1, 1, 1)"),
    ).rejects.toThrow();
  });

  it("jedan nalog ne može da igra dva puta istog dana", async () => {
    await expect(
      db.exec(`insert into public.plays (quiz_date, user_id, device_id) values ('2026-11-13', '${U1}', '${DEV}9')`),
    ).rejects.toThrow();
  });

  it("gost ne može da igra dva puta istog dana sa istog uređaja", async () => {
    await db.exec(`insert into public.plays (quiz_date, device_id) values ('2026-11-13', '${DEV}7')`);
    await expect(
      db.exec(`insert into public.plays (quiz_date, device_id) values ('2026-11-13', '${DEV}7')`),
    ).rejects.toThrow();
  });
});

describe("rang lista", () => {
  it("kod istog broja poena bolji je brži, a rezultat na čekanju se ne vidi", async () => {
    const r = await db.query<{ rank: string; username: string; score: string }>(
      "select * from public.leaderboard('2026-11-13', '2026-11-13', 50, null)",
    );
    expect(r.rows.map((x) => x.username)).toEqual(["Žika_22", "Mika"]);
    expect(r.rows.map((x) => Number(x.rank))).toEqual([1, 2]);
  });

  it("posle potvrde mejla rezultat ulazi na listu", async () => {
    await db.exec(`update auth.users set email_confirmed_at = now() where id = '${U3}'`);
    const r = await db.query<{ username: string }>(
      "select * from public.leaderboard('2026-11-13', '2026-11-13', 50, null)",
    );
    expect(r.rows[0].username).toBe("Laza");
  });

  it("zbir za period i igrač van vrha", async () => {
    const r = await db.query<{ username: string; score: string; games: string; rank: string }>(
      `select * from public.leaderboard('2026-11-09', '2026-11-15', 1, '${U2}')`,
    );
    // Laza 340, Mika 200+100=300, Žika 200 → vrh je samo Laza, ali Žika (p_user) se ipak vraća
    expect(r.rows.map((x) => x.username)).toEqual(["Laza", "Žika_22"]);
    expect(Number(r.rows[1].rank)).toBe(3);
  });
});

describe("RLS: browser ne vidi tačne odgovore", () => {
  const kaoAnon = async (sql: string) => {
    await db.exec("set role anon");
    try {
      return await db.query(sql);
    } finally {
      await db.exec("reset role");
    }
  };

  it.each(["products", "trend_pairs", "film_clips", "rebuses", "daily_quiz", "daily_quiz_items", "plays", "play_answers", "admins"])(
    "anon ne vidi ništa u tabeli %s",
    async (tabela) => {
      const r = await kaoAnon(`select * from public.${tabela}`);
      expect(r.rows.length).toBe(0);
    },
  );

  it("anon vidi korisnička imena i katalog", async () => {
    const r = await kaoAnon("select username from public.profiles");
    expect(r.rows.length).toBe(3);
  });

  it("anon ne može da upisuje", async () => {
    await expect(kaoAnon(`update public.profiles set username = 'Haker' where id = '${U1}'`)).resolves.toMatchObject({
      affectedRows: 0,
    });
    await expect(kaoAnon("insert into public.songs (artist, title) values ('x', 'y')")).rejects.toThrow();
  });
});
