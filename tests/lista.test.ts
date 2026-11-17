import { botoviZaDan, botovaIspred } from "@/lib/game/botovi";
/**
 * Čuvanje rezultata i rang lista:
 *  - gost: rezultat nije na listi; prijavljen sa potvrđenim mejlom: odmah na listi; nepotvrđen: „na čekanju”
 *  - gost koji se posle igre prijavi ili registruje: igra prelazi na nalog
 *  - lista: Danas / Ova nedelja / Ukupno, izjednačenje po brzini, igrač vidi svoj red i van prvih 50
 */
import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { ucitajProizvode } from "@/lib/content/products";
import { seedSql } from "@/lib/content/seed";
import { omotajPglite, SUPABASE_ZAMENA } from "@/lib/db/pglite";
import type { Db } from "@/lib/db/types";
import { odgovori, posaljiPitanje, prikljuciZavrseneIgre, stanjeIgre, zapocniIgru } from "@/lib/game/engine";
import { dopuniStanje, granicePerioda, mestoNaListi, rangLista } from "@/lib/game/lista";
import { tekstZaDeljenje } from "@/lib/game/podeli";
import type { Identitet, Stanje } from "@/lib/game/types";

const koren = join(__dirname, "..");
const DAN = "2026-11-14"; // subota
const SUTRA = "2026-11-15"; // nedelja (ista nedelja)
const PONEDELJAK = "2026-11-16"; // sledeća nedelja

let pg: PGlite;
let db: Db;
let brojac = 0;
const uredjaj = () => `ffffffff-0000-4000-8000-${String(++brojac).padStart(12, "0")}`;

/** Novi nalog u auth.users (profil pravi okidač iz migracije), sa korisničkim imenom. */
async function nalog(ime: string | null, potvrdjen = true): Promise<string> {
  const { rows } = await pg.query<{ id: string }>(
    `insert into auth.users (email, email_confirmed_at) values ($1, $2) returning id::text as id`,
    [`${ime ?? "bezimena"}${++brojac}@example.com`, potvrdjen ? new Date().toISOString() : null],
  );
  if (ime) await pg.query(`update public.profiles set username = $2 where id = $1::uuid`, [rows[0].id, ime]);
  return rows[0].id;
}

/** Odigra ceo dan. `cena` je šta igrač kuca za svaki artikal (1 = promašaj). Vraća završno stanje. */
async function odigraj(ja: Identitet, dan: string): Promise<Stanje> {
  let s = await zapocniIgru(db, ja, dan);
  for (let n = 0; n < 40 && s.status === "u_toku"; n++) {
    if (s.trenutno!.faza !== "pitanje") s = await posaljiPitanje(db, ja, dan);
    s = (await odgovori(db, ja, dan, { itemId: s.trenutno!.itemId, odgovor: s.trenutno!.segment === 2 ? { unos: 1 } : { neZnam: true } })).stanje;
  }
  expect(s.status).toBe("zavrseno");
  return s;
}

/** Upiše gotovu igru direktno (za raspored na listi, gde nije bitno kako je odigrana). */
async function gotovaIgra(userId: string, dan: string, poeni: number, ms: number, lista: "counted" | "pending" | "none" = "counted") {
  await pg.query(
    `insert into public.plays (quiz_date, user_id, device_id, status, score, total_answer_ms, leaderboard_status, finished_at)
     values ($1::date, $2::uuid, gen_random_uuid(), 'finished', $3, $4, $5, now())`,
    [dan, userId, poeni, ms, lista],
  );
}

beforeAll(async () => {
  pg = new PGlite();
  await pg.exec(SUPABASE_ZAMENA);
  for (const f of readdirSync(join(koren, "supabase/migrations")).sort()) {
    await pg.exec(readFileSync(join(koren, "supabase/migrations", f), "utf8"));
  }
  const proizvodi = ucitajProizvode(JSON.parse(readFileSync(join(koren, "data", "products.json"), "utf8")));
  // Samo segment sa cenama (10 pitanja dnevno): dovoljno za tok igre, a brzo.
  await pg.exec(seedSql({ proizvodi: proizvodi.proizvodi, datumCenovnika: proizvodi.datumCenovnika, pocetak: DAN, dana: 3 }));
  db = omotajPglite(pg);
});

