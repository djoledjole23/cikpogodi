import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { ucitajProizvode } from "@/lib/content/products";
import { planPesama, seedSql } from "@/lib/content/seed";
import { ucitajPesme } from "@/lib/content/songs";
import { ucitajTrendove } from "@/lib/content/trends";
import { omotajPglite, SUPABASE_ZAMENA } from "@/lib/db/pglite";
import type { Db } from "@/lib/db/types";
import { audioZaPitanje, odgovori, posaljiPitanje, slusanje, stanjeIgre, zapocniIgru } from "@/lib/game/engine";
import type { Identitet, PrikazPesma } from "@/lib/game/types";
import { normalizuj, pretraziKatalog, razdaljina, slicno, tacniObliciPesme } from "@/lib/match";

const koren = join(__dirname, "..");
const json = (ime: string) => JSON.parse(readFileSync(join(koren, "data", ime), "utf8"));
const katalog = ucitajPesme(json("songs.json"));
const POCETAK = "2026-11-14";
/** Dan samo sa pesmama, sa poznatim sadržajem. */
const DAN = "2030-03-03";

let pg: PGlite;
let db: Db;
let brojac = 0;
const gost = (): Identitet => ({ userId: null, deviceId: `bbbbbbbb-0000-4000-8000-${String(++brojac).padStart(12, "0")}` });

beforeAll(async () => {
  pg = new PGlite();
  await pg.exec(SUPABASE_ZAMENA);
  for (const f of readdirSync(join(koren, "supabase/migrations")).sort()) {
    await pg.exec(readFileSync(join(koren, "supabase/migrations", f), "utf8"));
  }
  const proizvodi = ucitajProizvode(json("products.json"));
  await pg.exec(
    seedSql({
      proizvodi: proizvodi.proizvodi,
      datumCenovnika: proizvodi.datumCenovnika,
      pesme: katalog.pesme,
      trendovi: ucitajTrendove(json("trends.json")),
      pocetak: POCETAK,
      dana: 14,
    }),
  );
  await pg.exec(`
    insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
      select 'Probni Bend ' || n, case when n = 1 then 'Ne može nam niko ništa' when n = 2 then 'Zmaj' else 'Probna pesma broj ' || n end,
             case when n = 1 then array['Nemoze nam niko nista']::text[] else '{}'::text[] end,
             900000 + n, case when n = 1 then 77 else null end, 'https://example.com/' || n || '.jpg', 'rok'
      from generate_series(1, 14) n;
    insert into public.daily_quiz (quiz_date, status) values ('${DAN}', 'published');
    insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
      select '${DAN}', 1, deezer_id - 900000, id,
             jsonb_build_object('songId', id, 'izvodjac', artist, 'naslov', title, 'alias', to_jsonb(aliases),
                                'deezerId', deezer_id, 'itunesId', itunes_id, 'omot', cover_url)
      from public.songs where deezer_id between 900001 and 900014;
  `);
  db = omotajPglite(pg);
});

/** Kao da je pesma svirala `ms` milisekundi: pusti, pomeri početak unazad, pauziraj. */
async function slusaj(ja: Identitet, itemId: number, ms: number) {
  await slusanje(db, ja, DAN, { itemId, pusteno: true });
  await pg.exec(`update public.play_answers set playing_since = now() - interval '${ms} milliseconds' where item_id = ${itemId} and playing_since is not null`);
  return slusanje(db, ja, DAN, { itemId, pusteno: false });
}

/** Probna pesma broj `redni`, onako kako bi je igrač izabrao sa spiska. */
const izborPesme = (redni: number) => ({
  izvodjac: `Probni Bend ${redni}`,
  naslov: redni === 1 ? "Ne može nam niko ništa" : redni === 2 ? "Zmaj" : `Probna pesma broj ${redni}`,
});

