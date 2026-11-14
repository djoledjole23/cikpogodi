"use client";

import Link from "next/link";
import { OAuthDugmad, RegistracijaForma } from "@/components/auth/forms";
import type { Stanje } from "@/lib/game/types";
import { sfx } from "@/lib/sound";

/**
 * Posle poslednjeg pitanja, pre rezultata: „Sačuvaj rezultat i uđi na rang listu”.
 * Ko je već prijavljen ovaj ekran ne vidi (rezultat mu se čuva sam).
 * Posle registracije ili prijave igrač se vraća na /igra, gde ga čeka rezultat.
 */
export function SacuvajRezultat({ stanje, naPreskoci }: { stanje: Stanje; naPreskoci: () => void }) {
  return (
    <section className="stack-lg g-sacuvaj">
      <div className="stack">
        <p className="g-uvod-broj">Gotovo za danas</p>
        <h1 className="h1">Sačuvaj rezultat i uđi na rang listu</h1>
        <p className="lead">
          Imaš {stanje.score} {stanje.score % 10 === 1 && stanje.score % 100 !== 11 ? "poen" : "poena"}. Napravi nalog da ne propadnu, pa vidi ko je danas
          bolji od tebe.
        </p>
      </div>

      {stanje.nalozi ? (
        <>
          <OAuthDugmad next="/igra" />
          <p className="divider">ili mejlom</p>
          <RegistracijaForma next="/igra" />
          <p className="center">
            <Link href="/prijava?next=/igra" className="text-link tap">
              Već imam nalog → Prijavi se
            </Link>
          </p>
        </>
      ) : (
        <p className="g-obavestenje">Nalozi još nisu povezani, pa rezultat za sada ne može da se sačuva. Možeš da ga pogledaš.</p>
      )}

      <button
        type="button"
        className="g-tekst-dugme"
        onClick={() => {
          sfx.klik();
          naPreskoci();
        }}
      >
        Preskoči, samo mi pokaži rezultat
      </button>
    </section>
  );
}
