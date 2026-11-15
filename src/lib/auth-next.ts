/** Čiste funkcije za bezbedno preusmeravanje posle prijave (bez serverskih zavisnosti, da mogu da se testiraju). */

/** Dozvoli samo putanje unutar sajta („/igra”), nikad spoljne adrese. */
export function bezbedanNext(next: unknown, podrazumevano = "/"): string {
  if (typeof next !== "string") return podrazumevano;
  if (!next.startsWith("/") || next.startsWith("//") || next.includes("\\")) return podrazumevano;
  return next;
}

/**
 * Isto, ali prihvata i punu adresu ako pokazuje na ovaj sajt
 * (Supabase u mejlu šalje punu adresu, npr. https://cikpogodi.online/igra).
 */
export function bezbedanNextIzAdrese(next: unknown, origin: string, podrazumevano = "/"): string {
  if (typeof next !== "string" || !next) return podrazumevano;
  if (next.startsWith("/")) return bezbedanNext(next, podrazumevano);
  try {
    const cilj = new URL(next);
    const bezWww = (h: string) => h.replace(/^www\./, "");
    if (bezWww(cilj.host) === bezWww(new URL(origin).host)) {
      return bezbedanNext(cilj.pathname + cilj.search, podrazumevano);
    }
  } catch {
    // nije adresa
  }
  return podrazumevano;
}
