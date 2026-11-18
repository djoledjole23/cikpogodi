import { describe, it, expect } from "vitest";
import { ocistiUnosCene, procitajCenu } from "@/lib/format";

describe("unos cene", () => {
  it("zarez je decimalni, ne briše se", () => {
    expect(ocistiUnosCene("249,99")).toBe("249,99");
    expect(procitajCenu("249,99")).toBeCloseTo(249.99);
    expect(procitajCenu("2,5")).toBeCloseTo(2.5);
  });
  it("tačka sa tri cifre je hiljada, sa jednom ili dve je decimala", () => {
    expect(procitajCenu("1.299")).toBe(1299);
    expect(procitajCenu("1.299,50")).toBeCloseTo(1299.5);
    expect(procitajCenu("249.99")).toBeCloseTo(249.99);
    expect(procitajCenu("300")).toBe(300);
  });
  it("najviše dve decimale, jedan zarez, bez slova i vodećih nula", () => {
    expect(ocistiUnosCene("ab-2,5.0e3")).toBe("2,50");
    expect(ocistiUnosCene("12,345")).toBe("12,34");
    expect(ocistiUnosCene("007")).toBe("7");
    expect(ocistiUnosCene("1234567")).toBeNull();
  });
  it("prazno i besmisleno nije broj", () => {
    expect(procitajCenu("")).toBeNaN();
    expect(procitajCenu("1.2.3")).toBeNaN();
  });
});
