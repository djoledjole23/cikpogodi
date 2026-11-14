import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { ucitajProizvode } from "@/lib/content/products";
import { planCena, planGugla, seedSql } from "@/lib/content/seed";
import { ferDuel, napraviPar, odnos, ucitajTrendove } from "@/lib/content/trends";
import { omotajPglite, SUPABASE_ZAMENA } from "@/lib/db/pglite";
import type { Db } from "@/lib/db/types";
import { GreskaIgre, odgovori, posaljiPitanje, stanjeIgre, zapocniIgru } from "@/lib/game/engine";
import type { Identitet, PrikazCena } from "@/lib/game/types";

/**
 * Serverski deo igre na pravom Postgresu u memoriji: ista migracija, isti seed, isti SQL kao na sajtu.
 */
let pg: PGlite;
let db: Db;

const koren = join(__dirname, "..");
const ucitani = ucitajProizvode(JSON.parse(readFileSync(join(koren, "data/products.json"), "utf8")));
const trendovi = ucitajTrendove(JSON.parse(readFileSync(join(koren, "data/trends.json"), "utf8")));
const POCETAK = "2026-11-14";
const SEED = () =>
  seedSql({ proizvodi: ucitani.proizvodi, datumCenovnika: ucitani.datumCenovnika, trendovi, pocetak: POCETAK, dana: 14 });
/** Dan sa samo jednim segmentom (gugla), sa poznatim indeksima. */
const GUGLA_DAN = "2030-02-02";
/** Poseban dan sa cenama zgodnim za granice: 200, 200, 100, 250 dinara. */
const TEST_DAN = "2030-01-01";

let brojac = 0;
const uredjaj = () => `aaaaaaaa-0000-4000-8000-${String(++brojac).padStart(12, "0")}`;
const gost = (deviceId = uredjaj()): Identitet => ({ userId: null, deviceId });

beforeAll(async () => {
  pg = new PGlite();
  await pg.exec(SUPABASE_ZAMENA);
  for (const f of readdirSync(join(koren, "supabase/migrations")).sort()) {
    await pg.exec(readFileSync(join(koren, "supabase/migrations", f), "utf8"));
  }
  await pg.exec(SEED());

  const snap = (cena: number) =>
    JSON.stringify({ naziv: "Probni artikal", kolicina: "1 kom", slika: "https://example.com/x.jpg", cena, min: cena - 10, max: cena + 10, najjeftinije: "Lidl" });
  await pg.exec(`
    insert into public.daily_quiz (quiz_date, status) values ('${TEST_DAN}', 'published');
    insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot) values
      ('${TEST_DAN}', 2, 1, 1, '${snap(200)}'),
      ('${TEST_DAN}', 2, 2, 2, '${snap(200)}'),
      ('${TEST_DAN}', 2, 3, 3, '${snap(100)}'),
      ('${TEST_DAN}', 2, 4, 4, '${snap(250)}');
    insert into public.daily_quiz (quiz_date, status) values ('${GUGLA_DAN}', 'published');
    insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on) values
      ('Levo', 'Desno', 100, 60, 'test', '2026-11-13'), ('Manje', 'Više', 40, 100, 'test', '2026-11-13'), ('Treće', 'Četvrto', 100, 89, 'test', '2026-11-13');
    insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
      select '${GUGLA_DAN}', 3, row_number() over (order by id), id,
             jsonb_build_object('a', term_a, 'b', term_b, 'indeksA', index_a, 'indeksB', index_b, 'period', period)
      from public.trend_pairs where period = 'test';
    insert into auth.users (id, email) values ('11111111-1111-4111-8111-111111111111', 'a@test.rs'), ('22222222-2222-4222-8222-222222222222', 'b@test.rs');
  `);
  db = omotajPglite(pg);
});

/** Odigraj jedno pitanje do kraja: zatraži ga i odgovori. */
async function odigraj(ident: Identitet, datum: string, unos: number) {
  const s = await posaljiPitanje(db, ident, datum);
  return odgovori(db, ident, datum, { itemId: s.trenutno!.itemId, odgovor: { unos } });
}

