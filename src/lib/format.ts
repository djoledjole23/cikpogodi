/** „1.104” – cele dinare sa tačkom za hiljade. */
export function broj(n: number): string {
  return Math.round(n)
    .toString()
    .replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

/** „1.104 din” */
export const din = (n: number) => `${broj(n)} din`;

/**
 * Šta igrač sme da ukuca u polje za cenu: cifre, tačke (hiljade ili decimale) i jedan zarez sa najviše
 * dve decimale. Vraća null kad unos ima previše cifara, pa polje zadrži staru vrednost.
 * Ranije se zarez brisao, pa je od „249,99” ostajalo 24999.
 */
export function ocistiUnosCene(tekst: string, najviseCifara = 6): string | null {
  const s = tekst.replace(/[^\d.,]/g, "");
  const zarez = s.indexOf(",");
  const celi = (zarez === -1 ? s : s.slice(0, zarez)).replace(/^[0.]+(?=\d)/, "");
  if (celi.replace(/\D/g, "").length > najviseCifara) return null;
  if (zarez === -1) return celi;
  return `${celi},${s.slice(zarez + 1).replace(/\D/g, "").slice(0, 2)}`;
}

/**
 * Pretvara unos iz polja za cenu u broj dinara. Zarez je decimalni („249,99” → 249,99).
 * Tačka iza koje stoje tačno tri cifre je razdvajač hiljada („1.299” → 1299),
 * a tačka sa jednom ili dve cifre iza je decimalna („249.99” → 249,99). Vraća NaN za prazan unos.
 */
export function procitajCenu(tekst: string): number {
  const s = tekst.trim();
  if (!s) return NaN;
  const [celi, decimale = ""] = s.split(",");
  let ceo = celi;
  if (/^\d{1,3}(\.\d{3})+$/.test(ceo)) ceo = ceo.replace(/\./g, "");
  const broj = Number(`${ceo || "0"}${decimale ? `.${decimale}` : ""}`);
  return Number.isFinite(broj) ? broj : NaN;
}
