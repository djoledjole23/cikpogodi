import { existsSync, readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { ucitajFilmove } from "@/lib/content/films";
import { ucitajProizvode } from "@/lib/content/products";
import { planFilmova, seedSql } from "@/lib/content/seed";
import { postojeciKadrovi } from "@/lib/content/slike";
import { omotajPglite, SUPABASE_ZAMENA } from "@/lib/db/pglite";
import type { Db } from "@/lib/db/types";
import { odgovori, posaljiPitanje, stanjeIgre, zapocniIgru } from "@/lib/game/engine";
import type { Identitet, PrikazFilm } from "@/lib/game/types";
import { normalizuj } from "@/lib/match";

const koren = join(__dirname, "..");
const json = (ime: string) => JSON.parse(readFileSync(join(koren, "data", ime), "utf8"));
const ucitani = ucitajFilmove(json("films.json"), postojeciKadrovi(koren));
const POCETAK = "2026-11-01";
/** Dan samo sa filmovima, sa poznatim sadržajem. */
const DAN = "2030-04-04";

let pg: PGlite;
let db: Db;
let brojac = 0;
const gost = (): Identitet => ({ userId: null, deviceId: `cccccccc-0000-4000-8000-${String(++brojac).padStart(12, "0")}` });

beforeAll(async () => {
  pg = new PGlite();
  await pg.exec(SUPABASE_ZAMENA);
  for (const f of readdirSync(join(koren, "supabase/migrations")).sort()) {
    await pg.exec(readFileSync(join(koren, "supabase/migrations", f), "utf8"));
  }
  const proizvodi = ucitajProizvode(json("products.json"));
  const seed = seedSql({ proizvodi: proizvodi.proizvodi, datumCenovnika: proizvodi.datumCenovnika, filmovi: ucitani.filmovi, pocetak: POCETAK, dana: 14 });
  await pg.exec(seed);
  await pg.exec(seed); // drugi put: bez duplikata i bez greške
  const naslovi = ["Maratonci trče počasni krug", "Mrtav 'ladan", "Nož", "Montevideo, Bog te video!", "Balkanski špijun", "Zona Zamfirova", "Toma", "Parada"];
  await pg.exec(`
    insert into public.daily_quiz (quiz_date, status) values ('${DAN}', 'published');
    ${naslovi
      .map(
        (n, i) => `insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
      select '${DAN}', 4, ${i + 1}, s.id, jsonb_build_object('naslov', f.title, 'alias', to_jsonb(f.aliases), 'slika', s.image_url)
      from public.films f join public.film_stills s on s.film_id = f.id where f.title = '${n.replace(/'/g, "''")}';`,
      )
      .join("\n")}
  `);
  db = omotajPglite(pg);
});

describe("films.json i raspored", () => {
  it("28 kadrova: fajl postoji, a adresa ne odaje naslov", () => {
    expect(ucitani.filmovi.length).toBe(28);
    expect(ucitani.izbaceni).toEqual([]);
    expect(new Set(ucitani.filmovi.map((f) => f.slika)).size).toBe(28);
    for (const f of ucitani.filmovi) {
      expect(existsSync(join(koren, "public", f.slika)), f.naslov).toBe(true);
      expect(f.slika).toMatch(/^\/kadrovi\/[0-9a-f]{14}\.webp$/);
    }
    // u folderu nema ničega osim tih 28 slika (da ne ostane fajl sa naslovom u imenu)
    expect(readdirSync(join(koren, "public/kadrovi")).sort()).toEqual(ucitani.filmovi.map((f) => f.slika.replace("/kadrovi/", "")).sort());
  });

  it("odbija adresu koja odaje naslov, izbacuje film bez fotografije", () => {
    expect(() => ucitajFilmove({ filmovi: [{ naslov: "Ko to tamo peva", slika: "/kadrovi/ko-to-tamo-peva.jpg" }] })).toThrow();
    expect(() => ucitajFilmove({ filmovi: [{ naslov: "Nož", slika: "/kadrovi/a.webp" }, { naslov: "NOZ", slika: "/kadrovi/b.webp" }] })).toThrow();
    expect(() => ucitajFilmove({})).toThrow();
    const u = ucitajFilmove({ filmovi: [{ naslov: "A film", slika: "/kadrovi/1.webp" }, { naslov: "B film" }, { naslov: "C film", slika: "/kadrovi/3.webp" }] }, new Set(["/kadrovi/1.webp"]));
    expect(u.filmovi.map((f) => f.naslov)).toEqual(["A film"]);
    expect(u.izbaceni.map((x) => x.razlog)).toEqual(["nema fotografiju", "fotografije nema u public/"]);
  });

  it("14 dana po 3 kadra: bez ponavljanja dok ih ima, i nikad isti film dva dana zaredom", () => {
    const plan = planFilmova(ucitani.filmovi, POCETAK, 14);
    const prvih9 = plan.slice(0, 9).flatMap((d) => d.filmovi.map((f) => f.slika));
    expect(new Set(prvih9).size).toBe(27);
    plan.forEach((dan, i) => {
      expect(dan.filmovi.length).toBe(3);
      expect(new Set(dan.filmovi.map((f) => f.slika)).size).toBe(3);
      if (i > 0) for (const f of dan.filmovi) expect(plan[i - 1].filmovi.includes(f), `${dan.datum} ${f.naslov}`).toBe(false);
    });
    const broj = new Map<string, number>();
    for (const f of plan.flatMap((d) => d.filmovi)) broj.set(f.slika, (broj.get(f.slika) ?? 0) + 1);
    expect(broj.size).toBe(28);
    expect(Math.max(...broj.values())).toBe(2);
    expect(planFilmova(ucitani.filmovi, POCETAK, 14)).toEqual(plan);
    expect(() => planFilmova(ucitani.filmovi.slice(0, 2), POCETAK, 1)).toThrow();
  });

  it("seed: filmovi, kadrovi i stavke su u bazi; spisak filmova više nije javan", async () => {
    const [n] = await db.query<{ filmova: number; kadrova: number; stavki: number }>(
      `select (select count(*) from public.films)::int as filmova, (select count(*) from public.film_stills)::int as kadrova,
              (select count(*) from public.daily_quiz_items where segment = 4 and quiz_date < '2030-01-01')::int as stavki`,
    );
    expect(n).toEqual({ filmova: 28, kadrova: 28, stavki: 42 });
    const polise = await db.query<{ policyname: string }>(`select policyname from pg_policies where tablename in ('films', 'film_stills')`);
    expect(polise).toEqual([]);
  });
});

describe("segment 4: pogodi domaći film/seriju", () => {
  it("u browser ide samo slika, i ona ne odaje naslov", async () => {
    const ja = gost();
    const uvod = await zapocniIgru(db, ja, DAN);
    expect(uvod.trenutno).toMatchObject({ segment: 4, pozicija: 1, ukupno: 8, faza: "uvod" });
    expect(uvod.segmenti[0]).toMatchObject({ n: 4, naziv: "Pogodi domaći film/seriju", max: 160 });
    const s = await posaljiPitanje(db, ja, DAN);
    const pitanje = s.trenutno!.pitanje as { vrsta: string; slika: string };
    expect(Object.keys(pitanje).sort()).toEqual(["slika", "vrsta"]);
    expect(pitanje.slika).toMatch(/^\/kadrovi\/[0-9a-f]{14}\.webp$/);
    expect(normalizuj(JSON.stringify(s))).not.toMatch(/maratonci|pocasni|krug/);
    expect(s.trenutno).toMatchObject({ limitMs: 30000 });
  });

  it("naslov se kuca: prolaze kvačice, ćirilica, omaška i kraći oblik; pogrešan film i „Ne znam” ne", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, DAN);
    const odgovor = async (o: unknown, istek = false) => {
      const s = await posaljiPitanje(db, ja, DAN);
      return odgovori(db, ja, DAN, { itemId: s.trenutno!.itemId, odgovor: o, istek });
    };
    // 1 Maratonci: bez kvačica i sa omaškom
    let r = await odgovor({ tekst: "maratonci trce pocasni krg" });
    expect(r.ocena).toMatchObject({ tacno: true, poeni: 20, maxPoena: 20 });
    expect(r.ocena.prikaz).toMatchObject({ vrsta: "film", naslov: "Maratonci trče počasni krug", odgovor: "maratonci trce pocasni krg", tacno: true });
    // 2 Mrtav 'ladan: bez apostrofa, pa „hladan”
    r = await odgovor({ tekst: "Mrtav ladan" });
    expect(r.ocena.tacno).toBe(true);
    // 3 Nož: ćirilicom; kratak naslov ne trpi omašku
    r = await odgovor({ tekst: "НОЖ" });
    expect(r.ocena.tacno).toBe(true);
    // 4 Montevideo: kraći oblik
    r = await odgovor({ tekst: "montevideo" });
    expect(r.ocena.tacno).toBe(true);
    // 5 Balkanski špijun: pogrešan film
    r = await odgovor({ tekst: "Ko to tamo peva" });
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0, istek: false });
    expect((r.ocena.prikaz as PrikazFilm).naslov).toBe("Balkanski špijun");
    // 6 Zona Zamfirova: Ne znam
    r = await odgovor({ neZnam: true });
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0 });
    expect(r.ocena.prikaz).toMatchObject({ neZnam: true, odgovor: null });
    // 7 Toma: „Tom” nije dovoljno (kratak naslov mora tačno), gluposti nisu greška
    r = await odgovor({ tekst: "Tom" });
    expect(r.ocena.tacno).toBe(false);
    // 8 Parada: browser javi istek
    r = await odgovor({ tekst: "Parada" }, true);
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0, istek: true });
    expect(r.krajSegmenta).toMatchObject({ n: 4, poeni: 80, tok: [2, 2, 2, 2, 0, 0, 0, 0] });
    expect(r.stanje.status).toBe("zavrseno");
    expect(r.stanje.rezultat!.map((x) => x.poeni)).toEqual([20, 20, 20, 20, 0, 0, 0, 0]);
  });

  it("posle 30 sekundi (plus tolerancija) pitanje je propalo", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, DAN);
    const s = await posaljiPitanje(db, ja, DAN);
    await pg.exec(`update public.play_answers set served_at = now() - interval '32 seconds' where item_id = ${s.trenutno!.itemId} and answered_at is null`);
    const posle = await stanjeIgre(db, ja, DAN);
    expect(posle.trenutno).toMatchObject({ pozicija: 2, faza: "sledece" });
    expect(posle.score).toBe(0);
  });
});