describe("products.json i seed", () => {
  it("izbacuje artikle bez slike ili cene i ništa ne dopunjava", () => {
    expect(ucitani.proizvodi.length).toBe(76);
    expect(ucitani.izbaceni.length).toBe(18);
    expect(ucitani.izbaceni.every((x) => x.razlog === "nema sliku")).toBe(true);
    for (const p of ucitani.proizvodi) {
      expect(p.slika.startsWith("https://")).toBe(true);
      expect(p.cena).toBeGreaterThan(0);
      expect(Math.round(p.cenaTacna)).toBe(p.cena);
    }
  });

  it("odbija fajl u pogrešnom obliku", () => {
    expect(() => ucitajProizvode({})).toThrow();
    expect(() => ucitajProizvode({ proizvodi: [], datum_cenovnika: "juče" })).toThrow();
  });

  it("sopstvena fotografija (public/artikli/<barkod>) ima prednost i vraća u igru artikal bez slike", () => {
    const json = JSON.parse(readFileSync(join(koren, "data/products.json"), "utf8"));
    const bezSlike = (json.proizvodi as { barkod: string; slika_url?: string }[]).find((x) => !x.slika_url)!;
    const saSlikom = ucitani.proizvodi[0];
    const slike = new Map([
      [bezSlike.barkod, `/artikli/${bezSlike.barkod}.jpg`],
      [saSlikom.barkod, `/artikli/${saSlikom.barkod}.webp`],
    ]);
    const novi = ucitajProizvode(json, slike);
    expect(novi.proizvodi.length).toBe(ucitani.proizvodi.length + 1);
    expect(novi.proizvodi.find((x) => x.barkod === bezSlike.barkod)!.slika).toBe(`/artikli/${bezSlike.barkod}.jpg`);
    expect(novi.proizvodi.find((x) => x.barkod === saSlikom.barkod)!.slika).toBe(`/artikli/${saSlikom.barkod}.webp`);
  });

  it("14 dana po 10 različitih artikala, bez istog naziva dvaput u danu", () => {
    const plan = planCena(ucitani.proizvodi, POCETAK, 14);
    expect(plan.length).toBe(14);
    expect(plan[0].datum).toBe("2026-11-14");
    expect(plan[13].datum).toBe("2026-11-27");
    const koriscenje = new Map<string, number>();
    plan.forEach((dan, i) => {
      expect(dan.artikli.length).toBe(10);
      expect(new Set(dan.artikli.map((a) => a.naziv)).size).toBe(10);
      const poKat = new Map<string, number>();
      for (const a of dan.artikli) {
        poKat.set(a.kategorija, (poKat.get(a.kategorija) ?? 0) + 1);
        koriscenje.set(a.barkod, (koriscenje.get(a.barkod) ?? 0) + 1);
      }
      expect(Math.max(...poKat.values())).toBeLessThanOrEqual(4);
      if (i > 0) {
        const juce = new Set(plan[i - 1].artikli.map((a) => a.barkod));
        expect(dan.artikli.filter((a) => juce.has(a.barkod)).length).toBe(0);
      }
    });
    // 140 mesta na 76 artikala: niko ne sme da se vrti stalno
    expect(Math.max(...koriscenje.values())).toBeLessThanOrEqual(3);
  });

  it("raspored je isti pri svakom pokretanju", () => {
    const a = planCena(ucitani.proizvodi, POCETAK, 14).map((d) => d.artikli.map((x) => x.barkod));
    const b = planCena(ucitani.proizvodi, POCETAK, 14).map((d) => d.artikli.map((x) => x.barkod));
    expect(a).toEqual(b);
  });

  it("seed je upisan u bazu i može da se pusti ponovo bez duplikata", async () => {
    await pg.exec(SEED());
    const [p] = await db.query<{ n: number }>("select count(*)::int as n from public.products");
    const [i] = await db.query<{ n: number }>(
      "select count(*)::int as n from public.daily_quiz_items where quiz_date between '2026-11-14' and '2026-11-27'",
    );
    expect(p.n).toBe(76);
    expect(i.n).toBe(140 + 112); // 14 × (10 cena + 8 parova)
    const [cena] = await db.query<{ cena: number; price: number }>(
      `select (i.snapshot->>'cena')::int as cena, round(p.price_avg)::int as price
       from public.daily_quiz_items i join public.products p on p.id = i.product_id
       where i.quiz_date = '2026-11-14' and i.position = 1`,
    );
    expect(cena.cena).toBe(cena.price);
  });
});

