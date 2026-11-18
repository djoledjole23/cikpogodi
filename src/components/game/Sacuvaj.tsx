"use client";

import Link from "next/link";
import { OAuthDugmad, OAuthRazdvojnik, RegistracijaForma } from "@/components/auth/forms";
import type { Stanje } from "@/lib/game/types";
import { sfx } from "@/lib/sound";
import { NizDanaKartica } from "./Niz";

/**
 * Kraj igre za gosta: rezultat je zamagljen, a odmah ispod je registracija
 * (nadimak + lozinka) i veliko dugme koje vodi pravo na rang listu.
 * Ko je već prijavljen ovaj ekran ne vidi (rezultat mu se čuva sam).
 */
export function SacuvajRezultat({ stanje, naPreskoci }: { stanje: Stanje; naPreskoci: () => void }) {
  const max = stanje.segmenti.reduce((z, s) => z + s.max, 0);
  return (
    <section className="stack-lg g-sacuvaj">
      <p className="g-uvod-broj">Gotovo za danas</p>

      <div className="g-zakljucan">
        <p className="g-veliki-zbir g-zamagljeno" aria-hidden="true">
          {stanje.score}
          <small> / {max}</small>
        </p>
        <p className="g-zakljucan-natpis">
          <span aria-hidden="true">🔒</span> Rezultat te čeka
        </p>
      </div>

      {stanje.niz && <NizDanaKartica niz={stanje.niz} datum={stanje.datum} />}

      <div className="stack">
        <h1 className="h1">Upiši nadimak i vidi gde si na rang listi</h1>
      </div>

      {stanje.nalozi ? (
        <>
          <OAuthDugmad next="/rang-lista" />
          <OAuthRazdvojnik />
          <RegistracijaForma next="/rang-lista" dugme="Pogledaj rang listu" />
          <Link href="/prijava?next=/rang-lista" className="btn btn-ghost">
            Već imaš nalog? Prijavi se
          </Link>
        </>
      ) : (
        <p className="g-obavestenje">
          Nalozi još nisu povezani na ovom računaru. Popuni <code>.env.local</code> (vidi README, deo „Supabase”) pa
          ponovo pokreni sajt.
        </p>
      )}

      {stanje.nalozi && stanje.probnaBaza && (
        <p className="g-obavestenje">
          Baza je privremena (fali <code>DATABASE_URL</code>), pa rezultat ne može da se upiše. Nalog možeš da
          napraviš, ali igra te i dalje vodi kao gosta.
        </p>
      )}

      <button
        type="button"
        className="g-tekst-dugme"
        onClick={() => {
          sfx.klik();
          naPreskoci();
        }}
      >
        Ne sada, samo mi pokaži poene
      </button>
    </section>
  );
}
