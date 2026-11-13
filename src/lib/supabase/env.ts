/** Čitanje Supabase podešavanja. Bez ključeva sajt i dalje radi, samo bez naloga i rang liste. */

export const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL ?? "";
export const SUPABASE_PUBLISHABLE_KEY = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY ?? "";

export function supabasePodesen(): boolean {
  return SUPABASE_URL.startsWith("http") && SUPABASE_PUBLISHABLE_KEY.length > 0;
}

export const PORUKA_NIJE_PODESENO =
  "Nalozi još nisu povezani (fale Supabase ključevi). Pogledaj README, deo „Supabase”.";
