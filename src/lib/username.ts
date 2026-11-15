import { KORISNICKO_IME } from "@/config/quiz.config";

/** Isti obrazac kao check u bazi (profiles.username_format). */
export const USERNAME_REGEX = /^[A-Za-z0-9_ČĆŠŽĐčćšžđ]{3,20}$/;

/**
 * Osnovni filter psovki. Koreni su bez kvačica i malim slovima;
 * ime se pre poređenja svodi na isti oblik (kvačice, ćirilica, „l33t”, ponovljena slova).
 */
const ZABRANJENI_KORENI = [
  "jeb",
  "kurac",
  "kurc",
  "kurv",
  "picka",
  "picke",
  "picki",
  "picko",
  "picku",
  "pizd",
  "sranj",
  "seronj",
  "govn",
  "supak",
  "supcin",
  "drkadz",
  "drkos",
  "drkam",
  "peder",
  "pedercin",
  "siptar",
  "ciganin",
  "cigancic",
  "ustas",
  "balij",
  "nacist",
  "hitler",
  "silovat",
  "siluj",
  "pedofil",
  "kopile",
  "djubre",
  "smrad",
  "debil",
  "retard",
  "kreten",
  "mamicu",
  "materin",
  "fuck",
  "shit",
  "bitch",
  "nigg",
  "cunt",
  "whore",
  "porn",
  "sex",
];

/** Imena koja bi mogla da zavaraju druge igrače. */
const REZERVISANA = [
  "admin",
  "administrator",
  "moderator",
  "cikpogodi",
  "cik_pogodi",
  "podrska",
  "support",
  "sistem",
  "system",
  "root",
  "null",
  "undefined",
  "gost",
  "anonimus",
];

const CIRILICA: Record<string, string> = {
  а: "a", б: "b", в: "v", г: "g", д: "d", ђ: "dj", е: "e", ж: "z", з: "z", и: "i",
  ј: "j", к: "k", л: "l", љ: "lj", м: "m", н: "n", њ: "nj", о: "o", п: "p", р: "r",
  с: "s", т: "t", ћ: "c", у: "u", ф: "f", х: "h", ц: "c", ч: "c", џ: "dz", ш: "s",
};

const LEET: Record<string, string> = {
  "0": "o", "1": "i", "3": "e", "4": "a", "5": "s", "7": "t", "8": "b", "@": "a", $: "s",
};

/** Svede ime na oblik za poređenje sa spiskom: bez kvačica, bez „l33t”, bez razmaka i crtica. */
export function oblikZaFilter(ime: string): string {
  let s = ime.toLowerCase();
  s = Array.from(s, (c) => CIRILICA[c] ?? c).join("");
  s = s.replace(/đ/g, "dj");
  s = s.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
  s = Array.from(s, (c) => LEET[c] ?? c).join("");
  return s.replace(/[^a-z]/g, "");
}

const imaDuplaSlova = (s: string) => /(.)\1/.test(s);

export function imaPsovku(ime: string): boolean {
  const s = oblikZaFilter(ime);
  // „jeeeeb” → „jeb”. Koreni sa duplim slovom (npr. „nigg”) porede se samo sa nesažetim oblikom,
  // da „night” ne bi ispao psovka.
  const sazeto = s.replace(/(.)\1+/g, "$1");
  return ZABRANJENI_KORENI.some((k) => s.includes(k) || (!imaDuplaSlova(k) && sazeto.includes(k)));
}

export function jeRezervisano(ime: string): boolean {
  const s = ime.toLowerCase();
  const bez = oblikZaFilter(ime);
  return REZERVISANA.some((r) => s === r || bez === r.replace(/[^a-z]/g, ""));
}

/** Vraća poruku greške na srpskom ili null ako je ime u redu. */
export function proveriKorisnickoIme(ime: string): string | null {
  const s = ime.trim();
  if (s.length < KORISNICKO_IME.min) return `Ime mora da ima bar ${KORISNICKO_IME.min} znaka.`;
  if (s.length > KORISNICKO_IME.max) return `Ime može da ima najviše ${KORISNICKO_IME.max} znakova.`;
  if (!USERNAME_REGEX.test(s)) return "Samo slova, brojevi i donja crta, bez razmaka.";
  if (jeRezervisano(s)) return "To ime je rezervisano. Smisli nešto svoje.";
  if (imaPsovku(s)) return "Ajde bez psovki u imenu, gledaju i deca.";
  return null;
}

/**
 * Interna adresa naloga. Igrač se prijavljuje nadimkom i šifrom, a Supabase iznutra traži mejl,
 * pa se on pravi od nadimka. Nikad se ne prikazuje i na njega se ništa ne šalje.
 * Dva nadimka koja se razlikuju samo po kvačicama ili veličini slova daju istu adresu — to su isti nalog.
 */
export const DOMEN_NALOGA = "nalozi.cikpogodi.rs";

/** Nadimak sveden na mala latinična slova, brojeve i donju crtu. */
export function kljucImena(ime: string): string {
  let s = ime.trim().toLowerCase();
  s = Array.from(s, (c) => CIRILICA[c] ?? c).join("");
  s = s.replace(/\u0111/g, "dj");
  s = s.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
  return s.replace(/[^a-z0-9_]/g, "");
}

export const mejlZaIme = (ime: string) => `${kljucImena(ime)}@${DOMEN_NALOGA}`;
