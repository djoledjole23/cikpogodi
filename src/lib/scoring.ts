import {
  CENA_PRAGOVI,
  FILM_POENI,
  GUGLA_POENI,
  PESMA_PRAGOVI,
  JOKER_POENI,
} from "@/config/quiz.config";

/** Pesma: poeni po ukupnom preslušanom vremenu. Netačno ili prekoračen klip = 0. */
export function poeniPesma(tacno: boolean, preslusanoMs: number): number {
  if (!tacno || !Number.isFinite(preslusanoMs) || preslusanoMs < 0) return 0;
  const ms = Math.round(preslusanoMs);
  for (const prag of PESMA_PRAGOVI) {
    if (ms <= prag.doMs) return prag.poeni;
  }
  return 0;
}

/**
 * Cena: odstupanje = |unos − tačna| / tačna.
 * Računa se u celim parama da 10,0% ne bi ispalo 10,000000001% zbog decimala.
 */
export function odstupanjeCena(unos: number, tacna: number): number | null {
  if (!Number.isFinite(unos) || !Number.isFinite(tacna) || tacna <= 0 || unos < 0) return null;
  const u = Math.round(unos * 100);
  const t = Math.round(tacna * 100);
  return Math.abs(u - t) / t;
}

export function poeniCena(unos: number, tacna: number): number {
  if (!Number.isFinite(unos) || !Number.isFinite(tacna) || tacna <= 0 || unos < 0) return 0;
  const u = Math.round(unos * 100);
  const t = Math.round(tacna * 100);
  const razlika = Math.abs(u - t);
  for (const prag of CENA_PRAGOVI) {
    // razlika / t <= prag / 100, bez deljenja
    if (razlika * 100 <= prag.doProcenata * t) return prag.poeni;
  }
  return 0;
}

/**
 * Odstupanje za prikaz: „+10%”, „−13%”, „u dinar”.
 * Zaokružuje se na ceo procenat, osim kad bi to zavaralo oko praga:
 * 15,07% donosi 0 poena, pa ne sme da piše „+15%” (prag je 15). Tada ide jedna decimala naviše: „+15,1%”.
 */
export function procenatZaPrikaz(unos: number, tacna: number): string {
  if (!Number.isFinite(unos) || !Number.isFinite(tacna) || tacna <= 0) return "";
  if (unos === tacna) return "u dinar";
  const znak = unos > tacna ? "+" : "−";
  const p = (Math.abs(unos - tacna) / tacna) * 100;
  if (p >= 1000) return `${znak}999% i više`;

  const ceo = Math.round(p);
  const prag = CENA_PRAGOVI.find((x) => x.doProcenata === ceo);
  if (prag && p > prag.doProcenata) {
    // preko praga, a zaokruženo bi palo tačno na njega
    const desetine = Math.max(Math.ceil(p * 10), prag.doProcenata * 10 + 1);
    return `${znak}${(desetine / 10).toFixed(1).replace(".", ",")}%`;
  }
  if (ceo === 0) return `${znak}manje od 1%`;
  return `${znak}${ceo}%`;
}

export const poeniGugla = (tacno: boolean) => (tacno ? GUGLA_POENI : 0);
export const poeniFilm = (tacno: boolean) => (tacno ? FILM_POENI : 0);
export const poeniJoker = (tacno: boolean) => (tacno ? JOKER_POENI : 0);
