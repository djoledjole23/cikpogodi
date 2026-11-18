"use client";

import { useEffect, useState, type CSSProperties } from "react";
import { danaRec, porukaZaNiz } from "@/lib/game/niz";
import type { NizDana } from "@/lib/game/types";
import { dodajDane } from "@/lib/time";
import { haptika, sfx } from "@/lib/sound";
import { Konfete, smanjenoKretanje, useBrojac } from "./efekti";

const KLJUC_VIDENO = "cp_niz_videno";
const DANI_U_NEDELJI = ["N", "P", "U", "S", "Č", "P", "S"];

/** Dani kad se slavi jače (veće konfete): prva nedelja, okrugli brojevi, svaka 50. */
function jeJubilej(n: number): boolean {
  return n === 7 || n === 14 || n === 21 || n === 30 || n === 77 || n === 365 || (n >= 50 && n % 50 === 0);
}

/** „P” za ponedeljak itd., iz datuma oblika 2026-11-18 (podne UTC, da vremenska zona ne pomeri dan). */
function slovoDana(datum: string): string {
  return DANI_U_NEDELJI[new Date(`${datum}T12:00:00Z`).getUTCDay()];
}

/** Da li je animacija za ovaj dan već odgledana na ovom uređaju (pa se posle osvežavanja ne ponavlja). */
function vecVideno(datum: string): boolean {
  try {
    return localStorage.getItem(KLJUC_VIDENO) === datum;
  } catch {
    return false;
  }
}

function zapamtiVideno(datum: string) {
  try {
    localStorage.setItem(KLJUC_VIDENO, datum);
  } catch {
    // Privatni režim ili pun storage: animacija se samo ponovi sledeći put.
  }
}

/**
 * Niz dana zaredom, kao kod Duolinga: plamen, broj koji skoči sa juče na danas, poslednjih 7 dana
 * kao kružići (današnji se upali poslednji) i poruka za taj dan. Animacija ide jednom dnevno po uređaju.
 */
export function NizDanaKartica({ niz, datum }: { niz: NizDana; datum: string }) {
  const dana = niz.dana;
  const [animiraj] = useState(() => !smanjenoKretanje() && !vecVideno(datum));
  const [upaljeno, setUpaljeno] = useState(!animiraj);
  // Broj stoji na jučerašnjem dok se današnji kružić ne upali, pa skoči.
  const juce = animiraj ? Math.max(0, dana - 1) : dana;
  const prikazano = useBrojac(upaljeno ? dana : juce, 600, juce);

  useEffect(() => {
    if (!animiraj) return;
    zapamtiVideno(datum);
    const id = setTimeout(() => {
      setUpaljeno(true);
      sfx.zvezda(Math.min(3, Math.max(1, dana)));
      if (jeJubilej(dana)) sfx.fanfare();
      haptika.tacno();
    }, 650);
    return () => clearTimeout(id);
  }, [animiraj, dana, datum]);

  if (dana <= 0) return null;

  // Poslednjih 7 dana, danas je poslednji kružić.
  const dani = Array.from({ length: 7 }, (_, i) => {
    const d = dodajDane(datum, i - 6);
    const unazad = 6 - i;
    return { datum: d, slovo: slovoDana(d), uNizu: unazad < dana, danas: unazad === 0 };
  });

  const poruka = porukaZaNiz(niz);

  return (
    <section className={upaljeno ? "g-dani upaljen" : "g-dani"} aria-label={`Niz: ${dana} ${danaRec(dana)} zaredom`}>
      {animiraj && upaljeno && <Konfete jacina={jeJubilej(dana) ? 3 : 1} />}
      <div className="g-dani-vrh">
        <span className="g-dani-plamen" aria-hidden="true">
          🔥
        </span>
        <p className="g-dani-broj">
          <strong key={prikazano}>{prikazano}</strong>
          <span>{danaRec(dana)} zaredom</span>
        </p>
      </div>

      <ol className="g-dani-dani" aria-hidden="true">
        {dani.map((d, i) => (
          <li
            key={d.datum}
            className={[d.uNizu && (!d.danas || upaljeno) ? "pun" : "", d.danas ? "danas" : ""].join(" ").trim() || undefined}
            style={{ "--i": i } as CSSProperties}
          >
            <span className="g-dani-kruzic">{d.uNizu && (!d.danas || upaljeno) ? "✓" : ""}</span>
            <span className="g-dani-slovo">{d.slovo}</span>
          </li>
        ))}
      </ol>

      <p className={upaljeno ? "g-dani-poruka vidi" : "g-dani-poruka"} role="status">
        {poruka}
      </p>
      <p className="g-dani-podsetnik small muted">Nova igra u ponoć. Ne prekidaj niz!</p>
    </section>
  );
}
