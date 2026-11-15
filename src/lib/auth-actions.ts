"use server";

import type { AuthError } from "@supabase/supabase-js";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { SIFRA_MIN } from "@/config/quiz.config";
import { bezbedanNext } from "@/lib/auth";
import { getDb, privremenaBaza } from "@/lib/db";
import { prikljuciZavrseneIgre } from "@/lib/game/engine";
import { jeUuid, KOLACIC_UREDJAJA } from "@/lib/game/identity";
import { PORUKA_NIJE_PODESENO, supabasePodesen } from "@/lib/supabase/env";
import { adminPodesen, createAdminClient, createClient } from "@/lib/supabase/server";
import { beogradskiDatum, dodajDane } from "@/lib/time";
import { mejlZaIme, proveriKorisnickoIme } from "@/lib/username";

export type StanjeForme = {
  /** Greška za celu formu. */
  greska?: string;
  /** Greške po poljima (ključ = name polja). */
  polja?: Record<string, string>;
  /** Šta je korisnik uneo, da ne kuca ponovo posle greške (lozinke se ne vraćaju). */
  vrednosti?: Record<string, string>;
  /** Poruka o uspehu. */
  ok?: string;
};

const ZAUZETO = "To ime je već zauzeto. Brži su bili.";

function tekst(formData: FormData, polje: string): string {
  const v = formData.get(polje);
  return typeof v === "string" ? v.trim() : "";
}

function porukaGreske(error: AuthError): string {
  switch (error.code) {
    case "invalid_credentials":
      return "Pogrešno ime ili lozinka. Probaj opet.";
    case "user_already_exists":
    case "email_exists":
      return ZAUZETO;
    case "weak_password":
      return `Lozinka je preslaba. Treba bar ${SIFRA_MIN} znakova.`;
    case "same_password":
      return "Nova lozinka mora da se razlikuje od stare.";
    case "over_request_rate_limit":
      return "Previše pokušaja za kratko vreme. Sačekaj minut pa probaj ponovo.";
    case "signup_disabled":
      return "Registracija je trenutno isključena.";
    default:
      return "Nešto je puklo sa naše strane. Probaj ponovo za koji trenutak.";
  }
}

/** Završene gostujuće igre sa ovog uređaja (današnja i jučerašnja) prelaze na nalog. Greška ovde ne sme da pokvari registraciju. */
async function sacuvajGostujucuIgru(userId: string) {
  if (privremenaBaza()) return;
  try {
    const uredjaj = (await cookies()).get(KOLACIC_UREDJAJA)?.value;
    const db = await getDb();
    if (!db || !jeUuid(uredjaj)) return;
    const danas = beogradskiDatum();
    await prikljuciZavrseneIgre(db, userId, uredjaj.toLowerCase(), [danas, dodajDane(danas, -1)]);
  } catch (e) {
    console.error("[nalog] igra nije prebačena na nalog", e);
  }
}

// ───────────────────────── Registracija ─────────────────────────

/**
 * Nadimak + lozinka i nalog je gotov: nema mejla, nema potvrde, odmah je prijavljen
 * i njegov rezultat ulazi na rang listu.
 */
export async function registracija(_pre: StanjeForme, formData: FormData): Promise<StanjeForme> {
  const username = tekst(formData, "username");
  const sifra = String(formData.get("sifra") ?? "");
  const next = bezbedanNext(formData.get("next"));
  const vrednosti = { username };

  const polja: Record<string, string> = {};
  const greskaImena = proveriKorisnickoIme(username);
  if (greskaImena) polja.username = greskaImena;
  if (sifra.length < SIFRA_MIN) polja.sifra = `Lozinka mora da ima bar ${SIFRA_MIN} znakova.`;
  if (Object.keys(polja).length) return { polja, vrednosti };

  if (!supabasePodesen() || !adminPodesen()) return { greska: PORUKA_NIJE_PODESENO, vrednosti };

  const supabase = await createClient();
  const admin = createAdminClient();

  const { data: slobodno, error: greskaProvere } = await supabase.rpc("username_available", {
    p_username: username,
  });
  if (greskaProvere) return { greska: "Ne možemo da proverimo ime. Probaj ponovo.", vrednosti };
  if (!slobodno) return { polja: { username: ZAUZETO }, vrednosti };

  const email = mejlZaIme(username);
  const { data, error } = await admin.auth.admin.createUser({
    email,
    password: sifra,
    // Nalog je odmah „potvrđen”: adresa je interna, na nju se ništa i ne šalje.
    email_confirm: true,
  });
  if (error || !data.user) return { greska: error ? porukaGreske(error) : "Nalog nije napravljen. Probaj ponovo.", vrednosti };

  // Ime upisuje server, posle filtera. Ako ga je neko zauzeo u međuvremenu, nalog se poništava.
  const { error: greskaImenaUBazi } = await admin.from("profiles").upsert({ id: data.user.id, username });
  if (greskaImenaUBazi) {
    await admin.auth.admin.deleteUser(data.user.id).catch(() => undefined);
    if (greskaImenaUBazi.code === "23505") return { polja: { username: ZAUZETO }, vrednosti };
    return { greska: "Nalog nije napravljen. Probaj ponovo.", vrednosti };
  }

  const { error: greskaPrijave } = await supabase.auth.signInWithPassword({ email, password: sifra });
  if (greskaPrijave) return { greska: porukaGreske(greskaPrijave), vrednosti };

  // Igra koju je upravo završio kao gost postaje igra novog naloga.
  await sacuvajGostujucuIgru(data.user.id);
  redirect(next);
}

