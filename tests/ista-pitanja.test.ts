/**
 * „Svi igrači tog dana dobijaju ISTA pitanja”:
 *  - pitanja za dan su redovi u bazi (daily_quiz_items), isti za svakog igrača i u istom redosledu;
 *  - pravljenje pitanja je ponovljivo (isti ulaz → isti SQL), bez slučajnosti i bez zavisnosti od sata;
 *  - dan koji je već u bazi se ne menja, ni kad se seed pusti ponovo sa drugačijim podacima;
 *  - fajl u supabase/seed/ je baš ono što se dobija iz data/ (pa lokalna proba = prava baza).
 */
import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { ucitajFilmove } from "@/lib/content/films";
import { ucitajJokere } from "@/lib/content/joker";
import { ucitajProizvode } from "@/lib/content/products";
import { seedSql } from "@/lib/content/seed";
import { ucitajPesme } from "@/lib/content/songs";
import { postojeceSlikeJokera, postojeciKadrovi, sopstveneSlike } from "@/lib/content/slike";
import { ucitajTrendove } from "@/lib/content/trends";
import { omotajPglite, SUPABASE_ZAMENA } from "@/lib/db/pglite";
import type { Db } from "@/lib/db/types";
import { odgovori, posaljiPitanje, zapocniIgru } from "@/lib/game/engine";
import type { Identitet } from "@/lib/game/types";

const koren = join(__dirname, "..");
const json = (ime: string) => JSON.parse(readFileSync(join(koren, "data", ime), "utf8"));
const POCETAK = "2026-11-14";
const DANA = 14;

function ulaz() {
  const proizvodi = ucitajProizvode(json("products.json"), sopstveneSlike(koren));
  return {
    proizvodi: proizvodi.proizvodi,
    datumCenovnika: proizvodi.datumCenovnika,
    pesme: ucitajPesme(json("songs.json")).pesme,
    filmovi: ucitajFilmove(json("films.json"), postojeciKadrovi(koren)).filmovi,
    jokeri: ucitajJokere(json("joker.json"), postojeceSlikeJokera(koren)).pitanja,
    trendovi: ucitajTrendove(json("trends.json")),
    pocetak: POCETAK,
    dana: DANA,
  };
}

let pg: PGlite;
let db: Db;
let brojac = 0;
const gost = (): Identitet => ({ userId: null, deviceId: `eeeeeeee-0000-4000-8000-${String(++brojac).padStart(12, "0")}` });

beforeAll(async () => {
  pg = new PGlite();
  await pg.exec(SUPABASE_ZAMENA);
  for (const f of readdirSync(join(koren, "supabase/migrations")).sort()) {
    await pg.exec(readFileSync(join(koren, "supabase/migrations", f), "utf8"));
  }
  await pg.exec(seedSql(ulaz()));
  db = omotajPglite(pg);
});

/** Odigra ceo dan i vrati sve što je igrač video, redom: segment, broj pitanja i samo pitanje. */
async function odigraj(ja: Identitet, dan: string, odgovor: (segment: number, n: number) => unknown): Promise<string[]> {
  const vidjeno: string[] = [];
  let s = await zapocniIgru(db, ja, dan);
  for (let n = 0; n < 60 && s.status === "u_toku"; n++) {
    if (s.trenutno!.faza !== "pitanje") s = await posaljiPitanje(db, ja, dan);
    const t = s.trenutno!;
    vidjeno.push(`${t.segment}/${t.itemId}/${JSON.stringify(t.pitanje)}`);
    s = (await odgovori(db, ja, dan, { itemId: t.itemId, odgovor: odgovor(t.segment, n) })).stanje;
  }
  expect(s.status).toBe("zavrseno");
  return vidjeno;
}

describe("isti dan, ista pitanja", () => {
  it("tri igrača koja odgovaraju potpuno različito vide ista pitanja istim redom (svih pet segmenata)", async () => {
    const neZna = await odigraj(gost(), POCETAK, (seg) => (seg === 2 ? { unos: 1 } : seg === 3 ? { izbor: "a" } : { neZnam: true }));
    const drugi = await odigraj(gost(), POCETAK, (seg) => (seg === 2 ? { unos: 250 } : seg === 3 ? { izbor: "b" } : { tekst: "nešto" }));
    const treci = await odigraj(gost(), POCETAK, (seg, n) => (seg === 2 ? { unos: 99 + n } : seg === 3 ? { izbor: n % 2 ? "a" : "b" } : { tekst: "Entoni" }));
    expect(neZna).toHaveLength(5 + 10 + 8 + 3 + 1);
    expect(drugi).toEqual(neZna);
    expect(treci).toEqual(neZna);
    expect(neZna.map((x) => x.split("/")[0]).join("")).toBe("1".repeat(5) + "2".repeat(10) + "3".repeat(8) + "4".repeat(3) + "5");
  });

  it("i sutradan je isto za sve, a pitanja su drugačija nego danas", async () => {
    const sutra = "2026-11-15";
    const a = await odigraj(gost(), sutra, (seg) => (seg === 2 ? { unos: 1 } : seg === 3 ? { izbor: "a" } : { neZnam: true }));
    const b = await odigraj(gost(), sutra, (seg) => (seg === 2 ? { unos: 500 } : seg === 3 ? { izbor: "b" } : { tekst: "x" }));
    expect(b).toEqual(a);
    const danas = await odigraj(gost(), POCETAK, () => ({ neZnam: true }));
    expect(a.some((x) => danas.includes(x))).toBe(false);
  });
});

describe("pravljenje pitanja", () => {
  it("ponovljivo je: isti podaci daju isti SQL, slovo u slovo", () => {
    expect(seedSql(ulaz())).toBe(seedSql(ulaz()));
  });

  it("dan koji je već u bazi se ne menja kad se seed pusti ponovo, ni sa drugačijim podacima", async () => {
    const stavke = () =>
      pg.query<{ segment: number; position: number; snapshot: unknown }>(
        `select segment::int as segment, position::int as position, snapshot from public.daily_quiz_items where quiz_date = $1::date order by segment, position`,
        [POCETAK],
      );
    const pre = (await stavke()).rows;
    const drugacije = ulaz();
    drugacije.proizvodi = [...drugacije.proizvodi].reverse().map((p) => ({ ...p, cena: p.cena + 100 }));
    drugacije.pesme = [...drugacije.pesme].reverse();
    drugacije.filmovi = [...drugacije.filmovi].reverse();
    await pg.exec(seedSql(drugacije));
    await pg.exec(seedSql({ ...ulaz(), pocetak: "2026-11-10", dana: 10 })); // drugi početak, preklapa se sa današnjim danom
    expect((await stavke()).rows).toEqual(pre);
  });

  it("fajl u supabase/seed/ je baš ono što se dobija iz data/ (lokalna proba i prava baza imaju ista pitanja)", () => {
    const fajl = readFileSync(join(koren, "supabase", "seed", `seed-${POCETAK}-${DANA}d.sql`), "utf8");
    const telo = fajl.split("\n").slice(3).join("\n"); // prva tri reda su zaglavlje
    expect(telo).toBe(seedSql(ulaz()));
  });
});
