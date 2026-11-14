/**
 * Čitanje data/joker.json: Joker pitanja (segment 5, bonus).
 * Jedno pitanje po danu, vezano za datum. Igrač kuca odgovor; fotografija i broj se vide tek posle odgovora.
 */
import { normalizuj } from "@/lib/match";

export type Joker = {
  /** Dan kviza (YYYY-MM-DD) za koji je pitanje. */
  datum: string;
  pitanje: string;
  odgovor: string;
  /** Drugi oblici odgovora koji se priznaju („Anthony”). */
  alias: string[];
  /** Fotografija koja se prikaže posle odgovora, npr. /joker/9f2c….webp. */
  slika: string | null;
  /** Veliki broj (ili kratka reč) koji „iskoči” posle odgovora, i natpis ispod njega. */
  broj: string | null;
  natpis: string | null;
};

export type UcitaniJokeri = { pitanja: Joker[]; izbaceni: { naziv: string; razlog: string }[] };

const jeTekst = (x: unknown): x is string => typeof x === "string" && x.trim().length > 0;

/** `postojeceSlike`: adrese fajlova koji stvarno postoje u public/ (ako se prosledi, slika bez fajla se ne koristi). */
export function ucitajJokere(json: unknown, postojeceSlike?: ReadonlySet<string>): UcitaniJokeri {
  const koren = json as { pitanja?: unknown };
  if (!koren || !Array.isArray(koren.pitanja)) throw new Error("joker.json: fali niz „pitanja”.");

  const pitanja: Joker[] = [];
  const izbaceni: UcitaniJokeri["izbaceni"] = [];
  const dani = new Set<string>();
  for (const red of koren.pitanja as Record<string, unknown>[]) {
    if (!jeTekst(red.pitanje) || !jeTekst(red.odgovor)) throw new Error("joker.json: pitanje bez teksta ili bez odgovora.");
    if (!jeTekst(red.datum) || !/^\d{4}-\d{2}-\d{2}$/.test(red.datum)) throw new Error(`joker.json: „${red.pitanje}” nema datum u obliku YYYY-MM-DD.`);
    if (dani.has(red.datum)) throw new Error(`joker.json: za ${red.datum} postoje dva pitanja.`);
    dani.add(red.datum);

    const alias = Array.isArray(red.alias) ? (red.alias as unknown[]).filter(jeTekst) : [];
    let slika: string | null = null;
    if (jeTekst(red.slika)) {
      if (!red.slika.startsWith("/")) throw new Error(`joker.json: slika za ${red.datum} mora da počinje sa „/”.`);
      // Ime fajla ne sme da sadrži odgovor (ni reč iz odgovora dužu od 3 slova): adresa se vidi u browseru.
      const ime = normalizuj(red.slika.split("/").pop() ?? "");
      const reci = [red.odgovor, ...alias].flatMap((o) => normalizuj(o).split(" "));
      if (reci.some((rec) => rec.length > 3 && ime.includes(rec))) throw new Error(`joker.json: adresa slike za ${red.datum} odaje odgovor.`);
      if (postojeceSlike && !postojeceSlike.has(red.slika)) izbaceni.push({ naziv: red.pitanje, razlog: "fotografije nema u public/ (pitanje ostaje, bez slike)" });
      else slika = red.slika;
    }
    const otkrice = (red.otkrice ?? {}) as { broj?: unknown; natpis?: unknown };
    pitanja.push({
      datum: red.datum,
      pitanje: red.pitanje.trim(),
      odgovor: red.odgovor.trim(),
      alias,
      slika,
      broj: jeTekst(otkrice.broj) ? otkrice.broj.trim() : typeof otkrice.broj === "number" ? String(otkrice.broj) : null,
      natpis: jeTekst(otkrice.natpis) ? otkrice.natpis.trim() : null,
    });
  }
  return { pitanja: pitanja.sort((a, b) => a.datum.localeCompare(b.datum)), izbaceni };
}
