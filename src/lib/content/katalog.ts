import { normalizuj } from "@/lib/match";

/**
 * Spisak pesama za biranje odgovora u „Pogodi pesmu”.
 *
 * Sastoji se od pesama koje se puštaju (tabela songs) i od nekoliko hiljada dodatnih iz data/katalog.json,
 * koje se nikad ne puštaju i služe samo da izbor bude težak: ko ukuca izvođača vidi desetine njegovih pesama.
 * Browser ne dobija nikakav znak koja je od njih u kvizu.
 */

/** [izvođač, naslovi] */
export type GrupaKataloga = [string, string[]];

export function ucitajKatalog(json: unknown): GrupaKataloga[] {
  const koren = json as { izvodjaci?: unknown };
  if (!koren || !Array.isArray(koren.izvodjaci)) throw new Error("katalog.json: fali niz „izvodjaci”.");
  return (koren.izvodjaci as unknown[]).map((g) => {
    const [izvodjac, naslovi] = g as [unknown, unknown];
    if (typeof izvodjac !== "string" || !izvodjac.trim() || !Array.isArray(naslovi) || !naslovi.every((n) => typeof n === "string" && n.trim())) {
      throw new Error("katalog.json: grupa mora da bude [izvođač, [naslovi]].");
    }
    return [izvodjac, naslovi as string[]];
  });
}

const poAzbuci = new Intl.Collator("sr-Latn");

/**
 * Pesme iz baze + dodatne iz kataloga, složene po izvođaču pa po naslovu.
 * Ako se ista pesma nađe na oba mesta (isti izvođač i naslov, bez obzira na kvačice), ostaje jednom,
 * napisana onako kako je u bazi.
 */
export function spojiKatalog(izBaze: { artist: string; title: string }[], dodatne: GrupaKataloga[]): GrupaKataloga[] {
  const grupe = new Map<string, { izvodjac: string; naslovi: Map<string, string> }>();
  const dodaj = (izvodjac: string, naslov: string) => {
    const k = normalizuj(izvodjac);
    let g = grupe.get(k);
    if (!g) grupe.set(k, (g = { izvodjac, naslovi: new Map() }));
    const kn = normalizuj(naslov);
    if (kn && !g.naslovi.has(kn)) g.naslovi.set(kn, naslov);
  };
  for (const p of izBaze) dodaj(p.artist, p.title);
  for (const [izvodjac, naslovi] of dodatne) for (const n of naslovi) dodaj(izvodjac, n);
  return [...grupe.values()]
    .map((g): GrupaKataloga => [g.izvodjac, [...g.naslovi.values()].sort(poAzbuci.compare)])
    .sort((a, b) => poAzbuci.compare(a[0], b[0]));
}
