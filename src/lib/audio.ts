/**
 * Svež link ka zvaničnom klipu od 30 sekundi.
 * Prvo Deezer (polje `preview`), a ako ga tamo nema, iTunes; a ako ni jedan ID više nema klip, traži se po izvođaču i naslovu. Audio fajlovi se nigde ne čuvaju:
 * u bazi je samo ID pesme, a link (koji ističe) se uzima tek kad pesma treba da se pusti.
 */

import { normalizuj } from "@/lib/match";

type Kes = { url: string; vaziDo: number };
const kes = new Map<string, Kes>();
const NAJDUZE_U_KESU_MS = 10 * 60 * 1000;

/** Deezer linkovi nose rok trajanja u sebi (…exp=1794620000~…). Drži ih u kešu najviše do minut pre isteka. */
function vaziDo(url: string): number {
  const exp = /exp=(\d{9,})/.exec(url);
  const izLinka = exp ? Number(exp[1]) * 1000 - 60_000 : Infinity;
  return Math.min(Date.now() + NAJDUZE_U_KESU_MS, izLinka);
}

async function json(url: string): Promise<unknown> {
  const odgovor = await fetch(url, { cache: "no-store", signal: AbortSignal.timeout(6000) });
  if (!odgovor.ok) throw new Error(`${url}: ${odgovor.status}`);
  return odgovor.json();
}

async function saDeezera(id: number): Promise<string | null> {
  const podaci = (await json(`https://api.deezer.com/track/${id}`)) as { preview?: unknown };
  return typeof podaci.preview === "string" && podaci.preview.startsWith("https://") ? podaci.preview : null;
}

async function saItunesa(id: number): Promise<string | null> {
  const podaci = (await json(`https://itunes.apple.com/lookup?id=${id}`)) as { results?: { previewUrl?: unknown }[] };
  const url = podaci.results?.[0]?.previewUrl;
  return typeof url === "string" && url.startsWith("https://") ? url : null;
}

export type IzvorKlipa = { deezerId: number | null; itunesId: number | null; izvodjac?: string; naslov?: string };
export type NadjenKlip = { url: string; deezerId: number | null; itunesId: number | null; pretraga: boolean };

/** Isti izvođač (bar prvo ime iz „X & Y”) i naslov koji počinje istim rečima (dozvoljeno „(Live)” i sl. iza). */
function odgovara(trazeno: { izvodjac: string; naslov: string }, izvodjac: string, naslov: string): boolean {
  const prvi = normalizuj(trazeno.izvodjac.split(/,|&| feat\.? | i /i)[0] ?? "");
  const t = normalizuj(trazeno.naslov);
  return prvi.length > 0 && normalizuj(izvodjac).includes(prvi) && (normalizuj(naslov) === t || normalizuj(naslov).startsWith(t + " "));
}

/** Kad zapamćeni ID više nema klip (Deezer zna da skine pesmu), traži istu pesmu po izvođaču i naslovu. */
async function pretrazi(izvodjac: string, naslov: string): Promise<NadjenKlip | null> {
  const trazeno = { izvodjac, naslov };
  const q = encodeURIComponent(`${izvodjac} ${naslov}`);
  const dz = (await json(`https://api.deezer.com/search?q=${q}&limit=15`).catch(() => null)) as {
    data?: { id?: number; title?: string; preview?: string; readable?: boolean; artist?: { name?: string } }[];
  } | null;
  for (const r of dz?.data ?? []) {
    if (r.readable === false || typeof r.preview !== "string" || !r.preview.startsWith("https://")) continue;
    if (typeof r.id === "number" && odgovara(trazeno, r.artist?.name ?? "", r.title ?? "")) {
      return { url: r.preview, deezerId: r.id, itunesId: null, pretraga: true };
    }
  }
  const it = (await json(`https://itunes.apple.com/search?term=${q}&entity=song&limit=15`).catch(() => null)) as {
    results?: { trackId?: number; trackName?: string; artistName?: string; previewUrl?: string }[];
  } | null;
  for (const r of it?.results ?? []) {
    if (typeof r.previewUrl !== "string" || !r.previewUrl.startsWith("https://")) continue;
    if (typeof r.trackId === "number" && odgovara(trazeno, r.artistName ?? "", r.trackName ?? "")) {
      return { url: r.previewUrl, deezerId: null, itunesId: r.trackId, pretraga: true };
    }
  }
  return null;
}

/** Klip po zapamćenim ID-jevima, a ako njih više nema — po izvođaču i naslovu. Bez keša. */
export async function nadjiKlip(izvor: IzvorKlipa): Promise<NadjenKlip | null> {
  if (izvor.deezerId !== null) {
    const url = await saDeezera(izvor.deezerId).catch(() => null);
    if (url) return { url, deezerId: izvor.deezerId, itunesId: izvor.itunesId, pretraga: false };
  }
  if (izvor.itunesId !== null) {
    const url = await saItunesa(izvor.itunesId).catch(() => null);
    if (url) return { url, deezerId: izvor.deezerId, itunesId: izvor.itunesId, pretraga: false };
  }
  if (izvor.izvodjac && izvor.naslov) return pretrazi(izvor.izvodjac, izvor.naslov);
  return null;
}

export async function svezKlip(izvor: IzvorKlipa): Promise<string | null> {
  const kljuc = `${izvor.deezerId ?? ""}:${izvor.itunesId ?? ""}:${izvor.izvodjac ?? ""}:${izvor.naslov ?? ""}`;
  const izKesa = kes.get(kljuc);
  if (izKesa && izKesa.vaziDo > Date.now()) return izKesa.url;

  const nadjen = await nadjiKlip(izvor);
  if (nadjen) kes.set(kljuc, { url: nadjen.url, vaziDo: vaziDo(nadjen.url) });
  return nadjen?.url ?? null;
}
