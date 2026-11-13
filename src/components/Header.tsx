import Link from "next/link";
import { Suspense } from "react";
import { getIgrac } from "@/lib/auth";
import { SoundToggle } from "./SoundToggle";

/** Zaglavlje. `logo` se gasi na početnoj, gde je veliki logo odmah ispod. */
export function Header({ logo = true }: { logo?: boolean }) {
  return (
    <header className="header">
      <nav className="header-nav" aria-label="Glavni meni">
        {logo && (
          <Link href="/" className="header-logo" aria-label="Čik Pogodi! – početna">
            Čik&nbsp;<span>Pogodi!</span>
          </Link>
        )}
        <Link href="/rang-lista" className="nav-link">
          Rang lista
        </Link>
        {/* Deo koji zavisi od naloga stiže naknadno, da ne koči ostatak strane. */}
        <Suspense fallback={null}>
          <NalogLink />
        </Suspense>
      </nav>
      <SoundToggle />
    </header>
  );
}

async function NalogLink() {
  const igrac = await getIgrac();
  if (!igrac) {
    return (
      <Link href="/prijava" className="nav-link">
        Prijavi se
      </Link>
    );
  }
  return (
    <Link href="/nalog" className="nav-link nav-link-nalog">
      {igrac.username ?? "Moj nalog"}
    </Link>
  );
}
