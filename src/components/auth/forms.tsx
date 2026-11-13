"use client";

import Link from "next/link";
import { useActionState, useState } from "react";
import {
  obrisiNalog,
  postaviKorisnickoIme,
  postaviNovuSifru,
  prijava,
  registracija,
  zatraziNovuSifru,
  type StanjeForme,
} from "@/lib/auth-actions";
import { KORISNICKO_IME, SIFRA_MIN } from "@/config/quiz.config";
import { createClient } from "@/lib/supabase/client";
import { supabasePodesen } from "@/lib/supabase/env";
import { Field } from "./Field";

const PRAZNO: StanjeForme = {};

function Greska({ stanje }: { stanje: StanjeForme }) {
  if (!stanje.greska) return null;
  return (
    <p className="form-error" role="alert">
      {stanje.greska}
    </p>
  );
}

// ───────────────────────── Google / Apple ─────────────────────────

export function OAuthDugmad({ next = "/" }: { next?: string }) {
  const [greska, setGreska] = useState<string | null>(null);
  const [ceka, setCeka] = useState<"google" | "apple" | null>(null);

  async function nastavi(provider: "google" | "apple") {
    setGreska(null);
    if (!supabasePodesen()) {
      setGreska("Prijava preko Google i Apple naloga još nije povezana.");
      return;
    }
    setCeka(provider);
    const { error } = await createClient().auth.signInWithOAuth({
      provider,
      options: { redirectTo: `${window.location.origin}/auth/callback?next=${encodeURIComponent(next)}` },
    });
    if (error) {
      setCeka(null);
      setGreska("Nije uspelo. Probaj ponovo ili se registruj mejlom.");
    }
  }

  return (
    <div className="stack">
      <button type="button" className="btn btn-cream" onClick={() => nastavi("google")} disabled={ceka !== null}>
        {ceka === "google" ? "Otvaram Google…" : "Nastavi sa Google"}
      </button>
      <button type="button" className="btn btn-cream" onClick={() => nastavi("apple")} disabled={ceka !== null}>
        {ceka === "apple" ? "Otvaram Apple…" : "Nastavi sa Apple"}
      </button>
      {greska && (
        <p className="form-error" role="alert">
          {greska}
        </p>
      )}
    </div>
  );
}

// ───────────────────────── Registracija ─────────────────────────

export function RegistracijaForma({ next = "/" }: { next?: string }) {
  const [stanje, akcija, ceka] = useActionState(registracija, PRAZNO);
  return (
    <form action={akcija} className="form" noValidate>
      <input type="hidden" name="next" value={next} />
      <Greska stanje={stanje} />
      <Field
        name="username"
        label="Korisničko ime"
        hint={`${KORISNICKO_IME.min}–${KORISNICKO_IME.max} znakova. Ovo ime se vidi na rang listi.`}
        error={stanje.polja?.username}
        defaultValue={stanje.vrednosti?.username}
        autoComplete="username"
        autoCapitalize="none"
        spellCheck={false}
        maxLength={KORISNICKO_IME.max}
        required
      />
      <Field
        name="email"
        type="email"
        label="Mejl"
        error={stanje.polja?.email}
        defaultValue={stanje.vrednosti?.email}
        autoComplete="email"
        inputMode="email"
        required
      />
      <Field
        name="sifra"
        type="password"
        label="Šifra"
        hint={`Bar ${SIFRA_MIN} znakova.`}
        error={stanje.polja?.sifra}
        autoComplete="new-password"
        required
      />
      <Field
        name="sifra2"
        type="password"
        label="Šifra još jednom"
        error={stanje.polja?.sifra2}
        autoComplete="new-password"
        required
      />
      <button type="submit" className="btn" disabled={ceka}>
        {ceka ? "Pravim nalog…" : "Napravi nalog"}
      </button>
      <p className="small muted center">
        Pravljenjem naloga prihvataš <Link href="/uslovi-koriscenja">uslove korišćenja</Link> i{" "}
        <Link href="/pravila-privatnosti">pravila privatnosti</Link>.
      </p>
    </form>
  );
}

// ───────────────────────── Prijava ─────────────────────────

