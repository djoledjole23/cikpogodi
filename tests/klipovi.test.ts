import { afterEach, describe, expect, it, vi } from "vitest";
import { nadjiKlip } from "@/lib/audio";

const odg = (body: unknown) => ({ ok: true, status: 200, json: async () => body }) as Response;

afterEach(() => vi.unstubAllGlobals());

describe("klip kad Deezer skine pesmu", () => {
  it("bez klipa po ID-ju traži istu pesmu po izvođaču i naslovu (prihvata „(Live)”)", async () => {
    vi.stubGlobal("fetch", vi.fn(async (url: string) => {
      if (url.includes("/track/")) return odg({ preview: "" });
      if (url.includes("deezer.com/search")) return odg({ data: [
        { id: 1, title: "Halo", preview: "https://x/1.mp3", artist: { name: "Severina" } },
        { id: 595573712, title: "Gas Gas (Live)", preview: "https://x/2.mp3", readable: true, artist: { name: "Severina" } },
      ] });
      return odg({ results: [] });
    }));
    const k = await nadjiKlip({ deezerId: 66239087, itunesId: null, izvodjac: "Severina", naslov: "Gas, gas" });
    expect(k).toEqual({ url: "https://x/2.mp3", deezerId: 595573712, itunesId: null, pretraga: true });
  });

  it("drugi izvođač sa istim naslovom se ne prihvata", async () => {
    vi.stubGlobal("fetch", vi.fn(async (url: string) => {
      if (url.includes("deezer.com/search")) return odg({ data: [{ id: 5, title: "Tango", preview: "https://x/5.mp3", artist: { name: "Neko drugi" } }] });
      return odg({ results: [] });
    }));
    expect(await nadjiKlip({ deezerId: null, itunesId: null, izvodjac: "Voyage", naslov: "Tango" })).toBeNull();
  });

  it("ispravan ID se koristi bez pretrage", async () => {
    const f = vi.fn(async () => odg({ preview: "https://x/ok.mp3" }));
    vi.stubGlobal("fetch", f);
    expect(await nadjiKlip({ deezerId: 7, itunesId: null, izvodjac: "A", naslov: "B" })).toMatchObject({ url: "https://x/ok.mp3", pretraga: false });
    expect(f).toHaveBeenCalledTimes(1);
  });
});
