/** Čitanje Supabase podešavanja. Bez ključeva sajt i dalje radi, samo bez naloga i rang liste. */

/**
 * Supabase u svom „Connect” prozoru ispisuje red pod imenom NEXT_PUBLIC_SUPABASE_ANON_KEY,
 * a ponegde i ...PUBLISHABLE_DEFAULT_KEY. Priznajemo sva tri imena, pa kopiranje iz Supabase-a
 * radi bez preimenovanja. (Imena moraju da stoje doslovno: Next ih ugrađuje u vreme builda.)
 */
export const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL ?? "";
export const SUPABASE_PUBLISHABLE_KEY =
  process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY ||
  process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_DEFAULT_KEY ||
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ||
  "";

export function supabasePodesen(): boolean {
  return SUPABASE_URL.startsWith("http") && SUPABASE_PUBLISHABLE_KEY.length > 0;
}

/** Šta tačno fali, za poruku u konzoli (ne ide igračima). */
export function staFaliSupabase(): string | null {
  if (supabasePodesen()) return null;
  const fali: string[] = [];
  if (!SUPABASE_URL.startsWith("http")) fali.push("NEXT_PUBLIC_SUPABASE_URL");
  if (!SUPABASE_PUBLISHABLE_KEY) fali.push("NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY (ili ...ANON_KEY)");
  return fali.join(" i ");
}

export const PORUKA_NIJE_PODESENO =
  "Nalozi još nisu povezani (fale Supabase ključevi). Pogledaj README, deo „Supabase”.";
