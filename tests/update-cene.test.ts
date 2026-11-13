import { describe, expect, it } from "vitest";
import { broj, dekodiraj, izracunaj, normBarkod, normDatum, procitajCenovnik } from "../scripts/update-cene.mjs";

/**
 * Skripta ne može da se proba protiv pravih servera iz testova, pa se ovde proverava sve
 * osim same mreže: čitanje CSV-a u oba kodiranja i oblika, i računanje proseka.
 */
const trazeni = new Set(["8600043000023", "86006675"]);

const LIDL = [
  "Naziv kategorije;Naziv proizvoda;Robna marka;Barkod;Jedinica mere;Redovna cena;Snižena cena;Vrsta;Datum cenovnika",
  "Slatkiši;Plazma keks 300g;Bambi;8600043000023;kom;279,99;249,99;VAZECI_CENOVNIK;13-11-2026",
  "Slatkiši;Bananica 25g;Štark;0000086006675;kom;24,99;;VAZECI_CENOVNIK;13-11-2026",
  "Slatkiši;Plazma keks 300g;Bambi;8600043000023;kom;199,99;;PRESEK_01_10;01-10-2026",
  "Piće;Nešto treće;Xy;1234567890123;kom;1.234,56;;VAZECI_CENOVNIK;13-11-2026",
].join("\r\n");

const MAXI = [
  '"naziv proizvoda","robna marka","barkod","redovna cena","datum cenovnika"',
  '"Plazma keks, 300g","Bambi","8600043000023","289.99","2026-11-13"',
  '"Plazma keks, 300g","Bambi","8600043000023","284.39","2026-11-13"',
  '"Bananica","Stark","86006675","25.99","2026-11-13"',
].join("\n");

describe("čitanje cenovnika", () => {
  it("tačka-zarez, zarez kao decimala, samo važeći cenovnik, redovna a ne snižena cena", () => {
    const r = procitajCenovnik(LIDL, trazeni);
    expect(r.datum).toBe("2026-11-13");
    expect(r.cene.get("8600043000023")).toEqual([279.99]); // ni akcijska (249,99) ni stari presek (199,99)
    expect(r.cene.get("86006675")).toEqual([24.99]); // vodeće nule u barkodu
    expect(r.cene.has("1234567890123")).toBe(false);
  });

  it("zarez kao separator, navodnici, tačka kao decimala, više objekata istog lanca", () => {
    const r = procitajCenovnik(MAXI, trazeni);
    expect(r.cene.get("8600043000023")).toEqual([289.99, 284.39]);
    expect(r.datum).toBe("2026-11-13");
  });

  it("windows-1250 se prepoznaje", () => {
    // „Snižena cena” i „Štark” u windows-1250: š=0x9A, ž=0x9E, Š=0x8A
    const zaglavlje = "Naziv proizvoda;Barkod;Redovna cena;Sni\u009Eena cena\n";
    const bajtovi = Uint8Array.from([...zaglavlje, ..."\u008Atark bananica;86006675;24,99;\n".repeat(30)].map((c) => c.charCodeAt(0)));
    const tekst = dekodiraj(bajtovi);
    expect(tekst).toContain("Štark bananica");
    expect(procitajCenovnik(tekst, trazeni).cene.get("86006675")!.length).toBe(30);
  });

  it("fajl koji nije cenovnik se odbija, ne pogađa se", () => {
    expect(() => procitajCenovnik("a;b;c\n1;2;3", trazeni)).toThrow(/barkod/);
    expect(() => procitajCenovnik("", trazeni)).toThrow();
  });

  it("brojevi, barkodovi, datumi", () => {
    expect(broj("1.234,56")).toBe(1234.56);
    expect(broj("1234.56")).toBe(1234.56);
    expect(broj("289,9")).toBe(289.9);
    expect(broj("")).toBeNaN();
    expect(normBarkod(" 0000086006675 ")).toBe("86006675");
    expect(normDatum("13-11-2026")).toBe("2026-11-13");
    expect(normDatum("3.1.2027.")).toBe("2027-01-03");
    expect(normDatum("2026-11-13T00:00:00")).toBe("2026-11-13");
    expect(normDatum("juče")).toBeNull();
  });
});

describe("računanje", () => {
  const stari = [
    { id: "8600043000023", barkod: "8600043000023", naziv: "Plazma keks", kolicina: "300 g", kategorija: "Slatkiši", cena_rsd: 289, cena_tacna: 288.56, slika_url: "https://x/p.jpg" },
    { id: "86006675", barkod: "86006675", naziv: "Štark Bananica", kolicina: "25 g", kategorija: "Slatkiši", cena_rsd: 27, cena_tacna: 27.19, slika_url: null },
  ];
  const lanci = {
    Lidl: procitajCenovnik(LIDL, trazeni).cene,
    Maxi: procitajCenovnik(MAXI, trazeni).cene,
    Idea: new Map([["8600043000023", [294.99]]]),
  };

  it("prvo prosek unutar lanca, pa prosek između lanaca; min, max i najjeftiniji lanac", () => {
    const { proizvodi, izbaceni } = izracunaj(stari, lanci, { minLanaca: 3 });
    expect(proizvodi.length).toBe(1);
    const p = proizvodi[0];
    // Lidl 279,99 · Maxi (289,99 + 284,39) / 2 = 287,19 · Idea 294,99 → prosek 287,39
    expect(p.cene_po_lancima).toEqual({ Lidl: 279.99, Maxi: 287.19, Idea: 294.99 });
    expect(p.cena_tacna).toBe(287.39);
    expect(p.cena_rsd).toBe(287);
    expect(p.cena_min).toBe(279.99);
    expect(p.cena_max).toBe(294.99);
    expect(p.najjeftinije_u).toBe("Lidl");
    expect(p.broj_lanaca).toBe(3);
    expect(p.slika_url).toBe("https://x/p.jpg");
    // Bananica je samo u 2 lanca: izbacuje se, cena se ne dopunjava starom
    expect(izbaceni).toEqual([{ naziv: "Štark Bananica 25 g", razlog: "nađen u 2 lanaca (treba bar 3)" }]);
  });

  it("sumnjiv skok cene se izbacuje umesto da uđe u igru", () => {
    const skup = { A: new Map([["8600043000023", [900]]]), B: new Map([["8600043000023", [910]]]), C: new Map([["8600043000023", [905]]]) };
    const { proizvodi, izbaceni } = izracunaj(stari.slice(0, 1), skup, { minLanaca: 3, najveciSkok: 40 });
    expect(proizvodi.length).toBe(0);
    expect(izbaceni[0].razlog).toMatch(/skočila/);
  });
});
