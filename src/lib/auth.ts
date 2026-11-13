import "server-only";
import { cookies } from "next/headers";
import { cache } from "react";
import { createClient } from "./supabase/server";
import { supabasePodesen } from "./supabase/env";

export type Igrac = {
  id: string;
  email: string | null;
  username: string | null;
  mejlPotvrdjen: boolean;
};

/**
 * Ko je ulogovan (ili null). Čita kolačiće, pa mora da stoji iza <Suspense>.
 * `cache` znači: jedno čitanje po zahtevu, ma koliko komponenti pitalo.
 */
export const getIgrac = cache(async (): Promise<Igrac | null> => {
  if (!supabasePodesen()) return null;
  // Van try/catch, iz istog razloga kao u lib/plays.ts: prekid tokom prerendera mora da prođe do Reacta.
  await cookies();
  try {
    const supabase = await createClient();
    const { data, error } = await supabase.auth.getUser();
    if (error || !data.user) return null;
    const { data: profil } = await supabase
      .from("profiles")
      .select("username")
      .eq("id", data.user.id)
      .maybeSingle();
    return {
      id: data.user.id,
      email: data.user.email ?? null,
      username: profil?.username ?? null,
      mejlPotvrdjen: Boolean(data.user.email_confirmed_at),
    };
  } catch {
    return null;
  }
});

export { bezbedanNext, bezbedanNextIzAdrese } from "./auth-next";
