import { describe, it, expect } from "vitest";
import { PROBNA_IMENA } from "@/lib/db/local";
import { USERNAME_REGEX } from "@/lib/username";
describe("probna imena", () => {
  it("100 jedinstvenih, ispravnih imena", () => {
    expect(PROBNA_IMENA.length).toBe(100);
    expect(new Set(PROBNA_IMENA.map((x) => x.toLowerCase())).size).toBe(100);
    for (const ime of PROBNA_IMENA) expect(ime, ime).toMatch(USERNAME_REGEX);
  });
});
