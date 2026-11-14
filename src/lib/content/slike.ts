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
