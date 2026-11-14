import type { SegmentKey } from "@/config/quiz.config";
import type { Stanje } from "./types";

/**
 * Tekst za dugme „Podeli”, kao kod Wordle-a: kvadratići po segmentima, poeni i adresa.
 * Bez spojlera: vidi se samo šta je pogođeno, ne i koja su bila pitanja.
 * (Emoji su ovde sadržaj poruke koju igrač šalje, ne ikonice u interfejsu.)
 */
const ZNAK: Record<SegmentKey, string> = { pesma: "🎵", cena: "🛒", gugla: "🔎", film: "🎬", joker: "🃏" };
const KVADRAT = ["⬛", "🟨", "🟩"] as const;

export function tekstZaDeljenje(stanje: Stanje, adresa = "cikpogodi.rs"): string {
  const [g, m, d] = stanje.datum.split("-").map(Number);
  const max = stanje.segmenti.reduce((z, s) => z + s.max, 0);
  const redovi = stanje.segmenti.map((s) => `${ZNAK[s.key]} ${s.tok.map((t) => KVADRAT[t]).join("")}`);
  return [`Čik Pogodi! ${d}.${m}.${g}.`, `${stanje.score}/${max}`, ...redovi, adresa].join("\n");
}