describe("tok igre", () => {
  it("dan bez kviza", async () => {
    const s = await stanjeIgre(db, gost(), "2031-05-05");
    expect(s.status).toBe("nema_kviza");
    expect((await zapocniIgru(db, gost(), "2031-05-05")).status).toBe("nema_kviza");
  });

  it("početak: uvod u segment, bez pitanja dok igrač ne klikne Kreni", async () => {
    const ja = gost();
    expect((await stanjeIgre(db, ja, POCETAK)).status).toBe("nije_poceo");
    const s = await zapocniIgru(db, ja, POCETAK);
    expect(s.status).toBe("u_toku");
    expect(s.trenutno).toMatchObject({ segment: 2, pozicija: 1, ukupno: 10, faza: "uvod" });
    expect(s.trenutno!.pitanje).toBeUndefined();
    expect(s.segmenti).toEqual([
      expect.objectContaining({ n: 2, key: "cena", pitanja: 10, odgovoreno: 0, poeni: 0, max: 100 }),
      expect.objectContaining({ n: 3, key: "gugla", pitanja: 8, odgovoreno: 0, poeni: 0, max: 40 }),
    ]);
  });

  it("pitanje ne nosi cenu ni opseg (ni pod kojim imenom)", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, TEST_DAN);
    const s = await posaljiPitanje(db, ja, TEST_DAN);
    expect(s.trenutno!.faza).toBe("pitanje");
    expect(s.trenutno!.pitanje).toEqual({ vrsta: "cena", naziv: "Probni artikal", kolicina: "1 kom", slika: "https://example.com/x.jpg" });
    expect(s.trenutno!.limitMs).toBe(20000);
    expect(s.trenutno!.preostaloMs).toBeGreaterThan(19000);
    // `trenutno` je jedini deo stanja koji govori o pitanju: tačno ova polja i nijedno više.
    expect(Object.keys(s.trenutno!).sort()).toEqual(["faza", "itemId", "limitMs", "pitanje", "pozicija", "preostaloMs", "segment", "ukupno"]);
    const tekst = JSON.stringify(s.trenutno);
    for (const zabranjeno of ["cena\":", "prava", "min\"", "max\"", "najjeftinije", "snapshot"]) {
      expect(tekst.includes(zabranjeno), `u pitanju se našlo: ${zabranjeno}`).toBe(false);
    }
  });

  it("bodovanje na granicama: tačno 10%, za dinar preko, tačno 15%, za dinar preko", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, TEST_DAN);
    const a = await odigraj(ja, TEST_DAN, 220); // 200 → +10%
    expect(a.ocena).toMatchObject({ poeni: 10, tacno: true, maxPoena: 10, istek: false });
    expect(a.ocena.prikaz).toMatchObject({ unos: 220, prava: 200, procenat: "+10%", min: 190, max: 210, najjeftinije: "Lidl" });
    const b = await odigraj(ja, TEST_DAN, 221); // 200 → +10,5%
    expect(b.ocena.poeni).toBe(5);
    const c = await odigraj(ja, TEST_DAN, 85); // 100 → −15%
    expect(c.ocena).toMatchObject({ poeni: 5, tacno: true });
    expect(c.krajSegmenta).toBeUndefined();
    const d = await odigraj(ja, TEST_DAN, 288); // 250 → +15,2%
    expect(d.ocena).toMatchObject({ poeni: 0, tacno: false });
    expect(d.krajSegmenta).toMatchObject({ n: 2, poeni: 20, max: 40, odgovoreno: 4 });
    expect(d.stanje.status).toBe("zavrseno");
    expect(d.stanje.score).toBe(20);
    expect(d.stanje.rezultat!.map((r) => [r.poeni, (r.prikaz as PrikazCena).unos, (r.prikaz as PrikazCena).prava])).toEqual([
      [10, 220, 200],
      [5, 221, 200],
      [5, 85, 100],
      [0, 288, 250],
    ]);

    const [igra] = await db.query<{ status: string; score: number; total: number; gotovo: boolean }>(
      `select status, score::int as score, total_answer_ms::int as total, finished_at is not null as gotovo
       from public.plays where quiz_date = $1::date and device_id = $2::uuid`,
      [TEST_DAN, ja.deviceId],
    );
    expect(igra).toMatchObject({ status: "finished", score: 20, gotovo: true });
    expect(igra.total).toBeGreaterThanOrEqual(0);
  });

  it("decimale i gluposti u unosu", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, TEST_DAN);
    const s1 = await posaljiPitanje(db, ja, TEST_DAN);
    const a = await odgovori(db, ja, TEST_DAN, { itemId: s1.trenutno!.itemId, odgovor: { unos: 199.6 } });
    expect((a.ocena.prikaz as PrikazCena).unos).toBe(200); // zaokruženo na dinar
    expect(a.ocena.poeni).toBe(10);
    const s2 = await posaljiPitanje(db, ja, TEST_DAN);
    const b = await odgovori(db, ja, TEST_DAN, { itemId: s2.trenutno!.itemId, odgovor: { unos: "200" } });
    expect(b.ocena).toMatchObject({ poeni: 0, tacno: false });
    const s3 = await posaljiPitanje(db, ja, TEST_DAN);
    const c = await odgovori(db, ja, TEST_DAN, { itemId: s3.trenutno!.itemId, odgovor: { unos: -5 } });
    expect(c.ocena.poeni).toBe(0);
    const s4 = await posaljiPitanje(db, ja, TEST_DAN);
    const d = await odgovori(db, ja, TEST_DAN, { itemId: s4.trenutno!.itemId, odgovor: null });
    expect(d.ocena.poeni).toBe(0);
  });

  it("ne može dvaput na isto pitanje, ni na pitanje koje nije poslato", async () => {
    const ja = gost();
    const pocetno = await zapocniIgru(db, ja, TEST_DAN);
    await expect(
      odgovori(db, ja, TEST_DAN, { itemId: pocetno.trenutno!.itemId, odgovor: { unos: 200 } }),
    ).rejects.toMatchObject({ kod: "nije_poslato" });

    const s = await posaljiPitanje(db, ja, TEST_DAN);
    const prvo = s.trenutno!.itemId;
    await odgovori(db, ja, TEST_DAN, { itemId: prvo, odgovor: { unos: 500 } });
    await expect(odgovori(db, ja, TEST_DAN, { itemId: prvo, odgovor: { unos: 200 } })).rejects.toBeInstanceOf(GreskaIgre);
    const posle = await stanjeIgre(db, ja, TEST_DAN);
    expect(posle.score).toBe(0); // drugi pokušaj nije prepravio prvi
    expect(posle.trenutno).toMatchObject({ pozicija: 2, faza: "sledece" });
  });

  it("osvežavanje strane nastavlja isto pitanje i ne vraća vreme na početak", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, TEST_DAN);
    const prvi = await posaljiPitanje(db, ja, TEST_DAN);
    await pg.exec(`update public.play_answers set served_at = now() - interval '8 seconds' where item_id = ${prvi.trenutno!.itemId}
                   and play_id = (select id from public.plays where device_id = '${ja.deviceId}' and quiz_date = '${TEST_DAN}')`);
    const posleOsvezavanja = await stanjeIgre(db, ja, TEST_DAN);
    expect(posleOsvezavanja.trenutno).toMatchObject({ itemId: prvi.trenutno!.itemId, faza: "pitanje", pozicija: 1 });
    expect(posleOsvezavanja.trenutno!.preostaloMs).toBeLessThanOrEqual(12000);
    expect(posleOsvezavanja.trenutno!.preostaloMs).toBeGreaterThan(11000);
    // ponovno traženje pitanja ne pokreće sat ispočetka
    const opet = await posaljiPitanje(db, ja, TEST_DAN);
    expect(opet.trenutno!.preostaloMs).toBeLessThanOrEqual(12000);
  });
});

