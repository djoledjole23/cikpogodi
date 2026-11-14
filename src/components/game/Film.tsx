"use client";

import { useEffect, useRef, useState } from "react";
import { IconKlapa } from "@/components/icons";
import type { Ocena, OdgovorFilm, PitanjeFilm, PrikazFilm } from "@/lib/game/types";
import { sfx } from "@/lib/sound";
import { Konfete, Nalepnica, Pecat, smanjenoKretanje } from "./efekti";

/** „Pogodi domaći film/seriju”: kadar gore, polje za naslov dole. Bez ponuđenih odgovora. */

const MERENJE_MS = 650;

function Kadar({ slika, otkriven = false }: { slika: string; otkriven?: boolean }) {
  const [greska, setGreska] = useState(false);
  return (
    <div className={otkriven ? "g-kadar otkriven" : "g-kadar"}>
      {greska ? (
        <span className="g-kadar-zamena">
          <IconKlapa size={56} />
          Slika neće da se učita
        </span>
      ) : (
        // eslint-disable-next-line @next/next/no-img-element -- kadar je već pripremljen (webp, do 960 px), bez dodatne obrade
        <img src={slika} alt="Kadar iz filma ili serije" decoding="async" fetchPriority="high" onError={() => setGreska(true)} />
      )}
    </div>
  );
}

export function FilmPitanje({
  pitanje,
  zakljucano,
  naOdgovor,
}: {
  pitanje: PitanjeFilm;
  zakljucano: boolean;
  naOdgovor: (odgovor: OdgovorFilm) => void;
}) {
  const [tekst, setTekst] = useState("");
  const polje = useRef<HTMLInputElement>(null);
  const moze = tekst.trim() !== "" && !zakljucano;

  return (
    <form
      className="g-pitanje g-film"
      onSubmit={(e) => {
        e.preventDefault();
        if (!moze) return;
        sfx.klik();
        polje.current?.blur();
        naOdgovor({ tekst });
      }}
    >
      <Kadar slika={pitanje.slika} />
      <div className="g-film-unos">
        <label htmlFor="g-film" className="g-unos-natpis">
          Koji je ovo film ili serija?
        </label>
        <div className="g-unos-red">
          <div className="g-pesma-polje">
            <input
              id="g-film"
              ref={polje}
              value={tekst}
              onChange={(e) => setTekst(e.target.value)}
              placeholder="Upiši naslov"
              autoComplete="off"
              autoCorrect="off"
              autoCapitalize="sentences"
              spellCheck={false}
              enterKeyHint="done"
              maxLength={120}
              disabled={zakljucano}
              autoFocus
            />
          </div>
          <button type="submit" className="btn g-unos-dugme" aria-disabled={!moze}>
            <span>{zakljucano ? "…" : "Potvrdi"}</span>
          </button>
        </div>
        <p className="g-opseg">Kvačice i sitne greške u kucanju se praštaju.</p>
      </div>
      <button
        type="button"
        className="g-tekst-dugme"
        onClick={() => {
          if (zakljucano) return;
          sfx.klik();
          naOdgovor({ neZnam: true });
        }}
        aria-disabled={zakljucano}
      >
        Ne znam
      </button>
    </form>
  );
}

export function FilmOcena({
  ocena,
  prikaz: p,
  otkriveno,
  naOtkrij,
}: {
  ocena: Ocena;
  prikaz: PrikazFilm;
  otkriveno: boolean;
  naOtkrij: () => void;
}) {
  const otkrijRef = useRef(naOtkrij);
  useEffect(() => {
    otkrijRef.current = naOtkrij;
  }, [naOtkrij]);
  useEffect(() => {
    const ms = smanjenoKretanje() ? 0 : MERENJE_MS;
    if (ms) sfx.vrti(ms);
    const sat = setTimeout(() => otkrijRef.current(), ms);
    return () => clearTimeout(sat);
  }, []);

  return (
    <>
      <div className="g-film-ishod">
        <Kadar slika={p.slika} otkriven={otkriveno} />
        {otkriveno && ocena.tacno && <Konfete jacina={3} />}
      </div>
      <p className={otkriveno ? "g-film-naslov" : "g-film-naslov g-nevidljivo"}>{p.naslov}</p>
      <div className={otkriveno ? "g-film-dno" : "g-film-dno g-nevidljivo"}>
        {otkriveno && (
          <p className="g-duel-presuda" role="status">
            <Pecat vrsta={ocena.istek ? "vreme" : p.neZnam ? "neznam" : p.tacno ? "pogodak" : "promasaj"} />
            <Nalepnica poeni={ocena.poeni} />
          </p>
        )}
        {p.odgovor && (
          <p className="g-opseg">
            Tvoj odgovor: <strong>{p.odgovor}</strong>
          </p>
        )}
      </div>
    </>
  );
}
