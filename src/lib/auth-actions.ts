"use server";

import type { AuthError } from "@supabase/supabase-js";
import { headers } from "next/headers";
import { redirect } from "next/navigation";
import { SIFRA_MIN } from "@/config/quiz.config";
import { bezbedanNext } from "@/lib/auth";
import { PORUKA_NIJE_PODESENO, supabasePodesen } from "@/lib/supabase/env";
import { adminPodesen, createAdminClient, createClient } from "@/lib/supabase/server";
import { proveriKorisnickoIme } from "@/lib/username";

export type StanjeForme = {
  /** Greška za celu formu. */
  greska?: string;
  /** Greške po poljima (ključ = name polja). */
  polja?: Record<string, string>;
  /** Šta je korisnik uneo, da ne kuca ponovo posle greške (šifre se ne vraćaju). */
  vrednosti?: Record<string, string>;
  /** Poruka o uspehu. */
  ok?: string;
};

const MEJL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;

function tekst(formData: FormData, polje: string): string {
  const v = formData.get(polje);
  return typeof v === "string" ? v.trim() : "";
}

async function adresaSajta(): Promise<string> {
  const izEnv = process.env.NEXT_PUBLIC_SITE_URL;
  if (izEnv) return izEnv.replace(/\/$/, "");
  const h = await headers();
  const host = h.get("x-forwarded-host") ?? h.get("host") ?? "localhost:3000";
  const proto = h.get("x-forwarded-proto") ?? (host.startsWith("localhost") ? "http" : "https");
  return `${proto}://${host}`;
}

function porukaGreske(error: AuthError): string {
  switch (error.code) {
    case "invalid_credentials":
      return "Pogrešan mejl ili šifra. Probaj opet.";
    case "email_not_confirmed":
      return "Mejl još nije potvrđen. Klikni na link koji smo ti poslali (baci pogled i u spam).";
    case "user_already_exists":
    case "email_exists":
      return "Nalog sa tim mejlom već postoji. Prijavi se.";
    case "weak_password":
      return `Šifra je preslaba. Treba bar ${SIFRA_MIN} znakova.`;
    case "same_password":
      return "Nova šifra mora da se razlikuje od stare.";
    case "email_address_invalid":
    case "validation_failed":
      return "Taj mejl ne izgleda ispravno.";
    case "over_email_send_rate_limit":
    case "over_request_rate_limit":
      return "Previše pokušaja za kratko vreme. Sačekaj minut pa probaj ponovo.";
    case "signup_disabled":
      return "Registracija je trenutno isključena.";
    default:
      return "Nešto je puklo sa naše strane. Probaj ponovo za koji trenutak.";
  }
}

// ───────────────────────── Registracija ─────────────────────────

export async function registracija(_pre: StanjeForme, formData: FormData): Promise<StanjeForme> {
  const username = tekst(formData, "username");
  const email = tekst(formData, "email").toLowerCase();
  const sifra = String(formData.get("sifra") ?? "");
  const sifra2 = String(formData.get("sifra2") ?? "");
  const next = bezbedanNext(formData.get("next"));
  const vrednosti = { username, email };

  const polja: Record<string, string> = {};
  const greskaImena = proveriKorisnickoIme(username);
  if (greskaImena) polja.username = greskaImena;
  if (!MEJL_REGEX.test(email)) polja.email = "Upiši ispravan mejl, npr. pera@gmail.com.";
  if (sifra.length < SIFRA_MIN) polja.sifra = `Šifra mora da ima bar ${SIFRA_MIN} znakova.`;
  else if (sifra !== sifra2) polja.sifra2 = "Šifre se ne poklapaju.";
  if (Object.keys(polja).length) return { polja, vrednosti };

  if (!supabasePodesen() || !adminPodesen()) return { greska: PORUKA_NIJE_PODESENO, vrednosti };

  const supabase = await createClient();

  const { data: slobodno, error: greskaProvere } = await supabase.rpc("username_available", {
    p_username: username,
  });
  if (greskaProvere) return { greska: "Ne možemo da proverimo ime. Probaj ponovo.", vrednosti };
  if (!slobodno) return { polja: { username: "To ime je već zauzeto. Brži su bili." }, vrednosti };

  const sajt = await adresaSajta();
  const { data, error } = await supabase.auth.signUp({
    email,
    password: sifra,
    // Šablon mejla ovu adresu prosleđuje ruti /auth/confirm kao `next`.
    options: { emailRedirectTo: `${sajt}${next}` },
  });
  if (error) return { greska: porukaGreske(error), vrednosti };

  // Kad mejl već ima nalog, Supabase vraća „praznog” korisnika bez identiteta (da se ne otkriva ko ima nalog).
  const noviNalog = data.user && (data.user.identities?.length ?? 0) > 0;
  if (noviNalog && data.user) {
    // Ime upisuje server, posle filtera. Ako ga je neko u međuvremenu zauzeo, igrač ga bira posle prijave.
    await createAdminClient().from("profiles").upsert({ id: data.user.id, username });
  }

  if (data.session) redirect(next);
  redirect(`/proveri-mejl?email=${encodeURIComponent(email)}`);
}

// ───────────────────────── Prijava i odjava ─────────────────────────

