/**
 * Čitanje data/songs.json: katalog pesama za „Pogodi pesmu”.
 *
 * U igru (i u katalog za biranje odgovora) ulaze samo pesme kojima je na Deezeru potvrđen
 * zvanični klip od 30 sekundi. Deezer ID se ne izmišlja: pesma bez njega se izbacuje.
 */

export const ZANROVI = ["folk", "rok", "pop", "trep"] as const;
export type Zanr = (typeof ZANROVI)[number];

export type Pesma = {
  /** Kako se prikazuje: „Jala Brat & Buba Corelli”. */
  izvodjac: string;
  /** Svi izvođači pojedinačno (da se isti izvođač ne javi dvaput u danu). */
  izvodjaci: string[];
  naslov: string;
  /** Drugi oblici naslova koji se priznaju kad igrač kuca. */
  alias: string[];
  zanr: Zanr;
  deezerId: number;
  itunesId: number | null;
  /** Omot albuma (Deezer). */
  omot: string;
  /** Pesma sa spiska koji je sastavio vlasnik sajta: ide u kviz pre ostalih. */
  prioritet: boolean;
};

export type UcitanePesme = {
  provereno: string;
  pesme: Pesma[];
  izbaceni: { naziv: string; razlog: string }[];
};

const jeTekst = (x: unknown): x is string => typeof x === "string" && x.trim().length > 0;
const jeId = (x: unknown): x is number => typeof x === "number" && Number.isInteger(x) && x > 0;

export function ucitajPesme(json: unknown): UcitanePesme {
  const koren = json as { datum_provere?: unknown; pesme?: unknown };
  if (!koren || !Array.isArray(koren.pesme)) throw new Error("songs.json: fali niz „pesme”.");
  if (!jeTekst(koren.datum_provere) || !/^\d{4}-\d{2}-\d{2}$/.test(koren.datum_provere)) {
    throw new Error("songs.json: fali „datum_provere” u obliku YYYY-MM-DD.");
  }

  const pesme: Pesma[] = [];
  const izbaceni: UcitanePesme["izbaceni"] = [];
  const vidjeni = new Set<number>();

  for (const red of koren.pesme as Record<string, unknown>[]) {
    if (!jeTekst(red.izvodjac) || !jeTekst(red.naslov)) throw new Error("songs.json: pesma bez izvođača ili naslova.");
    const naziv = `${red.izvodjac} – ${red.naslov}`;
    if (!ZANROVI.includes(red.zanr as Zanr)) throw new Error(`songs.json: „${naziv}” ima nepoznat žanr.`);
    if (!jeId(red.deezer_id)) { izbaceni.push({ naziv, razlog: "nema potvrđen klip na Deezeru" }); continue; }
    if (!jeTekst(red.omot) || !red.omot.startsWith("https://")) { izbaceni.push({ naziv, razlog: "nema omot" }); continue; }
    if (vidjeni.has(red.deezer_id)) throw new Error(`songs.json: Deezer ID ${red.deezer_id} se javlja dvaput („${naziv}”).`);
    vidjeni.add(red.deezer_id);

    const izvodjaci = Array.isArray(red.izvodjaci) && red.izvodjaci.every(jeTekst) && red.izvodjaci.length ? (red.izvodjaci as string[]) : [red.izvodjac];
    pesme.push({
      izvodjac: red.izvodjac,
      izvodjaci,
      naslov: red.naslov,
      alias: Array.isArray(red.alias) ? (red.alias as unknown[]).filter(jeTekst) : [],
      zanr: red.zanr as Zanr,
      deezerId: red.deezer_id,
      itunesId: jeId(red.itunes_id) ? red.itunes_id : null,
      omot: red.omot,
      prioritet: red.prioritet === true,
    });
  }
  return { provereno: koren.datum_provere, pesme, izbaceni };
}
