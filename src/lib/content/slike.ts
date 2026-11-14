import { existsSync, readdirSync } from "node:fs";
import { join } from "node:path";

/**
 * Sopstvene fotografije artikala: fajlovi u public/artikli/ nazvani po barkodu
 * (npr. public/artikli/8600043000023.jpg). Kad takav fajl postoji, igra koristi njega
 * umesto slike sa Open Food Facts. Artikal koji u products.json nema sliku, a ovde je ima, ulazi u igru.
 */
const NASTAVCI = /\.(webp|avif|png|jpe?g)$/i;

export function sopstveneSlike(koren: string = process.cwd()): Map<string, string> {
  const dir = join(koren, "public", "artikli");
  const slike = new Map<string, string>();
  if (!existsSync(dir)) return slike;
  for (const fajl of readdirSync(dir).sort()) {
    if (!NASTAVCI.test(fajl)) continue;
    const barkod = fajl.replace(NASTAVCI, "");
    // Ako ima više formata za isti barkod, važi prvi po abecedi (avif, jpg, png, webp).
    if (!slike.has(barkod)) slike.set(barkod, `/artikli/${fajl}`);
  }
  return slike;
}

/** Adrese kadrova koji postoje u public/kadrovi (npr. „/kadrovi/9f2c….webp”). */
export function postojeciKadrovi(koren: string = process.cwd()): Set<string> {
  const dir = join(koren, "public", "kadrovi");
  if (!existsSync(dir)) return new Set();
  return new Set(readdirSync(dir).filter((f) => NASTAVCI.test(f)).map((f) => `/kadrovi/${f}`));
}

/** Adrese fotografija za Joker pitanja koje postoje u public/joker (npr. „/joker/9f2c….webp”). */
export function postojeceSlikeJokera(koren: string = process.cwd()): Set<string> {
  const dir = join(koren, "public", "joker");
  if (!existsSync(dir)) return new Set();
  return new Set(readdirSync(dir).filter((f) => NASTAVCI.test(f)).map((f) => `/joker/${f}`));
}
