import { describe, expect, it } from "vitest";
import { odstupanjeCena, poeniCena, poeniPesma, procenatZaPrikaz } from "@/lib/scoring";
import { MAX_UKUPNO, SEGMENTI } from "@/config/quiz.config";

describe("pesma", () => {
  it.each([
    [0, 20],
    [1999, 20],
    [2000, 20], // tačno 2,0 s
    [2001, 15],
    [4000, 15], // tačno 4,0 s
    [4001, 10],
    [6000, 10], // tačno 6,0 s
    [6001, 5],
    [30000, 5], // kraj klipa
    [30001, 0],
  ])("preslušano %i ms → %i poena", (ms, poeni) => {
    expect(poeniPesma(true, ms)).toBe(poeni);
  });

  it("netačno je uvek 0", () => {
    expect(poeniPesma(false, 500)).toBe(0);
  });

  it("nemoguće vrednosti su 0", () => {
    expect(poeniPesma(true, -1)).toBe(0);
    expect(poeniPesma(true, Number.NaN)).toBe(0);
  });
});

describe("cena", () => {
  it.each([
    [172, 172, 10],
    [189.2, 172, 10], // tačno +10%
    [154.8, 172, 10], // tačno −10%
    [189.21, 172, 5], // malo preko 10%
    [197.8, 172, 5], // tačno +15%
    [146.2, 172, 5], // tačno −15%
    [197.81, 172, 0], // malo preko 15%
    [0, 172, 0],
    [110, 100, 10], // tačno 10% na okruglom broju
    [115, 100, 5], // tačno 15%
    [116, 100, 0],
    [80.29, 72.99, 5], // 7,30 / 72,99 = 10,0014%: za dlaku preko
    [80.28, 72.99, 10], // 7,29 / 72,99 = 9,99%
  ])("unos %d, prava %d → %i poena", (unos, tacna, poeni) => {
    expect(poeniCena(unos, tacna)).toBe(poeni);
  });

  it("decimale ne kvare granicu od tačno 10%", () => {
    expect(poeniCena(87.98, 79.98)).toBe(5); // 8,00 / 79,98 = 10,0025%
    expect(poeniCena(87.97, 79.98)).toBe(10); // 7,99 / 79,98 = 9,99%
    expect(poeniCena(33, 30)).toBe(10); // 3 / 30 = tačno 10%
    expect(poeniCena(0.3, 0.27)).toBe(5); // 0,03 / 0,27 = 11,1%
  });

  it("besmislen unos je 0", () => {
    expect(poeniCena(-5, 100)).toBe(0);
    expect(poeniCena(Number.NaN, 100)).toBe(0);
    expect(poeniCena(100, 0)).toBe(0);
  });

  it("odstupanje i prikaz", () => {
    expect(odstupanjeCena(189, 172)).toBeCloseTo(0.0988, 3);
    expect(procenatZaPrikaz(189, 172)).toBe("+10%"); // 9,88%: u pragu, 10 poena
    expect(procenatZaPrikaz(150, 172)).toBe("−13%");
    expect(procenatZaPrikaz(172, 172)).toBe("u dinar");
    expect(procenatZaPrikaz(173, 172)).toBe("+1%");
    expect(procenatZaPrikaz(1001, 1000)).toBe("+manje od 1%");
    expect(procenatZaPrikaz(999999, 147)).toBe("+999% i više");
  });

  it("prikaz ne sme da protivreči poenima oko praga", () => {
    // 542 / 471 = +15,07% → 0 poena, pa ne sme da piše +15%
    expect(poeniCena(542, 471)).toBe(0);
    expect(procenatZaPrikaz(542, 471)).toBe("+15,1%");
    // 106 / 96 = +10,42% → 5 poena, pa ne sme da piše +10%
    expect(poeniCena(106, 96)).toBe(5);
    expect(procenatZaPrikaz(106, 96)).toBe("+10,5%");
    // 2001 / 1819 = +10,005%: zaokruženo na desetinu bi opet bilo 10,0
    expect(poeniCena(2001, 1819)).toBe(5);
    expect(procenatZaPrikaz(2001, 1819)).toBe("+10,1%");
    // tačno na pragu ostaje ceo broj
    expect(procenatZaPrikaz(220, 200)).toBe("+10%");
    expect(procenatZaPrikaz(85, 100)).toBe("−15%");
    // 14,6% je u pragu od 15 → 5 poena i „+15%” se slažu
    expect(poeniCena(1146, 1000)).toBe(5);
    expect(procenatZaPrikaz(1146, 1000)).toBe("+15%");
  });
});

describe("config", () => {
  it("zbir segmenata je 300 + 50 = 350", () => {
    const osnovno = SEGMENTI.filter((s) => !s.bonus).reduce((z, s) => z + s.max, 0);
    const bonus = SEGMENTI.filter((s) => s.bonus).reduce((z, s) => z + s.max, 0);
    expect(osnovno).toBe(300);
    expect(bonus).toBe(50);
    expect(MAX_UKUPNO).toBe(350);
    expect(SEGMENTI.reduce((z, s) => z + s.pitanja, 0)).toBe(27); // 26 pitanja + 1 Joker
  });
});
