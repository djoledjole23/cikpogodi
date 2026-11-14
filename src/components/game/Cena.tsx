"use client";

import { useEffect, useRef, useState, type CSSProperties } from "react";
import { IconCena, IconStikla } from "@/components/icons";
import { din } from "@/lib/format";
import type { Ocena, PitanjeCena, PrikazCena } from "@/lib/game/types";
import { sfx } from "@/lib/sound";
import { Konfete, Nalepnica, Pecat, smanjenoKretanje, useBrojac } from "./efekti";

const NAJVISE_CIFARA = 6;

/** Slika i naziv artikla. Slike su sa Open Food Facts i učitavaju se direktno odatle. */
function Artikal({ naziv, kolicina, slika }: { naziv: string; kolicina: string; slika: string }) {
  // Ako slika ne stigne (Open Food Facts ne radi, link je zastareo), pitanje i dalje može da se igra po nazivu.
  const [bezSlike, setBezSlike] = useState(!slika);
  return (
    <div className="g-artikal">
      <div className={bezSlike ? "g-artikal-slika prazna" : "g-artikal-slika"}>
        {bezSlike ? (
          <IconCena size={64} />
        ) : (
          // eslint-disable-next-line @next/next/no-img-element -- spoljna slika, bez Vercel optimizacije (troši kvotu)
          <img
            src={slika}
            alt=""
            width={400}
            height={400}
            decoding="async"
            fetchPriority="high"
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
          if (!mozeDaPosalje) return;
          sfx.klik();
          naPotvrdi(unos);
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

/** Koliko traje napetost: igla klizi po meti, prava cena se „vrti”. */
const MERENJE_MS = 950;
/** Meta pokriva od −30% do +30% od prave cene. Dalje od toga igla stoji na ivici. */
const RASPON = 30;

/**
 * Meta: sredina je prava cena, crveno polje je ±10% (svi poeni), svetlije polje do ±15% (pola poena).
 * Igla pokazuje gde je pao igračev unos.
 */
function Meta({ unos, prava }: { unos: number; prava: number }) {
  const odstupanje = ((unos - prava) / prava) * 100;
  const x = Math.min(100, Math.max(0, ((odstupanje + RASPON) / (2 * RASPON)) * 100));
  return (
    <div className="g-meta" aria-hidden="true">
      <div className="g-meta-put">
        <span className="g-meta-pola" />
        <span className="g-meta-pun">10</span>
        <span className="g-meta-pet levo">5</span>
        <span className="g-meta-pet desno">5</span>
        <span className="g-meta-klizac" style={{ "--x": x, animationDuration: `${MERENJE_MS}ms` } as CSSProperties}>
          <i className="g-meta-igla" />
        </span>
      </div>
      <p className="g-meta-natpisi">
        <span>manje</span>
        <span>prava cena</span>
        <span>više</span>
      </p>
    </div>
  );
}

/** Jedan pogled: šta si uneo, koliko stvarno košta, koliko si promašio i koliko si poena dobio. */
export function CenaOcena({
  ocena,
  prikaz: p,
  otkriveno,
  naOtkrij,
}: {
  ocena: Ocena;
  prikaz: PrikazCena;
  /** Dok nije otkriveno, traje „merenje”: ne vidi se ni presuda ni poeni. */
  otkriveno: boolean;
  naOtkrij: () => void;
}) {
  const nivo = ocena.poeni === ocena.maxPoena ? "pun" : ocena.poeni > 0 ? "pola" : "nula";
  const prava = useBrojac(p.prava, MERENJE_MS, 0);

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
      <div className={otkriveno ? `g-rez ${nivo}` : "g-rez ceka"}>
        {otkriveno && ocena.poeni > 0 && <Konfete jacina={nivo === "pun" ? (p.unos === p.prava ? 3 : 2) : 1} />}
        <p className="g-rez-artikal">
          {p.naziv} <span>{p.kolicina}</span>
        </p>
        <div className="g-rez-cene">
          <p>
            <span className="g-rez-natpis">Ti</span>
            <strong>{p.unos === null ? "—" : din(p.unos)}</strong>
          </p>
          <p>
            <span className="g-rez-natpis">Prava cena</span>
            <strong>{din(otkriveno ? p.prava : prava)}</strong>
          </p>
        </div>
        {p.unos !== null && <Meta unos={p.unos} prava={p.prava} />}
        <div className={otkriveno ? "g-rez-dno" : "g-rez-dno skriveno"}>
          <span className="g-rez-procenat">{p.unos === null ? "bez odgovora" : p.procenat}</span>
          {otkriveno && (
            <span className="g-rez-presuda">
              <Pecat vrsta={p.unos === null ? "vreme" : nivo === "pun" ? "pogodak" : nivo === "pola" ? "blizu" : "promasaj"} />
              <Nalepnica poeni={ocena.poeni} />
            </span>
          )}
        </div>
      </div>

      <p className={otkriveno ? "g-opseg" : "g-opseg g-nevidljivo"}>
        U radnjama od <strong>{din(p.min)}</strong> do <strong>{din(p.max)}</strong>
        {p.najjeftinije && (
          <>
            {" "}
            · najjeftinije u: <strong>{p.najjeftinije}</strong>
          </>
        )}
      </p>

    </>
  );
}