describe("tolerantno poređenje", () => {
  it("ne gleda velika slova, kvačice ni pismo", () => {
    expect(normalizuj("Đorđe Balašević – Ringišpil")).toBe("djordje balasevic ringispil");
    expect(normalizuj("ЂОРЂЕ БАЛАШЕВИЋ – Рингишпил")).toBe("djordje balasevic ringispil");
    expect(normalizuj("Djordje Balasevic - ringispil")).toBe("djordje balasevic ringispil");
    expect(normalizuj("Љубав, њива и џак")).toBe("ljubav njiva i dzak");
    expect(normalizuj("Dotak'o sam dno života")).toBe("dotako sam dno zivota");
    expect(normalizuj("  Gas,   gas!  ")).toBe("gas gas");
  });

  it("broji greške u kucanju (zamena dva susedna slova je jedna)", () => {
    expect(razdaljina("kukavica", "kukavica")).toBe(0);
    expect(razdaljina("kukavica", "kukvica")).toBe(1);
    expect(razdaljina("kukavica", "kukaivca")).toBe(1);
    expect(razdaljina("kukavica", "kokavice")).toBe(2);
  });

  it("mala greška prolazi, velika ne; kratki naslovi moraju tačno", () => {
    const pesma = { izvodjac: "Ceca", naslov: "Kukavica" };
    const oblici = tacniObliciPesme(pesma);
    for (const dobro of ["kukavica", "KUKAVICA", "Кукавица", "kukvica", "ceca kukavica", "Ceca – Kukavica", "kukavica ceca", "kuka vica"]) {
      expect(slicno(dobro, oblici), dobro).toBe(true);
    }
    for (const lose of ["", "   ", "ceca", "kuka", "kukavicaaaa", "beograd", "ceca beograd"]) {
      expect(slicno(lose, oblici), lose).toBe(false);
    }
    // naslov od 4 slova: nijedna greška; od 5 do 9: jedna; duži: dve
    expect(slicno("zmaj", ["Zmaj"])).toBe(true);
    expect(slicno("zmej", ["Zmaj"])).toBe(false);
    expect(slicno("tangi", ["Tango"])).toBe(true);
    expect(slicno("molitvu", ["Molitva"])).toBe(true);
    expect(slicno("ostani djubre do kreja", ["Ostani đubre do kraja"])).toBe(true);
    expect(slicno("ostani dubre do kreje", ["Ostani đubre do kraja"])).toBe(false);
    // dodatni oblici naslova
    expect(slicno("da li si ikada mene voljela", tacniObliciPesme({ izvodjac: "Knez", naslov: "Dal' si ikada mene voljela", alias: ["Da li si ikada mene voljela"] }))).toBe(true);
  });

  it("pretraga kataloga: početak reči, bilo kojim redom, i uz omašku", () => {
    const k = katalog.pesme.map((p) => ({ izvodjac: p.izvodjac, naslov: p.naslov }));
    const nadji = (u: string) => pretraziKatalog(k, u, 5).map((x) => `${x.izvodjac} – ${x.naslov}`);
    expect(nadji("kuk")).toEqual(["Ceca – Kukavica"]);
    expect(nadji("cec kuk")).toEqual(["Ceca – Kukavica"]);
    expect(nadji("кукавица")).toEqual(["Ceca – Kukavica"]);
    expect(nadji("ringispil")).toEqual(["Đorđe Balašević – Ringišpil"]);
    expect(nadji("dubre")).toEqual([]); // „đ” se kuca kao „dj”
    expect(nadji("djubre")).toEqual(["Riblja Čorba – Ostani đubre do kraja"]);
    expect(nadji("kukvaica")).toEqual(["Ceca – Kukavica"]); // omaška
    expect(nadji("")).toEqual([]);
    // naslov koji počinje ukucanim ide pre izvođača koji tako počinje
    expect(nadji("beograd")[0]).toBe("Ceca – Beograd");
    expect(nadji("ceca").length).toBe(3);
    expect(nadji("jala").length).toBe(5);
  });
});

