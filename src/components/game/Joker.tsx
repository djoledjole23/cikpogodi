"use client";

import { useEffect, useRef, useState } from "react";
import { IconJoker } from "@/components/icons";
import type { Ocena, OdgovorJoker, PitanjeJoker, PrikazJoker } from "@/lib/game/types";
import { sfx } from "@/lib/sound";
import { Konfete, Nalepnica, Pecat, smanjenoKretanje } from "./efekti";

/** „Joker pitanje”: pitanje na kartici, polje za odgovor. Posle odgovora iskoče fotografija i veliki broj. */

const MERENJE_MS = 650;

export function JokerPitanje({
  pitanje,
  zakljucano,
  naOdgovor,
}: {
  pitanje: PitanjeJoker;
  zakljucano: boolean;
  naOdgovor: (odgovor: OdgovorJoker) => void;
}) {
  const [tekst, setTekst] = useState("");
  const polje = useRef<HTMLInputElement>(null);
  const moze = tekst.trim() !== "" && !zakljucano;

  return (
    <form
      className="g-pitanje g-joker"
      onSubmit={(e) => {
        e.preventDefault();
        if (!moze) return;
        sfx.klik();
        polje.current?.blur();
        naOdgovor({ tekst });
      }}
    >
      <div className="g-joker-karta">
        <span className="g-joker-oznaka">
          <IconJoker size={18} />
          Joker · +50
        </span>
        {pitanje.slika && (
          <div className="g-joker-foto g-joker-foto-pitanje">
            {/* eslint-disable-next-line @next/next/no-img-element -- fotografija je već pripremljena (webp, do 960 px) */}
            <img src={pitanje.slika} alt="Fotografija uz pitanje" decoding="async" />
          </div>
        )}
        <p className="g-joker-pitanje">{pitanje.pitanje}</p>
      </div>
      <div className="g-film-unos">
        <label htmlFor="g-joker" className="g-unos-natpis">
          Tvoj odgovor
        </label>
        <div className="g-unos-red">
          <div className="g-pesma-polje">
            <input
              id="g-joker"
              ref={polje}
              value={tekst}
              onChange={(e) => setTekst(e.target.value)}
              placeholder="Upiši odgovor"
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

export function JokerOcena({
  ocena,
  prikaz: p,
  otkriveno,
  naOtkrij,
}: {
  ocena: Ocena;
  prikaz: PrikazJoker;
  otkriveno: boolean;
  naOtkrij: () => void;
}) {
  const [bezSlike, setBezSlike] = useState(!p.slika);
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

  const imaSliku = Boolean(p.slika) && !bezSlike;
  return (
    <>
      {(imaSliku || p.broj) && (
        <div className={otkriveno ? "g-joker-ishod" : "g-joker-ishod g-nevidljivo"}>
          {otkriveno && imaSliku && (
            <div className="g-joker-foto">
              {/* eslint-disable-next-line @next/next/no-img-element -- fotografija je već pripremljena (webp, do 960 px) */}
              <img src={p.slika!} alt={p.resenje} decoding="async" onError={() => setBezSlike(true)} />
            </div>
          )}
          {otkriveno && p.broj && (
            <p className="g-joker-broj">
              <strong>{p.broj}</strong>
              {p.natpis && <span>{p.natpis}</span>}
            </p>
          )}
          {otkriveno && ocena.tacno && <Konfete jacina={3} />}
        </div>
      )}
      <p className={otkriveno ? "g-film-naslov" : "g-film-naslov g-nevidljivo"}>{p.resenje}</p>
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