describe("vreme", () => {
  const pomeriSat = (ja: Identitet, itemId: number, sekundi: number) =>
    pg.exec(`update public.play_answers set served_at = now() - interval '${sekundi} seconds' where item_id = ${itemId}
             and play_id = (select id from public.plays where device_id = '${ja.deviceId}' and quiz_date = '${TEST_DAN}')`);

  it("browser javi istek: 0 poena, ide se dalje", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, TEST_DAN);
    const s = await posaljiPitanje(db, ja, TEST_DAN);
    const r = await odgovori(db, ja, TEST_DAN, { itemId: s.trenutno!.itemId, odgovor: { unos: 200 }, istek: true });
    expect(r.ocena).toMatchObject({ poeni: 0, tacno: false, istek: true });
    expect(r.ocena.prikaz).toMatchObject({ unos: null, prava: 200, procenat: "" });
    expect(r.stanje.trenutno).toMatchObject({ pozicija: 2, faza: "sledece" });
  });

  it("odgovor stigne malo posle roka (spora mreža): još se priznaje", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, TEST_DAN);
    const s = await posaljiPitanje(db, ja, TEST_DAN);
    await pomeriSat(ja, s.trenutno!.itemId, 21);
    const r = await odgovori(db, ja, TEST_DAN, { itemId: s.trenutno!.itemId, odgovor: { unos: 200 } });
    expect(r.ocena.poeni).toBe(10);
    const [red] = await db.query<{ ms: number }>(
      `select answer_ms::int as ms from public.play_answers where item_id = $1::int and play_id = (select id from public.plays where device_id = $2::uuid and quiz_date = $3::date)`,
      [s.trenutno!.itemId, ja.deviceId, TEST_DAN],
    );
    expect(red.ms).toBe(20000); // vreme za rang listu se ne računa preko limita
  });

  it("odgovor stigne baš kasno: pitanje je već zatvoreno kao netačno", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, TEST_DAN);
    const s = await posaljiPitanje(db, ja, TEST_DAN);
    await pomeriSat(ja, s.trenutno!.itemId, 25);
    await expect(
      odgovori(db, ja, TEST_DAN, { itemId: s.trenutno!.itemId, odgovor: { unos: 200 } }),
    ).rejects.toMatchObject({ kod: "nije_na_redu" });
  });

  it("igrač zatvori tab usred pitanja: kad se vrati, pitanje je propalo i čeka ga sledeće", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, TEST_DAN);
    const s = await posaljiPitanje(db, ja, TEST_DAN);
    await pomeriSat(ja, s.trenutno!.itemId, 3600);
    const posle = await stanjeIgre(db, ja, TEST_DAN);
    expect(posle.status).toBe("u_toku");
    expect(posle.score).toBe(0);
    expect(posle.trenutno).toMatchObject({ pozicija: 2, faza: "sledece" });
    expect(posle.segmenti[0].odgovoreno).toBe(1);
  });
});