describe("čuvanje rezultata", () => {
  it("gost: rezultat nije na listi, a stanje kaže da nije prijavljen", async () => {
    const ja: Identitet = { userId: null, deviceId: uredjaj() };
    const s = await dopuniStanje(db, ja, await odigraj(ja, DAN), true);
    expect(s).toMatchObject({ status: "zavrseno", lista: "none", prijavljen: false, nalozi: true });
    expect(s.mesto).toBeUndefined();
    expect(await rangLista(db, "danas", DAN, null)).toEqual([]);
  });

  it("prijavljen, mejl potvrđen: rezultat ide na listu čim završi, i odmah ima mesto", async () => {
    const id = await nalog("Mile");
    const ja: Identitet = { userId: id, deviceId: uredjaj() };
    const s = await dopuniStanje(db, ja, await odigraj(ja, DAN), true);
    // Na dnevnoj listi su i botovi: mesto = 1 među ljudima + botovi sa više poena.
    expect(s).toMatchObject({ lista: "counted", prijavljen: true, mesto: 1 + botovaIspred(botoviZaDan(DAN), s.score) });
    expect(await mestoNaListi(db, id, DAN)).toBe(1);
  });

  it("prijavljen, mejl nije potvrđen: „na čekanju”; kad ga potvrdi, ulazi na listu", async () => {
    const id = await nalog("Cekalica", false);
    const ja: Identitet = { userId: id, deviceId: uredjaj() };
    expect((await odigraj(ja, DAN)).lista).toBe("pending");
    expect(await mestoNaListi(db, id, DAN)).toBeNull();
    await pg.query(`update auth.users set email_confirmed_at = now() where id = $1::uuid`, [id]);
    expect((await stanjeIgre(db, ja, DAN)).lista).toBe("counted"); // okidač u bazi
    expect(await mestoNaListi(db, id, DAN)).not.toBeNull();
  });

  it("gost završi, pa se prijavi: igra postaje njegova i ide na listu (ne dobija drugu igru)", async () => {
    const dev = uredjaj();
    const gost: Identitet = { userId: null, deviceId: dev };
    const kaoGost = await odigraj(gost, DAN);
    const id = await nalog("Kasni");
    const posle = await stanjeIgre(db, { userId: id, deviceId: dev }, DAN);
    expect(posle).toMatchObject({ status: "zavrseno", lista: "counted", score: kaoGost.score });
    expect(posle.rezultat).toEqual(kaoGost.rezultat);
    // posle odjave: uređaj je i dalje „potrošen” za taj dan
    expect((await stanjeIgre(db, gost, DAN)).status).toBe("uredjaj_igrao");
    expect((await zapocniIgru(db, gost, DAN)).status).toBe("uredjaj_igrao");
  });

  it("gost završi, pa se registruje (još nema sesiju): igra čeka potvrdu, a on i dalje vidi rezultat na svom uređaju", async () => {
    const dev = uredjaj();
    const gost: Identitet = { userId: null, deviceId: dev };
    const kaoGost = await odigraj(gost, DAN);
    const id = await nalog("Novajlija", false);
    expect(await prikljuciZavrseneIgre(db, id, dev, [DAN, "2026-11-13"])).toBe(1);
    expect(await prikljuciZavrseneIgre(db, id, dev, [DAN])).toBe(0); // drugi put nema šta
    const s = await stanjeIgre(db, gost, DAN);
    expect(s).toMatchObject({ status: "zavrseno", lista: "pending", score: kaoGost.score });
    expect(await mestoNaListi(db, id, DAN)).toBeNull();
    // potvrda mejla → na listi, bez ikakve prijave
    await pg.query(`update auth.users set email_confirmed_at = now() where id = $1::uuid`, [id]);
    expect(await mestoNaListi(db, id, DAN)).not.toBeNull();
    // sada je to običan nalog: gost na tom uređaju mora da se prijavi da vidi rezultat
    expect((await stanjeIgre(db, gost, DAN)).status).toBe("uredjaj_igrao");
  });

  it("registracija ne dira igru u toku, tuđe uređaje ni dan za koji nalog već ima igru", async () => {
    const dev = uredjaj();
    const gost: Identitet = { userId: null, deviceId: dev };
    let s = await zapocniIgru(db, gost, DAN);
    s = await posaljiPitanje(db, gost, DAN);
    await odgovori(db, gost, DAN, { itemId: s.trenutno!.itemId, odgovor: { unos: 1 } });
    const id = await nalog("Usred");
    expect(await prikljuciZavrseneIgre(db, id, dev, [DAN])).toBe(0);
    expect(await prikljuciZavrseneIgre(db, id, uredjaj(), [DAN])).toBe(0);
    expect((await stanjeIgre(db, gost, DAN)).status).toBe("u_toku");
    // nalog koji je danas već igrao ne može da „pokupi” i gostujuću igru sa drugog uređaja
    const stari = await nalog("VecIgrao");
    await odigraj({ userId: stari, deviceId: uredjaj() }, DAN);
    const dev2 = uredjaj();
    await odigraj({ userId: null, deviceId: dev2 }, DAN);
    expect(await prikljuciZavrseneIgre(db, stari, dev2, [DAN])).toBe(0);
  });
});

