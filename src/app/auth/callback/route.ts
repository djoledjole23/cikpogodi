import { NextResponse, type NextRequest } from "next/server";
import { bezbedanNext } from "@/lib/auth";
import { supabasePodesen } from "@/lib/supabase/env";
import { createClient } from "@/lib/supabase/server";

/** Povratak sa Google/Apple prijave: menja jednokratni kod za sesiju. */
export async function GET(request: NextRequest) {
  const { searchParams } = request.nextUrl;
  const origin = (process.env.NEXT_PUBLIC_SITE_URL ?? request.nextUrl.origin).replace(/\/$/, "");
  const code = searchParams.get("code");
  const next = bezbedanNext(searchParams.get("next"));

  if (code && supabasePodesen()) {
    const supabase = await createClient();
    const { data, error } = await supabase.auth.exchangeCodeForSession(code);
    if (!error && data.user) {
      const { data: profil } = await supabase
        .from("profiles")
        .select("username")
        .eq("id", data.user.id)
        .maybeSingle();
      // Nalog preko Google/Apple nema korisničko ime dok ga igrač ne izabere.
      const cilj = profil?.username ? next : "/nalog";
      return NextResponse.redirect(`${origin}${cilj}`);
    }
  }
  return NextResponse.redirect(`${origin}/prijava?greska=oauth`);
}