describe("songs.json i raspored", () => {
  it("katalog: mnogo više od 50 pesama, svaka sa potvrđenim klipom, bez duplikata", () => {
    expect(katalog.pesme.length).toBe(165);
    expect(katalog.izbaceni).toEqual([]);
    expect(new Set(katalog.pesme.map((p) => p.deezerId)).size).toBe(165);
    expect(new Set(katalog.pesme.map((p) => normalizuj(`${p.izvodjac} ${p.naslov}`))).size).toBe(165);
    for (const p of katalog.pesme) {
      expect(p.omot.startsWith("https://cdn-images.dzcdn.net/images/cover/")).toBe(true);
      expect(Number.isInteger(p.deezerId) && p.deezerId > 0).toBe(true);
    }
    const broj = (z: string) => katalog.pesme.filter((p) => p.zanr === z).length;
    expect([broj("folk"), broj("rok"), broj("pop"), broj("trep")]).toEqual([50, 46, 37, 32]);
    // 34 pesme sa spiska + 10 dodatih rok pesama
    expect(katalog.pesme.filter((p) => p.prioritet).length).toBe(44);
    for (const naziv of ["Ceca – Kukavica", "Jala Brat, Buba Corelli & Rasta – Benga po snijegu", "Voyage – Euforija", "Jala Brat – Mlada i luda"]) {
      expect(katalog.pesme.find((p) => `${p.izvodjac} – ${p.naslov}` === naziv)?.prioritet, naziv).toBe(true);
    }
  });

  it("pesma bez Deezer ID-a se izbacuje (ID se ne izmišlja), loš fajl se odbija", () => {
    const u = ucitajPesme({
      datum_provere: "2026-11-14",
      pesme: [
        { izvodjac: "A", naslov: "Ima", zanr: "rok", deezer_id: 5, omot: "https://x/y.jpg" },
        { izvodjac: "B", naslov: "Nema", zanr: "rok", omot: "https://x/y.jpg" },
      ],
    });
    expect(u.pesme.map((p) => p.naslov)).toEqual(["Ima"]);
    expect(u.izbaceni).toEqual([{ naziv: "B – Nema", razlog: "nema potvrđen klip na Deezeru" }]);
    expect(() => ucitajPesme({})).toThrow();
    expect(() => ucitajPesme({ datum_provere: "2026-11-14", pesme: [{ izvodjac: "A", naslov: "X", zanr: "dzez", deezer_id: 1, omot: "https://x" }] })).toThrow();
    const dupla = { izvodjac: "A", naslov: "X", zanr: "rok", deezer_id: 1, omot: "https://x/y.jpg" };
    expect(() => ucitajPesme({ datum_provere: "2026-11-14", pesme: [dupla, dupla] })).toThrow();
  });

  it("14 dana po 5 pesama: od svakog žanra bar jedna, izvođač se ne ponavlja u danu, pesma ni u celom periodu", () => {
    const plan = planPesama(katalog.pesme, POCETAK, 14);
    const sve = new Set<number>();
    for (const dan of plan) {
      expect(dan.pesme.length).toBe(5);
      expect(new Set(dan.pesme.map((p) => p.zanr)).size).toBe(4);
      const izvodjaci = dan.pesme.flatMap((p) => p.izvodjaci.map(normalizuj));
      expect(new Set(izvodjaci).size, dan.datum).toBe(izvodjaci.length);
      for (const p of dan.pesme) {
        expect(sve.has(p.deezerId)).toBe(false);
        sve.add(p.deezerId);
      }
    }
    expect(sve.size).toBe(70);
    // sve pesme sa spiska dođu na red u prvih 14 dana
    expect(plan.flatMap((d) => d.pesme).filter((p) => p.prioritet).length).toBe(44);
    // peta pesma je svaki dan iz drugog žanra, pa nijedan žanr ne preteže
    const poZanru = (z: string) => plan.flatMap((d) => d.pesme).filter((p) => p.zanr === z).length;
    expect([poZanru("folk"), poZanru("rok"), poZanru("pop"), poZanru("trep")]).toEqual([19, 19, 18, 14]);
    expect(planPesama(katalog.pesme, POCETAK, 14)).toEqual(plan);
  });

  it("kad pesme ponestanu, ponavljaju se najređe korišćene; premalo izvođača je greška", () => {
    const malo = katalog.pesme.filter((p) => p.prioritet);
    const plan = planPesama(malo, POCETAK, 14); // 44 pesme za 70 mesta
    const broj = new Map<number, number>();
    for (const p of plan.flatMap((d) => d.pesme)) broj.set(p.deezerId, (broj.get(p.deezerId) ?? 0) + 1);
    expect(broj.size).toBe(44);
    expect(Math.max(...broj.values())).toBeLessThanOrEqual(3); // trep ih ima samo 8 za 14 dana
    expect(() => planPesama(malo.filter((p) => p.izvodjaci.includes("Jala Brat")), POCETAK, 1)).toThrow();
  });

  it("seed upisuje katalog i dnevne pesme, i može da se pusti ponovo", async () => {
    const [pre] = await db.query<{ n: number }>(`select count(*)::int as n from public.songs where deezer_id < 900000 or deezer_id > 900100`);
    expect(pre.n).toBe(165);
    const stavke = await db.query<{ n: number; dana: number }>(
      `select count(*)::int as n, count(distinct quiz_date)::int as dana from public.daily_quiz_items where segment = 1 and quiz_date < '2030-01-01'`,
    );
    expect(stavke[0]).toEqual({ n: 70, dana: 14 });
    const [s] = await db.query<{ snapshot: { songId: number; deezerId: number; naslov: string }; song_id: number; deezer_id: number }>(
      `select i.snapshot, i.song_id::int as song_id, s.deezer_id::float8 as deezer_id from public.daily_quiz_items i join public.songs s on s.id = i.song_id
       where i.segment = 1 and i.quiz_date = $1::date and i.position = 1`,
      [POCETAK],
    );
    expect(s.snapshot.songId).toBe(s.song_id);
    expect(s.snapshot.deezerId).toBe(s.deezer_id);
  });
});

