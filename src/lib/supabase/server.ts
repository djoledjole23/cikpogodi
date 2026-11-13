import "server-only";
import { createServerClient } from "@supabase/ssr";
import { createClient as createSupabaseClient } from "@supabase/supabase-js";
import { cookies } from "next/headers";
import { SUPABASE_PUBLISHABLE_KEY, SUPABASE_URL, supabasePodesen } from "./env";

/** Klijent vezan za kolačiće trenutnog posetioca (poštuje RLS). */
export async function createClient() {
  const cookieStore = await cookies();
  return createServerClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, {
    cookies: {
      getAll() {
        return cookieStore.getAll();
      },
      setAll(cookiesToSet) {
        try {
          cookiesToSet.forEach(({ name, value, options }) => cookieStore.set(name, value, options));
        } catch {
          // Pozvano iz Server Component-a, gde kolačići ne mogu da se upišu.
          // Nije problem: sesiju osvežava proxy.ts.
        }
      },
    },
  });
}

/**
 * Klijent sa tajnim ključem: zaobilazi RLS. Samo za serverski kod koji je već proverio ko pita.
 * Nikad ga ne uvozi u klijentske komponente.
 */
export function createAdminClient() {
  const secret = process.env.SUPABASE_SECRET_KEY ?? "";
  if (!supabasePodesen() || !secret) {
    throw new Error("SUPABASE_SECRET_KEY nije podešen.");
  }
  return createSupabaseClient(SUPABASE_URL, secret, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}

export function adminPodesen(): boolean {
  return supabasePodesen() && Boolean(process.env.SUPABASE_SECRET_KEY);
}