export async function prijava(_pre: StanjeForme, formData: FormData): Promise<StanjeForme> {
  const email = tekst(formData, "email").toLowerCase();
  const sifra = String(formData.get("sifra") ?? "");
  const next = bezbedanNext(formData.get("next"));
  const vrednosti = { email };

  if (!MEJL_REGEX.test(email) || !sifra) return { greska: "Upiši mejl i šifru.", vrednosti };
  if (!supabasePodesen()) return { greska: PORUKA_NIJE_PODESENO, vrednosti };

  const supabase = await createClient();
  const { data, error } = await supabase.auth.signInWithPassword({ email, password: sifra });
  if (error) return { greska: porukaGreske(error), vrednosti };

  const { data: profil } = await supabase.from("profiles").select("username").eq("id", data.user.id).maybeSingle();
  if (!profil?.username) redirect(`/nalog/korisnicko-ime?next=${encodeURIComponent(next)}`);
  redirect(next);
}

export async function odjava() {
  if (supabasePodesen()) {
    const supabase = await createClient();
    await supabase.auth.signOut();
  }
  redirect("/");
}

// ───────────────────────── Šifra ─────────────────────────

export async function zatraziNovuSifru(_pre: StanjeForme, formData: FormData): Promise<StanjeForme> {
  const email = tekst(formData, "email").toLowerCase();
  if (!MEJL_REGEX.test(email)) return { polja: { email: "Upiši ispravan mejl." }, vrednosti: { email } };
  if (!supabasePodesen()) return { greska: PORUKA_NIJE_PODESENO, vrednosti: { email } };

  const supabase = await createClient();
  const sajt = await adresaSajta();
  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: `${sajt}/nova-sifra`,
  });
  if (error && (error.code === "over_email_send_rate_limit" || error.code === "over_request_rate_limit")) {
    return { greska: porukaGreske(error), vrednosti: { email } };
  }
  // Ista poruka i kad nalog ne postoji, da se ne otkriva ko ima nalog.
  return { ok: "Ako nalog sa tim mejlom postoji, upravo ti je stigao link za novu šifru. Baci pogled i u spam." };
}

export async function postaviNovuSifru(_pre: StanjeForme, formData: FormData): Promise<StanjeForme> {
  const sifra = String(formData.get("sifra") ?? "");
  const sifra2 = String(formData.get("sifra2") ?? "");
  if (sifra.length < SIFRA_MIN) return { polja: { sifra: `Šifra mora da ima bar ${SIFRA_MIN} znakova.` } };
  if (sifra !== sifra2) return { polja: { sifra2: "Šifre se ne poklapaju." } };
  if (!supabasePodesen()) return { greska: PORUKA_NIJE_PODESENO };

  const supabase = await createClient();
  const { data: korisnik } = await supabase.auth.getUser();
  if (!korisnik.user) {
    return { greska: "Link je istekao ili je već iskorišćen. Zatraži novi sa strane „Zaboravljena šifra”." };
  }
  const { error } = await supabase.auth.updateUser({ password: sifra });
  if (error) return { greska: porukaGreske(error) };
  redirect("/nalog?sifra=promenjena");
}

// ───────────────────────── Korisničko ime ─────────────────────────

export async function postaviKorisnickoIme(_pre: StanjeForme, formData: FormData): Promise<StanjeForme> {
  const username = tekst(formData, "username");
  const next = bezbedanNext(formData.get("next"), "/nalog");
  const vrednosti = { username };

  const greskaImena = proveriKorisnickoIme(username);
  if (greskaImena) return { polja: { username: greskaImena }, vrednosti };
  if (!supabasePodesen() || !adminPodesen()) return { greska: PORUKA_NIJE_PODESENO, vrednosti };

  const supabase = await createClient();
  const { data: korisnik } = await supabase.auth.getUser();
  if (!korisnik.user) redirect("/prijava");

  const { error } = await createAdminClient().from("profiles").upsert({ id: korisnik.user.id, username });
  if (error) {
    if (error.code === "23505") return { polja: { username: "To ime je već zauzeto. Brži su bili." }, vrednosti };
    return { greska: "Ime nije sačuvano. Probaj ponovo.", vrednosti };
  }
  redirect(next);
}

// ───────────────────────── Brisanje naloga ─────────────────────────

export async function obrisiNalog(_pre: StanjeForme, formData: FormData): Promise<StanjeForme> {
  if (tekst(formData, "potvrda").toUpperCase() !== "OBRIŠI") {
    return { polja: { potvrda: "Upiši OBRIŠI da potvrdiš." } };
  }
  if (!supabasePodesen() || !adminPodesen()) return { greska: PORUKA_NIJE_PODESENO };

  const supabase = await createClient();
  const { data: korisnik } = await supabase.auth.getUser();
  if (!korisnik.user) redirect("/prijava");

  // Briše nalog, profil i sve rezultate (on delete cascade).
  const { error } = await createAdminClient().auth.admin.deleteUser(korisnik.user.id);
  if (error) return { greska: "Nalog nije obrisan. Probaj ponovo ili nam piši." };
  await supabase.auth.signOut();
  redirect("/?nalog=obrisan");
}
