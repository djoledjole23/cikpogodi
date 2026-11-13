import { TIME_ZONE } from "@/config/quiz.config";

const fmtDatum = new Intl.DateTimeFormat("en-CA", {
  timeZone: TIME_ZONE,
  year: "numeric",
  month: "2-digit",
  day: "2-digit",
});

const fmtDelovi = new Intl.DateTimeFormat("en-GB", {
  timeZone: TIME_ZONE,
  hourCycle: "h23",
  weekday: "short",
  hour: "2-digit",
  minute: "2-digit",
  second: "2-digit",
});

/** Današnji datum kviza po beogradskom vremenu, kao „YYYY-MM-DD”. */
export function beogradskiDatum(sad: Date = new Date()): string {
  return fmtDatum.format(sad);
}

/** Koliko milisekundi ima do sledeće ponoći u Beogradu (radi i kad se pomera sat). */
export function msDoPonoci(sad: Date = new Date()): number {
  const delovi = Object.fromEntries(fmtDelovi.formatToParts(sad).map((d) => [d.type, d.value]));
  const proteklo =
    (Number(delovi.hour) * 3600 + Number(delovi.minute) * 60 + Number(delovi.second)) * 1000 +
    sad.getMilliseconds();
  let ostalo = 24 * 3600 * 1000 - proteklo;
  // Na dan pomeranja sata dan traje 23 ili 25 sati: proveri i ispravi.
  for (let i = 0; i < 3; i++) {
    const cilj = new Date(sad.getTime() + ostalo);
    const d = Object.fromEntries(fmtDelovi.formatToParts(cilj).map((x) => [x.type, x.value]));
    const odPonoci = (Number(d.hour) * 3600 + Number(d.minute) * 60 + Number(d.second)) * 1000;
    if (odPonoci === 0) break;
    // posle ponoći smo → vrati se; pre ponoći smo (23:xx) → dodaj
    ostalo += odPonoci < 12 * 3600 * 1000 ? -odPonoci : 24 * 3600 * 1000 - odPonoci;
  }
  return Math.max(0, ostalo);
}

/** Pomeri „YYYY-MM-DD” za zadati broj dana. */
export function dodajDane(datum: string, dana: number): string {
  const [g, m, d] = datum.split("-").map(Number);
  const dt = new Date(Date.UTC(g, m - 1, d + dana));
  return dt.toISOString().slice(0, 10);
}

/** Ponedeljak nedelje u kojoj je zadati datum (nedelja = pon–ned). */
export function pocetakNedelje(datum: string): string {
  const [g, m, d] = datum.split("-").map(Number);
  const dan = new Date(Date.UTC(g, m - 1, d)).getUTCDay(); // 0 = nedelja
  const odPonedeljka = (dan + 6) % 7;
  return dodajDane(datum, -odPonedeljka);
}

/** „07:04:09” za odbrojavanje. */
export function formatOdbrojavanje(ms: number): string {
  const s = Math.max(0, Math.floor(ms / 1000));
  const hh = String(Math.floor(s / 3600)).padStart(2, "0");
  const mm = String(Math.floor((s % 3600) / 60)).padStart(2, "0");
  const ss = String(s % 60).padStart(2, "0");
  return `${hh}:${mm}:${ss}`;
}