export function PrijavaForma({ next = "/" }: { next?: string }) {
  const [stanje, akcija, ceka] = useActionState(prijava, PRAZNO);
  return (
    <form action={akcija} className="form" noValidate>
      <input type="hidden" name="next" value={next} />
      <Greska stanje={stanje} />
      <Field
        name="email"
        type="email"
        label="Mejl"
        defaultValue={stanje.vrednosti?.email}
        autoComplete="email"
        inputMode="email"
        required
      />
      <Field name="sifra" type="password" label="Šifra" autoComplete="current-password" required />
      <button type="submit" className="btn" disabled={ceka}>
        {ceka ? "Prijavljujem…" : "Prijavi se"}
      </button>
    </form>
  );
}

// ───────────────────────── Zaboravljena / nova šifra ─────────────────────────

export function ZaboravljenaSifraForma() {
  const [stanje, akcija, ceka] = useActionState(zatraziNovuSifru, PRAZNO);
  if (stanje.ok) {
    return (
      <p className="form-ok" role="status">
        {stanje.ok}
      </p>
    );
  }
  return (
    <form action={akcija} className="form" noValidate>
      <Greska stanje={stanje} />
      <Field
        name="email"
        type="email"
        label="Mejl sa kojim si napravio nalog"
        error={stanje.polja?.email}
        defaultValue={stanje.vrednosti?.email}
        autoComplete="email"
        inputMode="email"
        required
      />
      <button type="submit" className="btn" disabled={ceka}>
        {ceka ? "Šaljem…" : "Pošalji mi link"}
      </button>
    </form>
  );
}

export function NovaSifraForma() {
  const [stanje, akcija, ceka] = useActionState(postaviNovuSifru, PRAZNO);
  return (
    <form action={akcija} className="form" noValidate>
      <Greska stanje={stanje} />
      <Field
        name="sifra"
        type="password"
        label="Nova šifra"
        hint={`Bar ${SIFRA_MIN} znakova.`}
        error={stanje.polja?.sifra}
        autoComplete="new-password"
        required
      />
      <Field
        name="sifra2"
        type="password"
        label="Nova šifra još jednom"
        error={stanje.polja?.sifra2}
        autoComplete="new-password"
        required
      />
      <button type="submit" className="btn" disabled={ceka}>
        {ceka ? "Čuvam…" : "Sačuvaj novu šifru"}
      </button>
    </form>
  );
}

// ───────────────────────── Korisničko ime ─────────────────────────

export function KorisnickoImeForma({
  next = "/nalog",
  trenutno,
  dugme = "Sačuvaj ime",
}: {
  next?: string;
  trenutno?: string | null;
  dugme?: string;
}) {
  const [stanje, akcija, ceka] = useActionState(postaviKorisnickoIme, PRAZNO);
  return (
    <form action={akcija} className="form" noValidate>
      <input type="hidden" name="next" value={next} />
      <Greska stanje={stanje} />
      <Field
        name="username"
        label="Korisničko ime"
        hint={`${KORISNICKO_IME.min}–${KORISNICKO_IME.max} znakova: slova, brojevi i donja crta.`}
        error={stanje.polja?.username}
        defaultValue={stanje.vrednosti?.username ?? trenutno ?? ""}
        autoComplete="username"
        autoCapitalize="none"
        spellCheck={false}
        maxLength={KORISNICKO_IME.max}
        required
      />
      <button type="submit" className="btn" disabled={ceka}>
        {ceka ? "Čuvam…" : dugme}
      </button>
    </form>
  );
}

// ───────────────────────── Brisanje naloga ─────────────────────────

export function BrisanjeNalogaForma() {
  const [stanje, akcija, ceka] = useActionState(obrisiNalog, PRAZNO);
  const [otvoreno, setOtvoreno] = useState(false);

  if (!otvoreno) {
    return (
      <button type="button" className="btn btn-ghost" onClick={() => setOtvoreno(true)}>
        Obriši nalog
      </button>
    );
  }
  return (
    <form action={akcija} className="form" noValidate>
      <p>
        Ovo briše nalog i sve tvoje rezultate sa rang liste. Nema nazad. Ako si siguran, upiši <strong>OBRIŠI</strong>.
      </p>
      <Greska stanje={stanje} />
      <Field
        name="potvrda"
        label="Potvrda"
        error={stanje.polja?.potvrda}
        autoComplete="off"
        autoCapitalize="characters"
        spellCheck={false}
      />
      <button type="submit" className="btn" disabled={ceka}>
        {ceka ? "Brišem…" : "Obriši zauvek"}
      </button>
      <button type="button" className="btn btn-ghost" onClick={() => setOtvoreno(false)}>
        Ipak neću
      </button>
    </form>
  );
}