describe("jedna igra dnevno", () => {
  it("drugi start istog dana ne pravi novu igru", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, TEST_DAN);
    await odigraj(ja, TEST_DAN, 200);
    const opet = await zapocniIgru(db, ja, TEST_DAN);
    expect(opet.score).toBe(10);
    expect(opet.trenutno!.pozicija).toBe(2);
    const [n] = await db.query<{ n: number }>(
      "select count(*)::int as n from public.plays where device_id = $1::uuid and quiz_date = $2::date",
      [ja.deviceId, TEST_DAN],
    );
    expect(n.n).toBe(1);
  });

  it("dva uređaja su dve igre, a isti uređaj sutra opet može", async () => {
    const a = gost();
    const b = gost();
    await zapocniIgru(db, a, TEST_DAN);
    await odigraj(a, TEST_DAN, 200);
    expect((await zapocniIgru(db, b, TEST_DAN)).score).toBe(0);
    expect((await stanjeIgre(db, a, POCETAK)).status).toBe("nije_poceo");
  });

  it("gost se prijavi usred igre: igra postaje njegova, a na tom uređaju nema nove kao gost", async () => {
    const uredj = uredjaj();
    const kaoGost = gost(uredj);
    const kaoIgrac: Identitet = { userId: "11111111-1111-4111-8111-111111111111", deviceId: uredj };
    await zapocniIgru(db, kaoGost, TEST_DAN);
    await odigraj(kaoGost, TEST_DAN, 200);

    const posle = await stanjeIgre(db, kaoIgrac, TEST_DAN);
    expect(posle.score).toBe(10);
    expect(posle.trenutno!.pozicija).toBe(2);

    // isti nalog sa drugog telefona vidi istu igru
    const drugiTelefon: Identitet = { userId: kaoIgrac.userId, deviceId: uredjaj() };
    expect((await zapocniIgru(db, drugiTelefon, TEST_DAN)).score).toBe(10);

    // odjavi se: kao gost na istom uređaju ne dobija novu igru
    expect((await stanjeIgre(db, kaoGost, TEST_DAN)).status).toBe("uredjaj_igrao");
    expect((await zapocniIgru(db, kaoGost, TEST_DAN)).status).toBe("uredjaj_igrao");
  });

  it("nalog koji je već igrao ne dobija drugu igru ni sa novog uređaja", async () => {
    const igrac = "22222222-2222-4222-8222-222222222222";
    const prvi: Identitet = { userId: igrac, deviceId: uredjaj() };
    await zapocniIgru(db, prvi, TEST_DAN);
    for (const unos of [200, 200, 100, 250]) await odigraj(prvi, TEST_DAN, unos);
    const drugi: Identitet = { userId: igrac, deviceId: uredjaj() };
    const s = await zapocniIgru(db, drugi, TEST_DAN);
    expect(s.status).toBe("zavrseno");
    expect(s.score).toBe(40);
  });
});

