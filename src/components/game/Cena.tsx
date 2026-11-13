"use client";

import { useEffect, useRef, useState } from "react";
import { IconCena, IconStikla, IconStrelica, IconVatra } from "@/components/icons";
import { din } from "@/lib/format";
import { komentarCena } from "@/lib/game/komentari";
import type { Ocena, PitanjeCena } from "@/lib/game/types";
import { Konfete, poletiDoZbira } from "./efekti";

const NAJVISE_CIFARA = 6;

/** Slika i naziv artikla. Slike su sa Open Food Facts i učitavaju se direktno odatle. */
function Artikal({ naziv, kolicina, slika, mali = false }: { naziv: string; kolicina: string; slika: string; mali?: boolean }) {
  // Ako slika ne stigne (Open Food Facts ne radi, link je zastareo), pitanje i dalje može da se igra po nazivu.
  const [bezSlike, setBezSlike] = useState(!slika);
  return (
    <div className={mali ? "g-artikal mali" : "g-artikal"}>
      <div className={bezSlike ? "g-artikal-slika prazna" : "g-artikal-slika"}>
        {bezSlike ? (
          <IconCena size={mali ? 30 : 64} />
        ) : (
          // eslint-disable-next-line @next/next/no-img-element -- spoljna slika, bez Vercel optimizacije (troši kvotu)
          <img
            src={slika}
            alt=""
            width={400}
            height={400}
            decoding="async"
            fetchPriority={mali ? "low" : "high"}
            onError={() => setBezSlike(true)}
          />
        )}
      </div>
      <p className="g-artikal-naziv">
        {naziv} <span>{kolicina}</span>
      </p>
    </div>
  );
}

// ───────────────────────── pitanje ─────────────────────────

export function CenaPitanje({
  pitanje,
  zakljucano,
  naPotvrdi,
}: {
  pitanje: PitanjeCena;
  zakljucano: boolean;
  naPotvrdi: (unos: number) => void;
}) {
  const [vrednost, setVrednost] = useState("");
  const polje = useRef<HTMLInputElement>(null);

  useEffect(() => {
    polje.current?.focus({ preventScroll: true });
  }, []);

  const unos = Number(vrednost);
  const mozeDaPosalje = vrednost !== "" && unos > 0 && !zakljucano;

  return (
    <section className="g-pitanje">
      <Artikal {...pitanje} />
      <form
        className="g-unos"
        onSubmit={(e) => {
          e.preventDefault();
          if (mozeDaPosalje) naPotvrdi(unos);
        }}
      >
        <label htmlFor="g-cena" className="g-unos-natpis">
          Koliko košta?
        </label>
        <div className="g-unos-red">
          <div className="g-unos-polje">
            <input
              ref={polje}
              id="g-cena"
              type="text"
              inputMode="numeric"
              pattern="[0-9]*"
              autoComplete="off"
              enterKeyHint="done"
              placeholder="0"
              value={vrednost}
              disabled={zakljucano}
              onChange={(e) => setVrednost(e.target.value.replace(/\D/g, "").replace(/^0+/, "").slice(0, NAJVISE_CIFARA))}
            />
            <span aria-hidden="true">din</span>
          </div>
          <button type="submit" className="btn g-unos-dugme" disabled={!mozeDaPosalje}>
            <IconStikla size={26} />
            <span>Potvrdi</span>
          </button>
        </div>
      </form>
    </section>
  );
}

// ───────────────────────── rezultat pitanja ─────────────────────────

/**
 * Jedan pogled: šta si uneo, koliko stvarno košta, koliko si promašio i koliko si poena dobio.
 */
export function CenaOcena({
  ocena,
  slika,
  niz,
  seme,
  naDalje,
  ceka,
}: {
  ocena: Ocena;
  slika: string;
  niz: number;
  seme: number;
  naDalje: () => void;
  ceka: boolean;
}) {
  const p = ocena.prikaz;
  const nalepnica = useRef<HTMLSpanElement>(null);
  const nivo = ocena.poeni === ocena.maxPoena ? "pun" : ocena.poeni > 0 ? "pola" : "nula";

  useEffect(() => {
    if (ocena.poeni > 0) poletiDoZbira(nalepnica.current, `+${ocena.poeni}`);
  }, [ocena.poeni]);

  return (
    <section className="g-ocena">
      <h1 className="g-komentar">{komentarCena(ocena, seme)}</h1>

      <div className={`g-rez ${nivo}`}>
        {ocena.poeni > 0 && <Konfete jacina={nivo === "pun" ? 2 : 1} />}
        <div className="g-rez-cene">
          <p>
            <span className="g-rez-natpis">Ti</span>
            <strong>{p.unos === null ? "—" : din(p.unos)}</strong>
          </p>
          <p>
            <span className="g-rez-natpis">Prava cena</span>
            <strong>{din(p.prava)}</strong>
          </p>
        </div>
        <div className="g-rez-dno">
          <span className="g-rez-procenat">{p.unos === null ? "bez odgovora" : p.procenat}</span>
          <span ref={nalepnica} className="g-nalepnica">
            {ocena.poeni > 0 ? `+${ocena.poeni}` : "0"} <small>{ocena.poeni === 1 ? "poen" : "poena"}</small>
          </span>
        </div>
      </div>

      {niz >= 2 && (
        <p className="g-niz">
          <IconVatra size={22} /> x{niz} zaredom
        </p>
      )}

      <p className="g-opseg">
        U radnjama od <strong>{din(p.min)}</strong> do <strong>{din(p.max)}</strong>
        {p.najjeftinije && (
          <>
            {" "}
            · najjeftinije u: <strong>{p.najjeftinije}</strong>
          </>
        )}
      </p>

      <Artikal naziv={p.naziv} kolicina={p.kolicina} slika={slika} mali />

      <button type="button" className="btn btn-lg g-dole" onClick={naDalje} disabled={ceka} autoFocus>
        <span>{ceka ? "Stiže…" : "Dalje"}</span>
        {!ceka && <IconStrelica size={26} />}
      </button>
    </section>
  );
}
