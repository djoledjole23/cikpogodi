/**
 * Čitanje products.json (cene iz zvaničnih cenovnika lanaca, data.gov.rs).
 * Pravilo: artikal bez slike ili bez cene se izbacuje. Cena se nikad ne izmišlja ni ne dopunjava.
 */

export type Proizvod = {
  barkod: string;
  naziv: string;
  kolicina: string;
  kategorija: string;
  /** Prosek preko lanaca, zaokružen na dinar. Ovo je „prava cena” u igri. */
  cena: number;
  /** Isti prosek, na pare. */
  cenaTacna: number;
  cenaMin: number;
  cenaMax: number;
  najjeftinijeU: string;
  brojLanaca: number;
  slika: string;
};

export type UcitaniProizvodi = {
  datumCenovnika: string;
  proizvodi: Proizvod[];
  /** Šta je izbačeno i zašto, za izveštaj. */
  izbaceni: { naziv: string; razlog: string }[];
};

const jeBroj = (x: unknown): x is number => typeof x === "number" && Number.isFinite(x);
const jeTekst = (x: unknown): x is string => typeof x === "string" && x.trim().length > 0;

export function ucitajProizvode(json: unknown): UcitaniProizvodi {
  const koren = json as { datum_cenovnika?: unknown; proizvodi?: unknown };
  if (!koren || !Array.isArray(koren.proizvodi)) throw new Error("products.json: fali niz „proizvodi”.");
  if (!jeTekst(koren.datum_cenovnika) || !/^\d{4}-\d{2}-\d{2}$/.test(koren.datum_cenovnika)) {
    throw new Error("products.json: fali „datum_cenovnika” u obliku YYYY-MM-DD.");
  }

  const proizvodi: Proizvod[] = [];
  const izbaceni: UcitaniProizvodi["izbaceni"] = [];
  const vidjeni = new Set<string>();

  for (const red of koren.proizvodi as Record<string, unknown>[]) {
    const naziv = jeTekst(red.naziv) ? red.naziv.trim() : "(bez naziva)";
    const izbaci = (razlog: string) => izbaceni.push({ naziv: `${naziv} ${jeTekst(red.kolicina) ? red.kolicina : ""}`.trim(), razlog });

    if (!jeTekst(red.barkod)) { izbaci("nema barkod"); continue; }
    if (vidjeni.has(red.barkod)) { izbaci("dupli barkod"); continue; }
    if (!jeTekst(red.naziv) || !jeTekst(red.kolicina)) { izbaci("nema naziv ili gramažu"); continue; }
    if (!jeBroj(red.cena_rsd) || red.cena_rsd <= 0 || !jeBroj(red.cena_tacna) || red.cena_tacna <= 0) { izbaci("nema cenu"); continue; }
    if (!jeTekst(red.slika_url) || !red.slika_url.startsWith("https://")) { izbaci("nema sliku"); continue; }
    if (!jeBroj(red.cena_min) || !jeBroj(red.cena_max) || red.cena_min > red.cena_tacna || red.cena_max < red.cena_tacna) {
      izbaci("opseg cena nije ispravan"); continue;
    }
    if (Math.round(red.cena_tacna) !== red.cena_rsd) { izbaci("zaokružena cena se ne slaže sa tačnom"); continue; }

    vidjeni.add(red.barkod);
    proizvodi.push({
      barkod: red.barkod,
      naziv: red.naziv.trim(),
      kolicina: red.kolicina.trim(),
      kategorija: jeTekst(red.kategorija) ? red.kategorija.trim() : "Ostalo",
      cena: red.cena_rsd,
      cenaTacna: red.cena_tacna,
      cenaMin: red.cena_min,
      cenaMax: red.cena_max,
      najjeftinijeU: jeTekst(red.najjeftinije_u) ? red.najjeftinije_u.trim() : "",
      brojLanaca: jeBroj(red.broj_lanaca) ? red.broj_lanaca : 0,
      slika: red.slika_url,
    });
  }

  return { datumCenovnika: koren.datum_cenovnika, proizvodi, izbaceni };
}
