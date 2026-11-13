import type { EmailOtpType } from "@supabase/supabase-js";
import { NextResponse, type NextRequest } from "next/server";
import { bezbedanNextIzAdrese } from "@/lib/auth";
import { supabasePodesen } from "@/lib/supabase/env";
import { createClient } from "@/lib/supabase/server";

const DOZVOLJENI: EmailOtpType[] = ["signup", "email", "recovery", "email_change", "invite", "magiclink"];

/** Link iz mejla (potvrda naloga, nova šifra): proverava token i prijavljuje korisnika. */
export async function GET(request: NextRequest) {
  const { searchParams } = request.nextUrl;
  const origin = (process.env.NEXT_PUBLIC_SITE_URL ?? request.nextUrl.origin).replace(/\/$/, "");
  const tokenHash = searchParams.get("token_hash");
  const type = searchParams.get("type") as EmailOtpType | null;
  const next = bezbedanNextIzAdrese(searchParams.get("next"), origin, type === "recovery" ? "/nova-sifra" : "/");

  if (tokenHash && type && DOZVOLJENI.includes(type) && supabasePodesen()) {
    const supabase = await createClient();
    const { error } = await supabase.auth.verifyOtp({ type, token_hash: tokenHash });
    if (!error) return NextResponse.redirect(`${origin}${next}`);
  }
  return NextResponse.redirect(`${origin}/prijava?greska=link`);
}