describe("trends.json: jedna skala za sve teme", () => {
  const pojam = (naziv: string) => trendovi.pojmovi.find((p) => p.naziv === naziv)!;

  it("mostovi svode sve grupe na istu skalu, a merenja se slažu", () => {
    expect(trendovi.pojmovi.length).toBe(104);
    expect(new Set(trendovi.pojmovi.map((p) => p.tema)).size).toBe(21);
    // dva merenja istog odnosa (preko različitih mostova) ne razlikuju se više od 3%
    expect(trendovi.najveceOdstupanje).toBeLessThan(0.03);
    // unutar grupe odnos ostaje onakav kakav je izmeren: burek 49,38 naspram ćevapa 45,6
    expect(pojam("Ćevapi").jacina / pojam("Burek").jacina).toBeCloseTo(45.6 / 49.38, 6);
    // provera spolja: šljiva i Jokić su iz različitih grupa i nisu zajedno ni u jednom mostu,
    // a kad se direktno uporede u Trends-u izlazi 34,13 : 27,08. Zajednička skala mora da da isto (±5%).
    const izracunato = pojam("Šljiva").jacina / pojam("Nikola Jokić").jacina;
    expect(Math.abs(izracunato / (34.13 / 27.08) - 1)).toBeLessThan(0.05);
    // most „novi sad 69,6 : vremenska prognoza 62,42”
    expect(odnos(pojam("Novi Sad"), pojam("Vremenska prognoza"))).toBeCloseTo(62.42 / 69.6, 1);
  });

  it("ljudi i mesta se mere kao tema (sve pretrage o njima), a ne kao tačno ukucan tekst", () => {
    for (const naziv of ["Nikola Jokić", "Ceca", "Novi Sad", "Šljiva", "Burek"]) expect(pojam(naziv).mera, naziv).toBe("tema");
    // tačan tekst ostaje tamo gde tema hvata manje od samog teksta ili je nema
    for (const naziv of ["BMW", "Palačinke", "Polovni automobili", "Matematika"]) {
      expect(pojam(naziv).mera, naziv).toBe("tekst");
      expect(pojam(naziv).nesigurnost).toBeGreaterThanOrEqual(0.25); // traži veću razliku u duelu
    }
    expect(pojam("Nikola Jokić").nesigurnost).toBeLessThan(0.02);
  });

  it("premalo pretraga ili nepouzdano merenje → pojam ne ulazi u igru", () => {
    // praznici imaju jedan veliki skok godišnje, pa im je prosek premali da se pouzdano veže za ostale grupe
    for (const naziv of ["Vidovdan", "Slagalica", "Božić", "Uskrs", "Slava", "Nova godina"]) {
      expect(pojam(naziv)).toBeUndefined();
      expect(trendovi.izbaceni.some((x) => x.naziv === naziv)).toBe(true);
    }
  });

  it("duel je fer samo kad je pobednik jasan, ali ne preočigledan", () => {
    expect(ferDuel(pojam("Novi Sad"), pojam("Vremenska prognoza"))).toBe(false); // preblizu
    expect(ferDuel(pojam("Klima"), pojam("Frižider"))).toBe(false); // 26,06 naspram 25,77
    expect(ferDuel(pojam("Burek"), pojam("Ćevapi"))).toBe(false); // 49,38 naspram 45,6
    expect(ferDuel(pojam("Novi Sad"), pojam("Tulumbe"))).toBe(false); // preočigledno
    expect(ferDuel(pojam("Burek"), pojam("Burek"))).toBe(false);
    expect(ferDuel(pojam("Burek"), pojam("Gibanica"))).toBe(true); // ista grupa
    expect(ferDuel(pojam("Čaj"), pojam("Zlatibor"))).toBe(true); // različite grupe
    // mali brojevi nose veliku grešku zaokruživanja, pa im treba veća razlika
    const mali = { ...pojam("Burek"), prosekUGrupi: 2.5, nesigurnost: 0.2, upit: "x" };
    const maloVeci = { ...mali, jacina: mali.jacina * 1.4, upit: "y" };
    expect(odnos(mali, maloVeci)).toBeLessThan(0.8);
    expect(ferDuel(mali, maloVeci)).toBe(false);
  });

  it("u duelu jači pojam ima 100, a slabiji srazmerno manje", () => {
    const par = napraviPar(pojam("Ćevapi"), pojam("Burek"), "p", "2026-11-14");
    expect(par).toMatchObject({ a: "Ćevapi", b: "Burek", indeksA: 92, indeksB: 100 });
  });

  it("odbija fajl u pogrešnom obliku", () => {
    expect(() => ucitajTrendove({})).toThrow();
    expect(() => ucitajTrendove({ period: "x", datum_preuzimanja: "2026-11-13", grupe: [{ tema: "T", pojmovi: [{ naziv: "A" }] }] })).toThrow();
    // tema koju nijedan most ne povezuje sa ostalima ne može da se poredi, pa ispada
    const bezMosta = ucitajTrendove({
      period: "x",
      datum_preuzimanja: "2026-11-13",
      mostovi: [],
      grupe: [
        { tema: "A", pojmovi: [{ naziv: "a1", upit: "a1", prosek: 50 }] },
        { tema: "B", pojmovi: [{ naziv: "b1", upit: "b1", prosek: 50 }] },
      ],
    });
    expect(bezMosta.pojmovi.map((p) => p.naziv)).toEqual(["a1"]);
  });

  it("14 dana po 8 duela: pobednik ostaje na svom mestu, izazivač dolazi na mesto gubitnika", () => {
    const plan = planGugla(trendovi, POCETAK, 14);
    expect(plan.length).toBe(14);
    const svi = new Set<string>();
    const tema = (naziv: string) => pojam(naziv).tema;
    let pobedeIzazivaca = 0;

    for (const dan of plan) {
      expect(dan.dueli.length).toBe(8);
      // 9 pojmova u danu, svaki iz druge teme
      const nazivi = new Set(dan.dueli.flatMap((p) => [p.a, p.b]));
      expect(nazivi.size).toBe(9);
      expect(new Set([...nazivi].map(tema)).size).toBe(9);

      let pobede = 0;
      dan.dueli.forEach((p, i) => {
        expect(Math.max(p.indeksA, p.indeksB)).toBe(100);
        expect(Math.min(p.indeksA, p.indeksB)).toBeGreaterThanOrEqual(20);
        expect(Math.min(p.indeksA, p.indeksB)).toBeLessThanOrEqual(80);
        const k = [p.upitA, p.upitB].sort().join("|");
        expect(svi.has(k)).toBe(false);
        svi.add(k);
        if (i === 0) return;
        // pobednik prethodnog duela stoji na istom mestu (gore ili dole), drugi pojam je nov
        const pre = dan.dueli[i - 1];
        const gorePobedio = pre.indeksA > pre.indeksB;
        if (gorePobedio) {
          expect(p.a).toBe(pre.a);
          expect(p.b).not.toBe(pre.b);
          if (p.indeksB > p.indeksA) pobede++;
        } else {
          expect(p.b).toBe(pre.b);
          expect(p.a).not.toBe(pre.a);
          if (p.indeksA > p.indeksB) pobede++;
        }
      });
      // izazivač ne gubi uvek: „uvek tapni šampiona” ne sme da bude taktika
      expect(pobede).toBeGreaterThanOrEqual(2);
      expect(pobede).toBeLessThanOrEqual(5);
      pobedeIzazivaca += pobede;
    }
    expect(svi.size).toBe(112);
    expect(pobedeIzazivaca / (14 * 7)).toBeGreaterThan(0.35);
    expect(pobedeIzazivaca / (14 * 7)).toBeLessThan(0.65);
    expect(planGugla(trendovi, POCETAK, 14)).toEqual(plan); // isti raspored pri svakom pokretanju
  });
});

