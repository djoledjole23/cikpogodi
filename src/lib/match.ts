/**
 * Tolerantno poređenje teksta (za „Pogodi pesmu” i kasnije „Pogodi film”):
 * ne gleda velika/mala slova ni kvačice (č/ć/š/ž/đ = c/s/z/dj), ćirilica je isto što i latinica,
 * a mala greška u kucanju prolazi. Radi i u browseru (pretraga kataloga) i na serveru (ocena).
 */

const CIRILICA: Record<string, string> = {
  а: "a", б: "b", в: "v", г: "g", д: "d", ђ: "dj", е: "e", ж: "z", з: "z", и: "i", ј: "j", к: "k", л: "l", љ: "lj",
  м: "m", н: "n", њ: "nj", о: "o", п: "p", р: "r", с: "s", т: "t", ћ: "c", у: "u", ф: "f", х: "h", ц: "c", ч: "c",
  џ: "dz", ш: "s",
};

/** „Đorđe Balašević – Ringišpil” → „djordje balasevic ringispil”. */
export function normalizuj(tekst: string): string {
  let s = tekst.toLowerCase();
  s = s.replace(/[а-џ]/g, (slovo) => CIRILICA[slovo] ?? slovo);
  s = s.replace(/đ/g, "dj");
  // č, ć, š, ž → c, c, s, z (slovo + kvačica se razdvoji, pa se kvačica obriše)
  s = s.normalize("NFD").replace(/[̀-ͯ]/g, "");
  // Apostrof se briše bez razmaka („dotak'o” = „dotako”), ostali znaci postaju razmak.
  s = s.replace(/['’`´]/g, "");
  s = s.replace(/[^a-z0-9]+/g, " ").trim();
  return s;
}

/** Broj izmena (dodato, obrisano ili zamenjeno slovo; zamena dva susedna slova je jedna izmena). */
export function razdaljina(a: string, b: string): number {
  if (a === b) return 0;
  const m = a.length;
  const n = b.length;
  if (!m) return n;
  if (!n) return m;
  let pretprosli: number[] = [];
  let prosli = Array.from({ length: n + 1 }, (_, j) => j);
  for (let i = 1; i <= m; i++) {
    const red = [i];
    for (let j = 1; j <= n; j++) {
      const cena = a[i - 1] === b[j - 1] ? 0 : 1;
      let v = Math.min(prosli[j] + 1, red[j - 1] + 1, prosli[j - 1] + cena);
      if (i > 1 && j > 1 && a[i - 1] === b[j - 2] && a[i - 2] === b[j - 1]) v = Math.min(v, pretprosli[j - 2] + 1);
      red.push(v);
    }
    pretprosli = prosli;
    prosli = red;
  }
  return prosli[n];
}

/** Koliko grešaka u kucanju se prašta za tekst te dužine (bez razmaka). */
export function dozvoljenoGresaka(duzina: number): number {
  return duzina < 5 ? 0 : duzina < 10 ? 1 : 2;
}

/** Da li je upisani tekst (praktično) isto što i neki od tačnih oblika. Razmaci se ne računaju. */
export function slicno(upisano: string, tacniOblici: string[]): boolean {
  const u = normalizuj(upisano).replace(/ /g, "");
  if (!u) return false;
  return tacniOblici.some((oblik) => {
    const t = normalizuj(oblik).replace(/ /g, "");
    if (!t) return false;
    if (Math.abs(t.length - u.length) > 2) return false;
    return razdaljina(u, t) <= dozvoljenoGresaka(t.length);
  });
}

export type StavkaKataloga = { id: number; izvodjac: string; naslov: string };

/** Šta igrač sme da ukuca da bi pogodio pesmu: naslov, „izvođač naslov”, „naslov izvođač” i dodatni oblici naslova. */
export function tacniObliciPesme(p: { izvodjac: string; naslov: string; alias?: string[] }): string[] {
  const naslovi = [p.naslov, ...(p.alias ?? [])];
  return naslovi.flatMap((n) => [n, `${p.izvodjac} ${n}`, `${n} ${p.izvodjac}`]);
}

/**
 * Pretraga kataloga dok igrač kuca: svaka ukucana reč mora da bude početak neke reči u „izvođač naslov”
 * (pa „cec kuk” nalazi „Ceca – Kukavica”). Ako tako nema ničega, traži se uz jednu grešku u kucanju po reči.
 * Prvo idu pesme kojima naslov počinje ukucanim tekstom.
 */
export function pretraziKatalog<T extends StavkaKataloga>(katalog: T[], upit: string, najvise = 6): T[] {
  const u = normalizuj(upit);
  if (!u) return [];
  const reci = u.split(" ");

  type Pripremljeno = { stavka: T; naslov: string; reci: string[] };
  const pripremljeno: Pripremljeno[] = katalog.map((stavka) => {
    const naslov = normalizuj(stavka.naslov);
    return { stavka, naslov, reci: `${normalizuj(stavka.izvodjac)} ${naslov}`.split(" ") };
  });

  const tacno = (p: Pripremljeno) => reci.every((r) => p.reci.some((x) => x.startsWith(r)));
  const priblizno = (p: Pripremljeno) =>
    reci.every((r) => p.reci.some((x) => x.startsWith(r) || (r.length >= 4 && razdaljina(r, x.slice(0, r.length)) <= 1)));

  let nadjeno = pripremljeno.filter(tacno);
  if (!nadjeno.length) nadjeno = pripremljeno.filter(priblizno);

  const rang = (p: Pripremljeno) => (p.naslov.startsWith(u) ? 0 : p.naslov.split(" ").some((x) => x.startsWith(reci[0])) ? 1 : 2);
  return nadjeno
    .map((p, i) => ({ p, i, r: rang(p) }))
    .sort((x, y) => x.r - y.r || x.i - y.i)
    .slice(0, najvise)
    .map((x) => x.p.stavka);
}
