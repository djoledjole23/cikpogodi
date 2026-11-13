"use client";

import Link from "next/link";
import { useSyncExternalStore } from "react";

const KLJUC = "cp_kolacici";
const DOGADJAJ = "cp:kolacici";

function prati(cb: () => void) {
  window.addEventListener(DOGADJAJ, cb);
  return () => window.removeEventListener(DOGADJAJ, cb);
}

function prihvaceno() {
  try {
    return window.localStorage.getItem(KLJUC) === "1";
  } catch {
    return true;
  }
}

/** Kratak baner. Koristimo samo neophodne kolačiće, pa nema šta da se bira: samo obaveštenje. */
export function CookieBanner() {
  // Na serveru i pre hidratacije se ne prikazuje, da ne treperi onima koji su već kliknuli.
  const sakriven = useSyncExternalStore(prati, prihvaceno, () => true);
  if (sakriven) return null;

  return (
    <div className="cookie" role="region" aria-label="Obaveštenje o kolačićima">
      <div className="cookie-box">
        <p>
          Koristimo samo kolačiće bez kojih igra ne radi (prijava i jedna igra dnevno).{" "}
          <Link href="/pravila-privatnosti">Više</Link>
        </p>
        <button
          type="button"
          onClick={() => {
            try {
              window.localStorage.setItem(KLJUC, "1");
            } catch {
              // nema veze
            }
            window.dispatchEvent(new Event(DOGADJAJ));
          }}
        >
          Važi
        </button>
      </div>
    </div>
  );
}
