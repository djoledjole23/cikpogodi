import { describe, expect, it } from "vitest";
import { kolikoIgralo } from "@/lib/padezi";

describe("koliko je ljudi danas igralo", () => {
  it.each([
    [5, "Danas je igralo 5 ljudi."],
    [11, "Danas je igralo 11 ljudi."],
    [12, "Danas je igralo 12 ljudi."],
    [14, "Danas je igralo 14 ljudi."],
    [21, "Danas je igrao 21 čovek."],
    [22, "Danas su igrala 22 čoveka."],
    [24, "Danas su igrala 24 čoveka."],
    [25, "Danas je igralo 25 ljudi."],
    [111, "Danas je igralo 111 ljudi."],
    [112, "Danas je igralo 112 ljudi."],
    [101, "Danas je igrao 101 čovek."],
    [103, "Danas su igrala 103 čoveka."],
  ])("%i → %s", (n, ocekivano) => {
    expect(kolikoIgralo(n)).toBe(ocekivano);
  });
});
