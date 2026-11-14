/**
 * Čitanje data/films.json: kadrovi za „Pogodi domaći film/seriju”.
 * Film bez fotografije se izbacuje. Adresa fotografije ne sme da odaje naslov.
 */
import { normalizuj } from "@/lib/match";

export type Film = {
  naslov: string;
  /** Kraći ili drugačiji oblici naslova koji se takođe priznaju („Maratonci”). */
  alias: string[];
  /** Adresa kadra na sajtu, npr. /kadrovi/9f2c….webp */
  slika: string;
};

export type UcitaniFilmovi = { filmovi: Film[]; izbaceni: { naziv: string; razlog: string }[] };

const jeTekst = (x: unknown): x is string => typeof x === "string" && x.trim().length > 0;

/** `postojeceSlike`: adrese fajlova koji stvarno postoje u public/ (ako se prosledi, film bez fajla ispada). */
export function ucitajFilmove(json: unknown, postojeceSlike?: ReadonlySet<string>): UcitaniFilmovi {
  const koren = json as { filmovi?: unknown };
  if (!koren || !Array.isArray(koren.filmovi)) throw new Error("films.json: fali niz „filmovi”.");

  const filmovi: Film[] = [];
  const izbaceni: UcitaniFilmovi["izbaceni"] = [];
  const vidjeni = new Set<string>();
  for (const red of koren.filmovi as Record<string, unknown>[]) {
    if (!jeTekst(red.naslov)) throw new Error("films.json: film bez naslova.");
    const kljuc = normalizuj(red.naslov);
    if (vidjeni.has(kljuc)) throw new Error(`films.json: „${red.naslov}” se javlja dvaput.`);
    vidjeni.add(kljuc);
    if (!jeTekst(red.slika) || !red.slika.startsWith("/")) { izbaceni.push({ naziv: red.naslov, razlog: "nema fotografiju" }); continue; }
    if (postojeceSlike && !postojeceSlike.has(red.slika)) { izbaceni.push({ naziv: red.naslov, razlog: "fotografije nema u public/" }); continue; }
    // Ime fajla ne sme da sadrži naslov (ni deo naslova duži od 3 slova): igrač vidi adresu slike.
    const ime = normalizuj(red.slika.split("/").pop() ?? "");
    if (kljuc.split(" ").some((rec) => rec.length > 3 && ime.includes(rec))) {
      throw new Error(`films.json: adresa fotografije za „${red.naslov}” odaje naslov.`);
    }
    filmovi.push({ naslov: red.naslov, alias: Array.isArray(red.alias) ? (red.alias as unknown[]).filter(jeTekst) : [], slika: red.slika });
  }
  return { filmovi, izbaceni };
}
