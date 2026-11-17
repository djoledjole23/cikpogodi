import { describe, it, expect } from "vitest";
import { IMENA_BOTOVA as PROBNA_IMENA } from "@/lib/game/botovi";
import { USERNAME_REGEX, imaPsovku } from "@/lib/username";
describe("probna imena", () => {
  it("500 jedinstvenih, ispravnih imena", () => {
    expect(PROBNA_IMENA.length).toBe(500);
    expect(new Set(PROBNA_IMENA.map((x) => x.toLowerCase())).size).toBe(500);
    for (const ime of PROBNA_IMENA) {
      expect(ime, ime).toMatch(USERNAME_REGEX);
      expect(imaPsovku(ime), ime).toBe(false);
    }
  });
});

import { botoviZaDan, listaSaBotovima, BOT_POENI_OD, BOT_POENI_DO } from "@/lib/game/botovi";

describe("botovi", () => {
  it("isti dan, isti poeni; u dozvoljenom rasponu", () => {
    const a = botoviZaDan("2026-11-17");
    expect(a).toEqual(botoviZaDan("2026-11-17"));
    for (const b of a) {
      expect(b.poeni).toBeGreaterThanOrEqual(BOT_POENI_OD);
      expect(b.poeni).toBeLessThanOrEqual(BOT_POENI_DO);
    }
  });
  it("poeni su raznoliki: nijedan broj poena nema više od 3 bota", () => {
    const brojac = new Map<number, number>();
    for (const b of botoviZaDan("2026-11-17")) brojac.set(b.poeni, (brojac.get(b.poeni) ?? 0) + 1);
    expect(Math.max(...brojac.values())).toBeLessThanOrEqual(3);
    expect(botoviZaDan("2026-11-17")[0].ime).not.toBe(botoviZaDan("2026-11-18")[0].ime);
  });
  it("mesta: botovi i ljudi zajedno, ljudi ispred kod istog broja poena", () => {
    const botovi = [{ ime: "b1", poeni: 100, vremeMs: 1 }, { ime: "b2", poeni: 80, vremeMs: 1 }];
    const pravi = [
      { mesto: 1, poeni: 200, ja: false },
      { mesto: 2, poeni: 80, ja: true },
      { mesto: 3, poeni: 10, ja: false },
    ];
    const { vrh } = listaSaBotovima(pravi, botovi, 50);
    expect(vrh.map((r) => [r.bot, r.mesto, r.red.poeni])).toEqual([
      [false, 1, 200], [true, 2, 100], [false, 3, 80], [true, 4, 80], [false, 5, 10],
    ]);
    const { vrh: mali, ja } = listaSaBotovima(pravi, botovi, 2);
    expect(mali).toHaveLength(2);
    expect(ja).toMatchObject({ mesto: 3 });
  });
});