describe("segment 3: šta se više gugla", () => {
  it("pitanje nosi samo dva naziva, bez indeksa", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, GUGLA_DAN);
    const s = await posaljiPitanje(db, ja, GUGLA_DAN);
    expect(s.trenutno!.pitanje).toEqual({ vrsta: "gugla", a: "Levo", b: "Desno" });
    expect(s.trenutno!.limitMs).toBe(10000);
    expect(JSON.stringify(s.trenutno)).not.toMatch(/indeks|tacan|snapshot/);
  });

  it("tačno = 5, netačno = 0, istek = 0; posle odgovora stižu oba indeksa", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, GUGLA_DAN);
    let s = await posaljiPitanje(db, ja, GUGLA_DAN);
    const a = await odgovori(db, ja, GUGLA_DAN, { itemId: s.trenutno!.itemId, odgovor: { izbor: "a" } });
    expect(a.ocena).toMatchObject({ tacno: true, poeni: 5, maxPoena: 5 });
    expect(a.ocena.prikaz).toEqual({ vrsta: "gugla", a: "Levo", b: "Desno", indeksA: 100, indeksB: 60, puta: 1.7, izbor: "a", tacan: "a", period: "test" });

    s = await posaljiPitanje(db, ja, GUGLA_DAN);
    const b = await odgovori(db, ja, GUGLA_DAN, { itemId: s.trenutno!.itemId, odgovor: { izbor: "a" } });
    expect(b.ocena).toMatchObject({ tacno: false, poeni: 0 });
    expect(b.ocena.prikaz).toMatchObject({ izbor: "a", tacan: "b" });

    s = await posaljiPitanje(db, ja, GUGLA_DAN);
    const c = await odgovori(db, ja, GUGLA_DAN, { itemId: s.trenutno!.itemId, odgovor: { izbor: "a" }, istek: true });
    expect(c.ocena).toMatchObject({ tacno: false, poeni: 0, istek: true });
    expect(c.ocena.prikaz).toMatchObject({ izbor: null, tacan: "a" });
    expect(c.krajSegmenta).toMatchObject({ n: 3, poeni: 5, max: 15, tok: [2, 0, 0] });
    expect(c.stanje.status).toBe("zavrseno");
    expect(c.stanje.rezultat!.map((r) => [r.poeni, r.istek])).toEqual([[5, false], [0, false], [0, true]]);
  });

  it("gluposti umesto izbora su netačan odgovor, ne greška", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, GUGLA_DAN);
    for (const odgovor of [{ izbor: "c" }, { izbor: 1 }, "a"]) {
      const s = await posaljiPitanje(db, ja, GUGLA_DAN);
      const r = await odgovori(db, ja, GUGLA_DAN, { itemId: s.trenutno!.itemId, odgovor });
      expect(r.ocena.poeni).toBe(0);
    }
  });

  it("posle 10 sekundi (plus tolerancija) pitanje je propalo", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, GUGLA_DAN);
    const s = await posaljiPitanje(db, ja, GUGLA_DAN);
    await pg.exec(`update public.play_answers set served_at = now() - interval '12 seconds' where item_id = ${s.trenutno!.itemId}
                   and play_id = (select id from public.plays where device_id = '${ja.deviceId}' and quiz_date = '${GUGLA_DAN}')`);
    await expect(
      odgovori(db, ja, GUGLA_DAN, { itemId: s.trenutno!.itemId, odgovor: { izbor: "a" } }),
    ).rejects.toMatchObject({ kod: "nije_na_redu" });
    expect((await stanjeIgre(db, ja, GUGLA_DAN)).trenutno).toMatchObject({ pozicija: 2, faza: "sledece" });
  });

  it("ceo dan iz seed-a: posle cene ide uvod u „Šta se više gugla”", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, POCETAK);
    let poslednji;
    for (let i = 0; i < 10; i++) poslednji = await odigraj(ja, POCETAK, 100);
    expect(poslednji!.krajSegmenta).toMatchObject({ n: 2 });
    expect(poslednji!.stanje.status).toBe("u_toku");
    expect(poslednji!.stanje.trenutno).toMatchObject({ segment: 3, pozicija: 1, ukupno: 8, faza: "uvod" });
  });

  it("ceo dan iz seed-a: pojam koji pobedi ostaje u sledećem pitanju, na istom mestu", async () => {
    const ja = gost();
    await zapocniIgru(db, ja, POCETAK);
    for (let i = 0; i < 10; i++) await odigraj(ja, POCETAK, 100);
    let pre: { a: string; b: string; tacan: "a" | "b" } | null = null;
    for (let i = 0; i < 8; i++) {
      const s = await posaljiPitanje(db, ja, POCETAK);
      const pitanje = s.trenutno!.pitanje as { vrsta: "gugla"; a: string; b: string };
      if (pre) expect(pitanje[pre.tacan]).toBe(pre[pre.tacan]);
      const r = await odgovori(db, ja, POCETAK, { itemId: s.trenutno!.itemId, odgovor: { izbor: "a" } });
      const p = r.ocena.prikaz as { a: string; b: string; tacan: "a" | "b" };
      pre = { a: p.a, b: p.b, tacan: p.tacan };
      // tok segmenta se puni redom i ne odaje ništa unapred
      expect(r.stanje.segmenti.find((x) => x.n === 3)!.tok.length).toBe(i + 1);
    }
  });
});
