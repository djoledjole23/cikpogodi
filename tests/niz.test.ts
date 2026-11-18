/** Niz dana zaredom: računa se iz završenih igara, propušten dan ga prekida, a poruka prati broj dana. */
import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { ucitajProizvode } from "@/lib/content/products";
import { seedSql } from "@/lib/content/seed";
import { omotajPglite, SUPABASE_ZAMENA } from "@/lib/db/pglite";
import type { Db } from "@/lib/db/types";
import { danaRec, nizDana, porukaZaNiz } from "@/lib/game/niz";
import { dodajDane } from "@/lib/time";

const koren = join(__dirname, "..");
const POCETAK = "2026-11-10";
let pg: PGlite;
let db: Db;
let brojac = 0;
const uredjaj = () => `eeeeeeee-0000-4000-8000-${String(++brojac).padStart(12, "0")}`;
const dan = (i: number) => dodajDane(POCETAK, i);

async function nalog(): Promise<string> {
  const { rows } = await pg.query<{ id: string }>(
    `insert into auth.users (email, email_confirmed_at) values ($1, now()) returning id::text as id`,
    [`niz${++brojac}@example.com`],
  );
  return rows[0].id;
}

async function igra(datum: string, userId: string | null, deviceId: string, status = "finished") {
  await pg.query(
    `insert into public.plays (quiz_date, user_id, device_id, status, finished_at) values ($1::date, $2::uuid, $3::uuid, $4, now())`,
    [datum, userId, deviceId, status],
  );
}

beforeAll(async () => {
  pg = new PGlite();
  await pg.exec(SUPABASE_ZAMENA);
  for (const f of readdirSync(join(koren, "supabase/migrations")).sort()) {
    await pg.exec(readFileSync(join(koren, "supabase/migrations", f), "utf8"));
  }
  const p = ucitajProizvode(JSON.parse(readFileSync(join(koren, "data", "products.json"), "utf8")));
  await pg.exec(seedSql({ proizvodi: p.proizvodi, datumCenovnika: p.datumCenovnika, pocetak: POCETAK, dana: 8 }));
  db = omotajPglite(pg);
});

describe("niz dana", () => {
  it("gost: tri dana zaredom", async () => {
    const d = uredjaj();
    for (const i of [0, 1, 2]) await igra(dan(i), null, d);
    expect(await nizDana(db, { userId: null, deviceId: d }, dan(2))).toEqual({ dana: 3, vracanje: false });
  });

  it("propušten dan prekida niz, a povratak se prepoznaje", async () => {
    const d = uredjaj();
    for (const i of [0, 1, 3]) await igra(dan(i), null, d);
    expect(await nizDana(db, { userId: null, deviceId: d }, dan(3))).toEqual({ dana: 1, vracanje: true });
  });

  it("nezavršena igra se ne broji", async () => {
    const d = uredjaj();
    await igra(dan(0), null, d);
    await igra(dan(1), null, d, "in_progress");
    expect((await nizDana(db, { userId: null, deviceId: d }, dan(1))).dana).toBe(0);
  });

  it("nalog: broje se igre naloga i gostujuće igre sa istog uređaja pre registracije", async () => {
    const d = uredjaj();
    const id = await nalog();
    await igra(dan(4), null, d);
    await igra(dan(5), id, uredjaj());
    await igra(dan(6), id, d);
    expect(await nizDana(db, { userId: id, deviceId: d }, dan(6))).toEqual({ dana: 3, vracanje: false });
  });

  it("tuđe igre se ne mešaju", async () => {
    const d = uredjaj();
    await igra(dan(7), null, d);
    expect(await nizDana(db, { userId: null, deviceId: uredjaj() }, dan(7))).toEqual({ dana: 0, vracanje: false });
  });
});

describe("poruke za niz", () => {
  it("prva tri dana su tačno kako je traženo", () => {
    expect(porukaZaNiz({ dana: 1, vracanje: false })).toMatch(/^Dobro došao\/la u Čik Pogodi tim/);
    expect(porukaZaNiz({ dana: 2, vracanje: false })).toBe("Dobro došao/la nazad! Novi dan, nove pobede, srećno!");
    expect(porukaZaNiz({ dana: 3, vracanje: false })).toBe("Ne osvaja kviz lep, nego uporan. Samo nastavi!");
  });
  it("svaki dan ima poruku, i posle prvog meseca", () => {
    for (let n = 1; n <= 1200; n++) expect(porukaZaNiz({ dana: n, vracanje: false }).length, String(n)).toBeGreaterThan(10);
    expect(porukaZaNiz({ dana: 31, vracanje: false })).toContain("31");
  });
  it("povratak posle pucanja niza ima svoju poruku", () => {
    expect(porukaZaNiz({ dana: 1, vracanje: true })).toMatch(/pukao/);
  });
  it("dan / dana", () => {
    expect([1, 2, 5, 11, 21, 101, 111].map(danaRec)).toEqual(["dan", "dana", "dana", "dana", "dan", "dan", "dana"]);
  });
});