describe("rang lista", () => {
  it("Danas: po poenima, pa po brzini; isti poeni i isto vreme dele mesto; bez korisničkog imena i „na čekanju” se ne vide", async () => {
    await pg.exec(`delete from public.play_answers; delete from public.plays;`);
    const a = await nalog("Ana");
    const b = await nalog("Bora");
    const c = await nalog("Ceca_fan");
    const d = await nalog("Dule");
    const bezImena = await nalog(null);
    const ceka = await nalog("Ceka", false);
    await gotovaIgra(a, DAN, 200, 90_000);
    await gotovaIgra(b, DAN, 250, 120_000);
    await gotovaIgra(c, DAN, 200, 80_000); // isto poena kao Ana, brži
    await gotovaIgra(d, DAN, 200, 90_000); // isto i poena i vreme kao Ana
    await gotovaIgra(bezImena, DAN, 340, 10_000);
    await gotovaIgra(ceka, DAN, 345, 10_000, "pending");

    const lista = await rangLista(db, "danas", DAN, a);
    expect(lista.map((r) => `${r.mesto}. ${r.username} ${r.poeni}`)).toEqual(["1. Bora 250", "2. Ceca_fan 200", "3. Ana 200", "3. Dule 200"]);
    expect(lista.find((r) => r.ja)?.username).toBe("Ana");
    expect(lista[1]).toMatchObject({ vremeMs: 80_000, igara: 1, ja: false });
    expect(await mestoNaListi(db, bezImena, DAN)).toBeNull();
  });

  it("Ova nedelja i Ukupno sabiraju dane; nedelja je ponedeljak–nedelja", async () => {
    const [a, b] = (await pg.query<{ id: string }>(`select id::text as id from public.profiles where username in ('Ana', 'Bora') order by username`)).rows.map((r) => r.id);
    await gotovaIgra(a, SUTRA, 300, 60_000); // nedelja, ista sedmica
    await gotovaIgra(b, PONEDELJAK, 100, 60_000); // sledeća sedmica
    expect(granicePerioda("nedelja", DAN)).toEqual({ od: "2026-11-09", do: "2026-11-15" });
    expect(granicePerioda("nedelja", PONEDELJAK)).toEqual({ od: "2026-11-16", do: "2026-11-22" });
    expect(granicePerioda("ukupno", DAN)).toEqual({ od: null, do: null });

    const nedelja = await rangLista(db, "nedelja", SUTRA, null);
    expect(nedelja.slice(0, 2).map((r) => `${r.mesto}. ${r.username} ${r.poeni} (${r.igara})`)).toEqual(["1. Ana 500 (2)", "2. Bora 250 (1)"]);
    const ukupno = await rangLista(db, "ukupno", SUTRA, null);
    expect(ukupno.slice(0, 2).map((r) => `${r.username} ${r.poeni}`)).toEqual(["Ana 500", "Bora 350"]);
    expect((await rangLista(db, "danas", PONEDELJAK, null)).map((r) => r.username)).toEqual(["Bora"]);
  });

  it("igrač vidi svoj red i kad nije u prvih 50", async () => {
    const dan = "2026-11-16";
    await pg.exec(`delete from public.plays where quiz_date = '${dan}'`);
    for (let i = 0; i < 55; i++) await gotovaIgra(await nalog(`igrac${String(i).padStart(2, "0")}`), dan, 300 - i, 60_000);
    const ja = await nalog("Poslednji");
    await gotovaIgra(ja, dan, 5, 60_000);
    const lista = await rangLista(db, "danas", dan, ja);
    expect(lista).toHaveLength(51);
    expect(lista[49]).toMatchObject({ mesto: 50, username: "igrac49" });
    expect(lista[50]).toMatchObject({ mesto: 56, username: "Poslednji", ja: true });
    expect(await rangLista(db, "danas", dan, null)).toHaveLength(50);
  });
});

describe("tekst za deljenje", () => {
  it("kvadratići po segmentima, poeni i adresa, bez ijednog odgovora", () => {
    const seg = (n: number, key: Stanje["segmenti"][number]["key"], tok: (0 | 1 | 2)[], poeni: number, max: number) =>
      ({ n, key, naziv: "", pravilo: "", pitanja: tok.length, odgovoreno: tok.length, poeni, tok, max, bonus: key === "joker" });
    const stanje: Stanje = {
      status: "zavrseno", datum: "2026-11-14", score: 187, maxUkupno: 350,
      segmenti: [seg(1, "pesma", [2, 1, 0, 2, 1], 60, 100), seg(2, "cena", [2, 0, 1, 0, 0, 2, 0, 0, 0, 2], 35, 100), seg(3, "gugla", [2, 2, 0, 2, 0, 2, 2, 0], 25, 40), seg(4, "film", [2, 0, 0], 20, 60), seg(5, "joker", [2], 50, 50)],
    };
    expect(tekstZaDeljenje(stanje)).toBe(
      ["Čik Pogodi! 14.11.2026.", "187/350", "🎵 🟩🟨⬛🟩🟨", "🛒 🟩⬛🟨⬛⬛🟩⬛⬛⬛🟩", "🔎 🟩🟩⬛🟩⬛🟩🟩⬛", "🎬 🟩⬛⬛", "🃏 🟩", "cikpogodi.online"].join("\n"),
    );
  });
});
