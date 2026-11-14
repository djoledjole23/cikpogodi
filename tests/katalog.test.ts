/**
 * Širi spisak pesama za biranje odgovora u „Pogodi pesmu” (data/katalog.json):
 * mora da bude veliki, a nijedna dodatna pesma ne sme da se sudari sa pesmom koja se pušta.
 */
import { readFileSync } from "node:fs";
import { join } from "node:path";
import { describe, expect, it } from "vitest";
import { spojiKatalog, ucitajKatalog } from "@/lib/content/katalog";
import { ucitajPesme } from "@/lib/content/songs";
import { nadjiUKatalogu, normalizuj, slicno } from "@/lib/match";

const json = (ime: string) => JSON.parse(readFileSync(join(process.cwd(), "data", ime), "utf8"));
const dodatne = ucitajKatalog(json("katalog.json"));
const { pesme } = ucitajPesme(json("songs.json"));
const ceo = spojiKatalog(pesme.map((p) => ({ artist: p.izvodjac, title: p.naslov })), dodatne);
const ravno = ceo.flatMap(([izvodjac, naslovi]) => naslovi.map((naslov) => ({ izvodjac, naslov })));
const ljudi = (izvodjac: string) => izvodjac.split(/, | & /).map(normalizuj);

describe("spisak pesama za biranje", () => {
  it("ima više hiljada pesama i stotine izvođača", () => {
    expect(dodatne.flatMap((g) => g[1]).length).toBeGreaterThan(5000);
    expect(ravno.length).toBeGreaterThan(5000 + 160);
    expect(ceo.length).toBeGreaterThan(500);
    for (const [izvodjac, naslovi] of dodatne) {
      expect(izvodjac.trim()).toBe(izvodjac);
      for (const n of naslovi) {
        expect(n.length, n).toBeGreaterThan(1);
        expect(n.length, n).toBeLessThan(45);
        expect(/[([\]]|\bfeat\b|\blive\b|remix/i.test(n), n).toBe(false);
      }
    }
  });

  it("nijedna dodatna pesma nije ista (ni skoro ista) kao pesma koja se pušta, pa je tačan odgovor samo jedan", () => {
    const sudari: string[] = [];
    for (const p of pesme) {
      const moji = p.izvodjaci.map(normalizuj);
      const oblici = [p.naslov, ...p.alias];
      for (const [izvodjac, naslovi] of dodatne) {
        if (!ljudi(izvodjac).some((x) => moji.includes(x))) continue;
        for (const n of naslovi) if (slicno(n, oblici) || slicno(p.naslov, [n])) sudari.push(`${izvodjac} – ${n}  ~  ${p.izvodjac} – ${p.naslov}`);
      }
    }
    expect(sudari).toEqual([]);
  });

  it("ko ukuca izvođača iz kviza vidi mnogo pesama, a ne samo onu koja se pušta", () => {
    const malo: string[] = [];
    for (const ime of new Set(pesme.flatMap((p) => p.izvodjaci))) {
      const broj = nadjiUKatalogu(ravno, ime, 4).ukupno;
      if (broj < 8) malo.push(`${ime}: ${broj}`);
    }
    // Izvođači sa kratkom diskografijom na Deezeru (malo ih je, i svi imaju bar nekoliko pesama).
    expect(malo.length, malo.join(", ")).toBeLessThanOrEqual(3);
    const ceca = nadjiUKatalogu(ravno, "ceca", 4);
    expect(ceca.ukupno).toBeGreaterThan(25);
    expect(ceca.stavke).toHaveLength(4);
    expect(nadjiUKatalogu(ravno, "ceca kuk", 4).stavke[0]).toEqual({ izvodjac: "Ceca", naslov: "Kukavica" });
    // isti naslov kod više izvođača: spisak ne odaje koji je „pravi”
    expect(nadjiUKatalogu(ravno, "kukavica", 10).stavke.length).toBeGreaterThan(1);
  });

  it("spajanje: pesma iz baze i ista iz spiska ostaju jednom, napisana kao u bazi, i sve je po azbuci", () => {
    const spojeno = spojiKatalog(
      [{ artist: "Šaban Šaulić", title: "Dođi da ostarimo zajedno" }, { artist: "Ceca", title: "Kukavica" }],
      [["Saban Saulic", ["Dodji da ostarimo zajedno", "Bojana"]], ["Aca Lukas", ["Lična karta"]], ["ceca", ["Beograd"]]],
    );
    expect(spojeno).toEqual([
      ["Aca Lukas", ["Lična karta"]],
      ["Ceca", ["Beograd", "Kukavica"]],
      ["Šaban Šaulić", ["Bojana", "Dođi da ostarimo zajedno"]],
    ]);
    // u celom spisku nema duplikata
    expect(new Set(ravno.map((s) => normalizuj(`${s.izvodjac}|${s.naslov}`))).size).toBe(ravno.length);
  });

  it("loš fajl se odbija", () => {
    expect(() => ucitajKatalog({})).toThrow();
    expect(() => ucitajKatalog({ izvodjaci: [["Ceca", "Kukavica"]] })).toThrow();
    expect(() => ucitajKatalog({ izvodjaci: [["", ["Kukavica"]]] })).toThrow();
  });
});