// ───────────────────────── Prijava i odjava ─────────────────────────

export async function prijava(_pre: StanjeForme, formData: FormData): Promise<StanjeForme> {
  const username = tekst(formData, "username");
  const sifra = String(formData.get("sifra") ?? "");
  const next = bezbedanNext(formData.get("next"));
  const vrednosti = { username };

  if (!username || !sifra) return { greska: "Upiši ime i lozinku.", vrednosti };
  if (!supabasePodesen()) return { greska: PORUKA_NIJE_PODESENO, vrednosti };

  const supabase = await createClient();
  const { data, error } = await supabase.auth.signInWithPassword({
    email: mejlZaIme(username),
    password: sifra,
  });
  if (error) return { greska: porukaGreske(error), vrednosti };

  // Nalog napravljen pre nego što je prijava postala „samo nadimak” možda nema ime.
  const { data: profil } = await supabase.from("profiles").select("username").eq("id", data.user.id).maybeSingle();
  if (!profil?.username && adminPodesen()) {
    await createAdminClient().from("profiles").upsert({ id: data.user.id, username });
  }

  await sacuvajGostujucuIgru(data.user.id);
  redirect(next);
}

export async function odjava() {
  if (supabasePodesen()) {
    const supabase = await createClient();
    await supabase.auth.signOut();
  }
  redirect("/");
}

// ───────────────────────── Lozinka ─────────────────────────

/** Menja lozinku prijavljenom igraču. Zaboravljena lozinka se ne može vratiti: nema mejla. */
export async function postaviNovuSifru(_pre: StanjeForme, formData: FormData): Promise<StanjeForme> {
  const stara = String(formData.get("stara") ?? "");
  const sifra = String(formData.get("sifra") ?? "");
  if (sifra.length < SIFRA_MIN) return { polja: { sifra: `Lozinka mora da ima bar ${SIFRA_MIN} znakova.` } };
  if (!supabasePodesen()) return { greska: PORUKA_NIJE_PODESENO };

  const supabase = await createClient();
  const { data: korisnik } = await supabase.auth.getUser();
  if (!korisnik.user?.email) redirect("/prijava?next=/nalog");

  // Stara lozinka se traži da neko ko sedne za tuđ telefon ne može da preuzme nalog.
  const { error: greskaStare } = await supabase.auth.signInWithPassword({
    email: korisnik.user.email,
    password: stara,
  });
  if (greskaStare) return { polja: { stara: "Stara lozinka nije tačna." } };

  const { error } = await supabase.auth.updateUser({ password: sifra });
  if (error) return { greska: porukaGreske(error) };
  redirect("/nalog?sifra=promenjena");
}

// ───────────────────────── Korisničko ime ─────────────────────────

/** Ime je ujedno i prijava, pa se uz njega menja i interna adresa naloga. */
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

  const admin = createAdminClient();
  const { error } = await admin.from("profiles").upsert({ id: korisnik.user.id, username });
  if (error) {
    if (error.code === "23505") return { polja: { username: ZAUZETO }, vrednosti };
    return { greska: "Ime nije sačuvano. Probaj ponovo.", vrednosti };
  }

  const { error: greskaAdrese } = await admin.auth.admin.updateUserById(korisnik.user.id, {
    email: mejlZaIme(username),
    email_confirm: true,
  });
  if (greskaAdrese) {
    return { polja: { username: ZAUZETO }, vrednosti };
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