describe("segment 1: pogodi pesmu", () => {
  it("u browser ne ide ništa o pesmi", async () => {
    const ja = gost();
    const uvod = await zapocniIgru(db, ja, DAN);
    expect(uvod.trenutno).toMatchObject({ segment: 1, pozicija: 1, ukupno: 14, faza: "uvod" });
    const s = await posaljiPitanje(db, ja, DAN);
    expect(s.trenutno!.pitanje).toEqual({ vrsta: "pesma" });
    expect(Object.keys(s.trenutno!).sort()).toEqual(["faza", "itemId", "limitMs", "pitanje", "pozicija", "preostaloMs", "segment", "svira", "ukupno"]);
    expect(s.trenutno).toMatchObject({ limitMs: 30000, preostaloMs: 30000, svira: false });
    expect(JSON.stringify(s)).not.toMatch(/Probn|900001|example\.com/);
  });

  it("zvuk se daje samo za pitanje koje je igraču već poslato", async () => {
    const ja = gost();
    const uvod = await zapocniIgru(db, ja, DAN);
    const prvo = uvod.trenutno!.itemId;
    expect(await audioZaPitanje(db, ja, DAN, prvo)).toBeNull(); // još nije kliknuo „Kreni”
    await posaljiPitanje(db, ja, DAN);
    expect(await audioZaPitanje(db, ja, DAN, prvo)).toEqual({ deezerId: 900001, itunesId: 77 });
    expect(await audioZaPitanje(db, ja, DAN, prvo + 1)).toBeNull(); // sledeće pitanje: ne može unapred
    expect(await audioZaPitanje(db, gost(), DAN, prvo)).toBeNull(); // tuđa igra
    expect(await audioZaPitanje(db, ja, "2030-03-04", prvo)).toBeNull();
  });

  it("meri se preslušano vreme: pauza ne teče, osvežavanje ga ne vraća na nulu", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, DAN);
    const s = await posaljiPitanje(db, ja, DAN);
    const id = s.trenutno!.itemId;
    // čeka bez slušanja: sat stoji
    await pg.exec(`update public.play_answers set served_at = now() - interval '5 minutes' where item_id = ${id}`);
    expect((await stanjeIgre(db, ja, DAN)).trenutno!.preostaloMs).toBe(30000);

    const posle = await slusaj(ja, id, 3000);
    expect(posle.trenutno!.svira).toBe(false);
    expect(30000 - posle.trenutno!.preostaloMs!).toBeGreaterThanOrEqual(3000);
    expect(30000 - posle.trenutno!.preostaloMs!).toBeLessThan(3200);

    // drugo slušanje se sabira; „pusti” dvaput zaredom ne broji duplo, „pauza” bez puštanja ne radi ništa
    await slusanje(db, ja, DAN, { itemId: id, pusteno: false });
    const jos = await slusaj(ja, id, 2000);
    const ukupno = 30000 - jos.trenutno!.preostaloMs!;
    expect(ukupno).toBeGreaterThanOrEqual(5000);
    expect(ukupno).toBeLessThan(5400);

    // dok svira, stanje to kaže i vreme teče
    await slusanje(db, ja, DAN, { itemId: id, pusteno: true });
    await pg.exec(`update public.play_answers set playing_since = now() - interval '1000 milliseconds' where item_id = ${id}`);
    const svira = await stanjeIgre(db, ja, DAN);
    expect(svira.trenutno!.svira).toBe(true);
    expect(30000 - svira.trenutno!.preostaloMs!).toBeGreaterThanOrEqual(6000);

    // poruka za tuđe ili pogrešno pitanje ne menja ništa
    await slusanje(db, ja, DAN, { itemId: id + 1, pusteno: false });
    expect((await stanjeIgre(db, ja, DAN)).trenutno!.svira).toBe(true);
  });

  it("bodovanje na granicama: 2,0 s, 4,0 s, 6,0 s i kraj klipa", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, DAN);
    const ocekivano: [number, number][] = [
      [0, 20], [2000, 20], [2001, 15], [4000, 15], [4001, 10], [6000, 10], [6001, 5], [30000, 5],
    ];
    let zbir = 0;
    for (const [i, [ms, poeni]] of ocekivano.entries()) {
      const s = await posaljiPitanje(db, ja, DAN);
      const id = s.trenutno!.itemId;
      if (ms > 0) await slusaj(ja, id, ms);
      const r = await odgovori(db, ja, DAN, { itemId: id, odgovor: { izbor: izborPesme(i + 1) }, slusanoMs: ms });
      expect(r.ocena, `${ms} ms`).toMatchObject({ tacno: true, poeni, maxPoena: 20, istek: false });
      expect((r.ocena.prikaz as PrikazPesma).slusanoMs).toBe(ms);
      zbir += poeni;
      expect(r.stanje.score).toBe(zbir);
    }
    expect(zbir).toBe(100);
    const [igra] = await db.query<{ total: number }>(
      `select total_answer_ms::int as total from public.plays where device_id = $1::uuid and quiz_date = $2::date`,
      [ja.deviceId, DAN],
    );
    expect(igra.total).toBe(ocekivano.reduce((z, [ms]) => z + ms, 0)); // za izjednačenje se gleda preslušano vreme
  });

  it("odgovor: izabrana pesma, ukucan tekst (tolerantno), pogrešna pesma, „Ne znam”, gluposti", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, DAN);
    const pitanje = async () => (await posaljiPitanje(db, ja, DAN)).trenutno!.itemId;

    // 1: „Ne može nam niko ništa” ukucano spojeno i bez kvačica (dodatni oblik naslova)
    let r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { tekst: "nemoze nam niko nista" }, slusanoMs: 1500 });
    expect(r.ocena).toMatchObject({ tacno: true, poeni: 20 });
    expect(r.ocena.prikaz).toEqual({
      vrsta: "pesma", izvodjac: "Probni Bend 1", naslov: "Ne može nam niko ništa", omot: "https://example.com/1.jpg",
      odgovor: "nemoze nam niko nista", neZnam: false, tacno: true, slusanoMs: 1500,
    });
    // 2: „Zmaj” ćirilicom
    r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { tekst: "ЗМАЈ" }, slusanoMs: 3000 });
    expect(r.ocena).toMatchObject({ tacno: true, poeni: 15 });
    // 3: izabrana pogrešna pesma iz kataloga (iako tekst liči na tačan naslov, važi izbor)
    r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { izbor: izborPesme(9), tekst: "Probna pesma broj 3" }, slusanoMs: 1000 });
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0, istek: false });
    expect((r.ocena.prikaz as PrikazPesma).odgovor).toBe("Probna pesma broj 3");
    // 4: samo izvođač nije dovoljno
    r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { tekst: "Probni Bend 4" }, slusanoMs: 1000 });
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0 });
    // 5: izvođač + naslov sa omaškom
    r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { tekst: "probni bend 5 probna pesma borj 5" }, slusanoMs: 5000 });
    expect(r.ocena).toMatchObject({ tacno: true, poeni: 10 });
    // 6: Ne znam
    r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { neZnam: true }, slusanoMs: 800 });
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0, istek: false });
    expect(r.ocena.prikaz).toMatchObject({ neZnam: true, odgovor: null });
    // 7–9: gluposti su netačan odgovor, ne greška
    for (const los of [null, {}, { izbor: "7", tekst: 5 }]) {
      r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: los, slusanoMs: 100 });
      expect(r.ocena).toMatchObject({ tacno: false, poeni: 0 });
    }
    // 10: predugačak tekst se skraćuje
    r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { tekst: "x".repeat(500) }, slusanoMs: 100 });
    expect((r.ocena.prikaz as PrikazPesma).odgovor!.length).toBe(120);
    expect(r.stanje.segmenti[0].tok).toEqual([2, 1, 0, 0, 1, 0, 0, 0, 0, 0]);
  });

  it("izbor sa spiska: tačna je samo baš ta pesma (isti izvođač i naslov), bez praštanja omaški", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, DAN);
    const pitanje = async () => (await posaljiPitanje(db, ja, DAN)).trenutno!.itemId;

    // 1: priznati oblik naslova, bez kvačica i velikim slovima
    let r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { izbor: { izvodjac: "probni bend 1", naslov: "NEMOZE NAM NIKO NISTA" } }, slusanoMs: 1000 });
    expect(r.ocena).toMatchObject({ tacno: true, poeni: 20 });
    expect((r.ocena.prikaz as PrikazPesma).odgovor).toBe("probni bend 1 – NEMOZE NAM NIKO NISTA");
    // 2: isti naslov, drugi izvođač (druga pesma koja se isto zove)
    r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { izbor: { izvodjac: "Indira Radić", naslov: "Zmaj" } }, slusanoMs: 1000 });
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0 });
    // 3: pravi izvođač, njegova druga pesma
    r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { izbor: { izvodjac: "Probni Bend 3", naslov: "Probna pesma broj 4" } }, slusanoMs: 1000 });
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0 });
    // 4: izbor je stavka sa spiska, pa se omaška u naslovu ne prašta (to važi samo za kucanje)
    r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { izbor: { izvodjac: "Probni Bend 4", naslov: "Probna pesma borj 4" } }, slusanoMs: 1000 });
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0 });
    // 5: nepotpun izbor se ne računa kao izbor, pa važi ukucan tekst
    r = await odgovori(db, ja, DAN, { itemId: await pitanje(), odgovor: { izbor: { izvodjac: 5 }, tekst: "probna pesma broj 5" }, slusanoMs: 1000 });
    expect(r.ocena).toMatchObject({ tacno: true, poeni: 20 });
  });

  it("browseru se veruje samo unutar tolerancije: ko sluša 10 s ne može da prijavi 1 s", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, DAN);
    let s = await posaljiPitanje(db, ja, DAN);
    await slusaj(ja, s.trenutno!.itemId, 10000);
    let r = await odgovori(db, ja, DAN, { itemId: s.trenutno!.itemId, odgovor: { izbor: izborPesme(1) }, slusanoMs: 1000 });
    expect(r.ocena.poeni).toBe(5); // 10 s − 1,5 s tolerancije = 8,5 s
    expect((r.ocena.prikaz as PrikazPesma).slusanoMs).toBeGreaterThanOrEqual(8500);

    // mala razlika zbog mreže ide u korist igrača: server izmerio 2,3 s, plejer kaže 1,9 s → 20 poena
    s = await posaljiPitanje(db, ja, DAN);
    await slusaj(ja, s.trenutno!.itemId, 2300);
    r = await odgovori(db, ja, DAN, { itemId: s.trenutno!.itemId, odgovor: { izbor: izborPesme(2) }, slusanoMs: 1900 });
    expect(r.ocena.poeni).toBe(20);

    // bez podatka iz browsera važi ono što je server izmerio; besmislen podatak se ne uzima
    s = await posaljiPitanje(db, ja, DAN);
    await slusaj(ja, s.trenutno!.itemId, 4500);
    r = await odgovori(db, ja, DAN, { itemId: s.trenutno!.itemId, odgovor: { izbor: izborPesme(3) }, slusanoMs: -5 });
    expect(r.ocena.poeni).toBe(10);

    // odgovor dok pesma još svira: računa se i deo koji upravo svira
    s = await posaljiPitanje(db, ja, DAN);
    const id = s.trenutno!.itemId;
    await slusanje(db, ja, DAN, { itemId: id, pusteno: true });
    await pg.exec(`update public.play_answers set playing_since = now() - interval '7000 milliseconds' where item_id = ${id} and answered_at is null`);
    r = await odgovori(db, ja, DAN, { itemId: id, odgovor: { izbor: izborPesme(4) } });
    expect(r.ocena.poeni).toBe(5);
  });

  it("klip odsviran do kraja: 0 poena, i kad browser javi istek i kad igrač samo ode", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, DAN);
    let s = await posaljiPitanje(db, ja, DAN);
    await slusaj(ja, s.trenutno!.itemId, 29900);
    const r = await odgovori(db, ja, DAN, { itemId: s.trenutno!.itemId, odgovor: { izbor: izborPesme(1) }, istek: true, slusanoMs: 30000 });
    expect(r.ocena).toMatchObject({ tacno: false, poeni: 0, istek: true });
    expect(r.ocena.prikaz).toMatchObject({ naslov: "Ne može nam niko ništa", odgovor: null, neZnam: false });

    // pustio pesmu i zatvorio tab: posle 30 s (plus tolerancija) pitanje je propalo
    s = await posaljiPitanje(db, ja, DAN);
    const id = s.trenutno!.itemId;
    await slusanje(db, ja, DAN, { itemId: id, pusteno: true });
    await pg.exec(`update public.play_answers set playing_since = now() - interval '31 seconds' where item_id = ${id} and answered_at is null`);
    expect((await stanjeIgre(db, ja, DAN)).trenutno!.itemId).toBe(id); // još u toleranciji
    await pg.exec(`update public.play_answers set playing_since = now() - interval '32 seconds' where item_id = ${id} and answered_at is null`);
    const posle = await stanjeIgre(db, ja, DAN);
    expect(posle.trenutno).toMatchObject({ pozicija: 3, faza: "sledece" });
    expect(posle.segmenti[0].tok).toEqual([0, 0]);

    // pauzirana pesma ne ističe ni posle sat vremena
    s = await posaljiPitanje(db, ja, DAN);
    await slusaj(ja, s.trenutno!.itemId, 1000);
    await pg.exec(`update public.play_answers set served_at = now() - interval '1 hour' where item_id = ${s.trenutno!.itemId}`);
    expect((await stanjeIgre(db, ja, DAN)).trenutno).toMatchObject({ pozicija: 3, faza: "pitanje" });
  });

  it("ceo dan iz seed-a: 5 pesama, pa uvod u „Pogodi cenu”", async () => {
    const ja = gost();
    const uvod = await zapocniIgru(db, ja, POCETAK);
    expect(uvod.trenutno).toMatchObject({ segment: 1, ukupno: 5, faza: "uvod" });
    expect(uvod.segmenti.map((s) => [s.n, s.pitanja, s.max])).toEqual([[1, 5, 100], [2, 10, 100], [3, 8, 40]]);
    const plan = planPesama(katalog.pesme, POCETAK, 1)[0].pesme;
    let poslednji;
    for (const pesma of plan) {
      const s = await posaljiPitanje(db, ja, POCETAK);
      expect(s.trenutno!.pitanje).toEqual({ vrsta: "pesma" });
      poslednji = await odgovori(db, ja, POCETAK, { itemId: s.trenutno!.itemId, odgovor: { tekst: pesma.naslov }, slusanoMs: 1000 });
      expect(poslednji.ocena.prikaz).toMatchObject({ izvodjac: pesma.izvodjac, naslov: pesma.naslov, tacno: true });
    }
    expect(poslednji!.krajSegmenta).toMatchObject({ n: 1, poeni: 100, max: 100, tok: [2, 2, 2, 2, 2] });
    expect(poslednji!.stanje.trenutno).toMatchObject({ segment: 2, pozicija: 1, faza: "uvod" });
  });
});
