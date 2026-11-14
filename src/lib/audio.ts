/**
 * Svež link ka zvaničnom klipu od 30 sekundi.
 * Prvo Deezer (polje `preview`), a ako ga tamo nema, iTunes. Audio fajlovi se nigde ne čuvaju:
 * u bazi je samo ID pesme, a link (koji ističe) se uzima tek kad pesma treba da se pusti.
 */

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

export async function svezKlip(izvor: { deezerId: number | null; itunesId: number | null }): Promise<string | null> {
  const kljuc = `${izvor.deezerId ?? ""}:${izvor.itunesId ?? ""}`;
  const izKesa = kes.get(kljuc);
  if (izKesa && izKesa.vaziDo > Date.now()) return izKesa.url;

  let url: string | null = null;
  if (izvor.deezerId !== null) url = await saDeezera(izvor.deezerId).catch(() => null);
  if (!url && izvor.itunesId !== null) url = await saItunesa(izvor.itunesId).catch(() => null);
  if (url) kes.set(kljuc, { url, vaziDo: vaziDo(url) });
  return url;
}
