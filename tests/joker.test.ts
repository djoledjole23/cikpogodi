/**
 * Segment 5, „Joker pitanje”: jedno pitanje dnevno za bonus (+50), igrač kuca odgovor.
 * Fotografija i broj se vide tek posle odgovora. Dan bez pitanja nema Jokera.
 */
import { existsSync, readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { ucitajFilmove } from "@/lib/content/films";
import { ucitajJokere } from "@/lib/content/joker";
import { ucitajProizvode } from "@/lib/content/products";
import { seedSql } from "@/lib/content/seed";
import { ucitajPesme } from "@/lib/content/songs";
import { postojeceSlikeJokera, postojeciKadrovi } from "@/lib/content/slike";
import { ucitajTrendove } from "@/lib/content/trends";
import { omotajPglite, SUPABASE_ZAMENA } from "@/lib/db/pglite";
import type { Db } from "@/lib/db/types";
import { odgovori, posaljiPitanje, stanjeIgre, zapocniIgru } from "@/lib/game/engine";
import { komentarCena } from "@/lib/game/komentari";
import { joker } from "@/lib/game/segments/joker";
import type { Identitet, Ocena, PrikazCena, PrikazJoker, Stanje } from "@/lib/game/types";

const koren = join(__dirname, "..");
const json = (ime: string) => JSON.parse(readFileSync(join(koren, "data", ime), "utf8"));
const ucitani = ucitajJokere(json("joker.json"), postojeceSlikeJokera(koren));
/** Dan koji ima Jokera i dan posle njega (bez Jokera). */
const SA = "2026-11-14";
const BEZ = "2026-11-15";

let db: Db;
let brojac = 0;
const gost = (): Identitet => ({ userId: null, deviceId: `dddddddd-0000-4000-8000-${String(++brojac).padStart(12, "0")}` });

beforeAll(async () => {
  const pg = new PGlite();
  await pg.exec(SUPABASE_ZAMENA);
  for (const f of readdirSync(join(koren, "supabase/migrations")).sort()) {
    await pg.exec(readFileSync(join(koren, "supabase/migrations", f), "utf8"));
  }
  const proizvodi = ucitajProizvode(json("products.json"));
  const seed = seedSql({
    proizvodi: proizvodi.proizvodi,
    datumCenovnika: proizvodi.datumCenovnika,
    pesme: ucitajPesme(json("songs.json")).pesme,
    filmovi: ucitajFilmove(json("films.json"), postojeciKadrovi(koren)).filmovi,
    jokeri: ucitani.pitanja,
    trendovi: ucitajTrendove(json("trends.json")),
    pocetak: SA,
    dana: 2,
  });
  await pg.exec(seed);
  await pg.exec(seed); // drugi put: bez duplikata i bez greške
  db = omotajPglite(pg);
});

/** Odigra sve do Jokera (ili do kraja, ako ga nema) sa odgovorima koji ne nose poene. */
async function doJokera(ja: Identitet, dan: string): Promise<Stanje> {
  let s = await zapocniIgru(db, ja, dan);
  for (let n = 0; n < 40 && s.status === "u_toku" && s.trenutno!.segment < 5; n++) {
    if (s.trenutno!.faza !== "pitanje") s = await posaljiPitanje(db, ja, dan);
    const seg = s.trenutno!.segment;
    const odgovor = seg === 2 ? { unos: 1 } : seg === 3 ? { izbor: "a" } : { neZnam: true };
    s = (await odgovori(db, ja, dan, { itemId: s.trenutno!.itemId, odgovor })).stanje;
  }
  return s;
}

describe("joker.json", () => {
  it("današnje pitanje: Love Island Adria, odgovor Entoni (i Anthony), fotografija i 92", () => {
    expect(ucitani.izbaceni).toEqual([]);
    const j = ucitani.pitanja.find((x) => x.datum === SA)!;
    expect(j).toMatchObject({
      pitanje: "Ko je od učesnika Love Island Adria imao najveći body count?",
      odgovor: "Entoni",
      alias: ["Anthony"],
      broj: "92",
      natpis: "body count",
    });
    expect(j.slika).toMatch(/^\/joker\/[0-9a-f]{14}\.webp$/);
    expect(existsSync(join(koren, "public", j.slika!))).toBe(true);
  });

  it("odbija dva pitanja za isti dan, loš datum i adresu slike koja odaje odgovor", () => {
    const red = { datum: "2030-01-01", pitanje: "Ko?", odgovor: "Entoni" };
    expect(() => ucitajJokere({})).toThrow();
    expect(() => ucitajJokere({ pitanja: [red, { ...red, pitanje: "A ko?" }] })).toThrow();
    expect(() => ucitajJokere({ pitanja: [{ ...red, datum: "1.1.2030" }] })).toThrow();
    expect(() => ucitajJokere({ pitanja: [{ ...red, odgovor: "" }] })).toThrow();
    expect(() => ucitajJokere({ pitanja: [{ ...red, slika: "/joker/entoni.webp" }] })).toThrow();
    expect(() => ucitajJokere({ pitanja: [{ ...red, alias: ["Anthony"], slika: "/joker/anthony-92.webp" }] })).toThrow();
    // slika koje nema u public/: pitanje ostaje, bez slike; broj može da bude i pravi broj
    const u = ucitajJokere({ pitanja: [{ ...red, slika: "/joker/x1.webp", otkrice: { broj: 92 } }] }, new Set());
    expect(u.pitanja[0]).toMatchObject({ slika: null, broj: "92", natpis: null });
    expect(u.izbaceni).toHaveLength(1);
  });
});

describe("ocena odgovora", () => {
  const snapshot = { pitanje: "Ko?", odgovor: "Entoni", alias: ["Anthony"], slika: "/joker/a.webp", broj: "92", natpis: "body count" };
  const oceni = (odgovor: unknown, istek = false) => joker.oceni(snapshot, odgovor, { protekloMs: 1000, istek }).ocena;

  it("u browser ide samo tekst pitanja", () => {
    expect(joker.javno(snapshot)).toEqual({ vrsta: "joker", pitanje: "Ko?" });
  });

  it("tačno: Entoni i Anthony, bez obzira na slova, pismo i jednu omašku; nosi 50", () => {
    for (const dobro of ["Entoni", "entoni", "ENTONI", " Entoni ", "Ентони", "Anthony", "anthony", "Antony", "Entony", "Antoni", "Entonni"]) {
      expect(oceni({ tekst: dobro }), dobro).toMatchObject({ tacno: true, poeni: 50, maxPoena: 50, istek: false });
    }
  });

  it("netačno: drugi učesnici, dve omaške, prazno, „Ne znam”, istek i gluposti; nosi 0", () => {
    for (const lose of ["Gašper", "Valentin", "Luka", "Toni", "Entoni i Gašper", "Antun", "92", "x".repeat(500)]) {
      expect(oceni({ tekst: lose }), lose).toMatchObject({ tacno: false, poeni: 0 });
    }
    for (const los of [null, {}, { tekst: "" }, { tekst: 7 }, "Entoni", { neZnam: true }, { neZnam: true, tekst: "Entoni" }]) {
      expect(oceni(los)).toMatchObject({ tacno: false, poeni: 0 });
    }
    expect(oceni({ neZnam: true }).prikaz).toMatchObject({ neZnam: true, odgovor: null });
    // isteklo vreme: odgovor koji je stigao uz istek se ne računa
    expect(oceni({ tekst: "Entoni" }, true)).toMatchObject({ tacno: false, poeni: 0, istek: true });
    expect((oceni({ tekst: "x".repeat(500) }).prikaz as PrikazJoker).odgovor!.length).toBe(120);
  });

  it("posle odgovora stižu rešenje, fotografija i broj, i kad je odgovor pogrešan", () => {
    expect(oceni({ tekst: "Gašper" }).prikaz).toEqual({
      vrsta: "joker", pitanje: "Ko?", resenje: "Entoni", slika: "/joker/a.webp", broj: "92", natpis: "body count",
      odgovor: "Gašper", neZnam: false, tacno: false,
    });
  });
});

describe("u igri", () => {
  it("dan sa Jokerom ima pet segmenata; Joker je poslednji, bonus od 50 ide preko svega", async () => {
    const ja = gost();
    let s = await doJokera(ja, SA);
    expect(s.segmenti.map((x) => x.n)).toEqual([1, 2, 3, 4, 5]);
    expect(s.segmenti[4]).toMatchObject({ key: "joker", naziv: "Joker pitanje", pitanja: 1, max: 50, bonus: true });
    expect(s.trenutno!.segment).toBe(5);
    const predJokera = s.score;

    s = await posaljiPitanje(db, ja, SA);
    expect(s.trenutno!.pitanje).toEqual({ vrsta: "joker", pitanje: "Ko je od učesnika Love Island Adria imao najveći body count?" });
    expect(s.trenutno!.limitMs).toBe(30000);
    // ništa o odgovoru ne sme da procuri pre odgovora
    expect(JSON.stringify(s)).not.toMatch(/entoni|anthony|92|\/joker\//i);

    const r = await odgovori(db, ja, SA, { itemId: s.trenutno!.itemId, odgovor: { tekst: "anthony" } });
    expect(r.ocena).toMatchObject({ tacno: true, poeni: 50 });
    expect(r.ocena.prikaz).toMatchObject({ resenje: "Entoni", broj: "92", natpis: "body count", odgovor: "anthony" });
    expect((r.ocena.prikaz as PrikazJoker).slika).toMatch(/^\/joker\//);
    expect(r.stanje.status).toBe("zavrseno");
    expect(r.stanje.score).toBe(predJokera + 50);

    // na ekranu rezultata Joker je i dalje tu
    const kraj = await stanjeIgre(db, ja, SA);
    expect(kraj.segmenti[4]).toMatchObject({ poeni: 50, odgovoreno: 1, tok: [2] });
  });

  it("pogrešan odgovor: 0 poena, igra je gotova", async () => {
    const ja = gost();
    let s = await doJokera(ja, SA);
    const pre = s.score;
    s = await posaljiPitanje(db, ja, SA);
    const r = await odgovori(db, ja, SA, { itemId: s.trenutno!.itemId, odgovor: { tekst: "Gašper" } });
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0 });
    expect(r.stanje).toMatchObject({ status: "zavrseno", score: pre });
  });

  it("dan bez Joker pitanja ima četiri segmenta i završava se posle filmova", async () => {
    const s = await doJokera(gost(), BEZ);
    expect(s.segmenti.map((x) => x.n)).toEqual([1, 2, 3, 4]);
    expect(s.status).toBe("zavrseno");
  });
});

describe("komentar za cenu", () => {
  const ocena = (poeni: number): Ocena => ({ tacno: poeni > 0, poeni, maxPoena: 10, istek: false, prikaz: {} as PrikazCena });
  const p = (unos: number | null, prava = 200): PrikazCena => ({ vrsta: "cena", naziv: "", kolicina: "", unos, prava, procenat: "", min: prava, max: prava, najjeftinije: "" });

  it("veliki promašaj (manje od pola ili više od duplo) uvek dobija Bogoljuba", () => {
    for (const unos of [1, 99, 401, 5000]) {
      for (const seme of [0, 1, 2, 7]) expect(komentarCena(ocena(0), p(unos), seme), String(unos)).toBe("Poznaješ cene isto koliko i Bogoljub.");
    }
  });

  it("običan promašaj, pogodak i istek ga ne dobijaju", () => {
    for (const [unos, poeni] of [[100, 0], [150, 0], [300, 0], [400, 0], [185, 10], [200, 10], [172, 5], [null, 0]] as [number | null, number][]) {
      expect(komentarCena(ocena(poeni), p(unos), 3), String(unos)).not.toContain("Bogoljub");
    }
  });
});
