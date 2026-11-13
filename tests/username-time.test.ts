import { describe, expect, it } from "vitest";
import { bezbedanNext, bezbedanNextIzAdrese } from "@/lib/auth-next";
import { imaPsovku, proveriKorisnickoIme } from "@/lib/username";
import { beogradskiDatum, dodajDane, formatOdbrojavanje, msDoPonoci, pocetakNedelje } from "@/lib/time";

describe("korisničko ime", () => {
  it.each(["cecko", "Žika_22", "Đole", "abc", "a".repeat(20), "Night_Rider", "Pikado", "Kurir99"])(
    "%s je u redu",
    (ime) => {
      expect(proveriKorisnickoIme(ime)).toBeNull();
    },
  );

  it.each([
    ["ab", "bar 3"],
    ["a".repeat(21), "najviše 20"],
    ["ima razmak", "Samo slova"],
    ["tačka.ime", "Samo slova"],
    ["admin", "rezervisano"],
    ["CikPogodi", "rezervisano"],
  ])("%s se odbija", (ime, deoPoruke) => {
    expect(proveriKorisnickoIme(ime)).toContain(deoPoruke);
  });

  it.each(["jebiga", "JeBaC", "j3b4c", "jeeeeebem", "pička", "PICKA_1", "kurac", "курац", "govnar"])(
    "psovka: %s",
    (ime) => {
      expect(imaPsovku(ime)).toBe(true);
    },
  );
});

describe("beogradsko vreme", () => {
  it("dan se menja u ponoć po Beogradu, ne po UTC", () => {
    // zima: Beograd = UTC+1
    expect(beogradskiDatum(new Date("2026-11-13T22:59:59Z"))).toBe("2026-11-13");
    expect(beogradskiDatum(new Date("2026-11-13T23:00:00Z"))).toBe("2026-11-14");
    // leto: Beograd = UTC+2
    expect(beogradskiDatum(new Date("2026-07-01T21:59:59Z"))).toBe("2026-07-01");
    expect(beogradskiDatum(new Date("2026-07-01T22:00:00Z"))).toBe("2026-07-02");
  });

  it("odbrojavanje do ponoći", () => {
    expect(msDoPonoci(new Date("2026-11-13T22:00:00Z"))).toBe(3600_000);
    expect(msDoPonoci(new Date("2026-11-13T23:00:00Z"))).toBe(24 * 3600_000);
    expect(msDoPonoci(new Date("2026-07-01T21:30:00Z"))).toBe(1800_000);
  });

  it("odbrojavanje na dan pomeranja sata", () => {
    // 25.10.2026. sat se vraća: dan traje 25 sati. U 00:00 po Beogradu (22:00 UTC, 24.10) do ponoći ima 25 h.
    expect(msDoPonoci(new Date("2026-10-24T22:00:00Z"))).toBe(25 * 3600_000);
    // 29.03.2026. sat ide unapred: dan traje 23 sata.
    expect(msDoPonoci(new Date("2026-03-28T23:00:00Z"))).toBe(23 * 3600_000);
  });

  it("nedelja počinje u ponedeljak", () => {
    expect(pocetakNedelje("2026-11-13")).toBe("2026-11-09"); // petak → ponedeljak
    expect(pocetakNedelje("2026-11-09")).toBe("2026-11-09");
    expect(pocetakNedelje("2026-11-15")).toBe("2026-11-09"); // nedelja
    expect(dodajDane("2026-12-31", 1)).toBe("2027-01-01");
  });

  it("format odbrojavanja", () => {
    expect(formatOdbrojavanje(3_723_000)).toBe("01:02:03");
    expect(formatOdbrojavanje(-5)).toBe("00:00:00");
  });
});

describe("preusmeravanje posle prijave", () => {
  it("dozvoljava samo putanje unutar sajta", () => {
    expect(bezbedanNext("/igra")).toBe("/igra");
    expect(bezbedanNext("https://zlo.rs")).toBe("/");
    expect(bezbedanNext("//zlo.rs")).toBe("/");
    expect(bezbedanNext("/\\zlo.rs")).toBe("/");
    expect(bezbedanNext(null, "/nalog")).toBe("/nalog");
  });

  it("puna adresa prolazi samo ako je naš sajt", () => {
    const sajt = "https://www.cikpogodi.rs";
    expect(bezbedanNextIzAdrese("https://www.cikpogodi.rs/igra?x=1", sajt)).toBe("/igra?x=1");
    expect(bezbedanNextIzAdrese("https://cikpogodi.rs/rang-lista", sajt)).toBe("/rang-lista");
    expect(bezbedanNextIzAdrese("https://cikpogodi.rs.zlo.com/igra", sajt)).toBe("/");
    expect(bezbedanNextIzAdrese("javascript:alert(1)", sajt)).toBe("/");
    expect(bezbedanNextIzAdrese("/nova-sifra", sajt)).toBe("/nova-sifra");
  });
});
