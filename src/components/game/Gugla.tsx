"use client";

import { useEffect, useRef, useState, type CSSProperties } from "react";
import { IconKruna, IconLupa, IconStrelica } from "@/components/icons";
import type { Ocena, PitanjeGugla, PrikazGugla } from "@/lib/game/types";
import { haptika, sfx } from "@/lib/sound";
import { Konfete, Nalepnica, Pecat, smanjenoKretanje, useBrojac, useKucanje } from "./efekti";

/**
 * „Šta se više gugla”: duel dva pojma u kome pobednik ostaje.
 * Ova komponenta živi kroz ceo segment. Kartica pobednika se ne crta ispočetka (isti ključ),
 * nego ostaje na svom mestu, a na mesto gubitnika uleće novi izazivač.
 */

/** Koliko traje „merenje” (trake se pune, brojevi rastu) pre nego što se vidi ko je pobedio. */
const MERENJE_MS = 850;
/** Posle koliko se sam prelazi na sledeći duel. */
const SAMO_DALJE_MS = 2400;

/** „KupujemProdajem” sme da se prelomi na mestu gde počinje veliko slovo (meka crtica), da stane u karticu. */
const saPrelomom = (naziv: string) => naziv.replace(/([a-zčćšžđ])([A-ZČĆŠŽĐ])/g, "$1­$2");

const broj1 = (x: number) => x.toLocaleString("sr-Latn-RS", { maximumFractionDigits: 1 });

type Faza = "pitanje" | "merenje" | "otkriveno";

function Brojac({ cilj }: { cilj: number }) {
  return <>{useBrojac(cilj, MERENJE_MS, 0)}</>;
}

function Kartica({
  strana,
  naziv,
  itemId,
  faza,
  indeks,
  pobednik,
  izabran,
  ispada,
  zakljucano,
  naTap,
}: {
  strana: "a" | "b";
  naziv: string;
  itemId: number;
  faza: Faza;
  indeks?: number;
  pobednik: boolean;
  izabran: boolean;
  ispada: boolean;
  zakljucano: boolean;
  naTap: () => void;
}) {
  // Kartica koja je preživela prethodni duel i dalje je ista komponenta, pa pamti u kom je duelu ušla.
  const [usao] = useState(itemId);
  const brani = usao !== itemId;
  const tekst = saPrelomom(naziv);
  const vidljivo = useKucanje(tekst, true, strana === "b" ? 140 : 0);
  const otkriveno = faza === "otkriveno";

  const klase = ["g-kartica", strana];
  if (izabran) klase.push("izabran");
  if (faza !== "pitanje") klase.push("meri");
  if (otkriveno) klase.push(pobednik ? "pobednik" : "gubitnik");
  if (ispada) klase.push("ispada");

  return (
    <button
      type="button"
      className={klase.join(" ")}
      aria-label={naziv}
      aria-disabled={faza !== "pitanje" || zakljucano}
      onClick={naTap}
    >
      <span className="g-kartica-vrh">
        <IconLupa size={22} />
        <span className="g-kartica-oznake">
          {brani && faza === "pitanje" && <span className="g-oznaka brani">brani titulu</span>}
          {izabran && <span className="g-oznaka izbor">tvoj izbor</span>}
          {otkriveno && pobednik && (
            <span className="g-oznaka kruna">
              <IconKruna size={18} strokeWidth={2.6} /> više se gugla
            </span>
          )}
        </span>
      </span>

      <span className="g-kartica-naziv" aria-hidden="true">
        {tekst.slice(0, vidljivo)}
        {faza === "pitanje" && <i className="g-kursor" />}
        <span className="g-nevidljivo">{tekst.slice(vidljivo)}</span>
      </span>

      <span className="g-kartica-mera" aria-hidden={faza === "pitanje"}>
        <span className="g-kartica-put">
          <i style={{ "--do": faza === "pitanje" ? 0 : Math.max(indeks ?? 0, 3) / 100 } as CSSProperties} />
        </span>
        <span className="g-kartica-broj">{faza === "pitanje" || indeks === undefined ? "?" : <Brojac key={itemId} cilj={indeks} />}</span>
      </span>

      {otkriveno && pobednik && izabran && <Konfete jacina={2} />}
    </button>
  );
}

export function GuglaDuel({
  itemId,
  pitanje,
  ocena,
  otkriveno,
  odlazi,
  zakljucano,
  komentar,
  naIzbor,
  naOtkrij,
  naDalje,
}: {
  itemId: number;
  pitanje: PitanjeGugla;
  /** Stiže kad server oceni odgovor. Dok je nema, traje pitanje. */
  ocena?: Ocena;
  otkriveno: boolean;
  /** Gubitnik ispada, čeka se sledeći duel. */
  odlazi: boolean;
  zakljucano: boolean;
  komentar: string;
  naIzbor: (izbor: "a" | "b") => void;
  naOtkrij: () => void;
  naDalje: () => void;
}) {
  const [tap, setTap] = useState<{ itemId: number; izbor: "a" | "b" } | null>(null);
  const tapnuto = tap?.itemId === itemId ? tap.izbor : null;
  const p = ocena?.prikaz.vrsta === "gugla" ? (ocena.prikaz as PrikazGugla) : undefined;
  const faza: Faza = !p ? "pitanje" : otkriveno ? "otkriveno" : "merenje";

  const otkrijRef = useRef(naOtkrij);
  const daljeRef = useRef(naDalje);
  useEffect(() => {
    otkrijRef.current = naOtkrij;
    daljeRef.current = naDalje;
  }, [naOtkrij, naDalje]);

  // Odgovor je stigao: trake se pune, pa se otkriva pobednik.
  const imaOcenu = Boolean(p);
  useEffect(() => {
    if (!imaOcenu) return;
    const ms = smanjenoKretanje() ? 0 : MERENJE_MS;
    if (ms) sfx.vrti(ms);
    const sat = setTimeout(() => otkrijRef.current(), ms);
    return () => clearTimeout(sat);
  }, [imaOcenu, itemId]);

  // Posle otkrivanja igra sama ide dalje (dugme „Dalje” samo ubrzava).
  useEffect(() => {
    if (faza !== "otkriveno" || odlazi) return;
    const sat = setTimeout(() => daljeRef.current(), SAMO_DALJE_MS);
    return () => clearTimeout(sat);
  }, [faza, odlazi, itemId]);

  const tapni = (izbor: "a" | "b") => {
    if (faza !== "pitanje" || zakljucano || tapnuto) return;
    setTap({ itemId, izbor });
    sfx.klik();
    haptika.tap();
    naIzbor(izbor);
  };

  const izabran = (s: "a" | "b") => (p ? p.izbor === s : tapnuto === s);
  const kartica = (s: "a" | "b") => (
    <Kartica
      key={s === "a" ? pitanje.a : pitanje.b}
      strana={s}
      naziv={s === "a" ? pitanje.a : pitanje.b}
      itemId={itemId}
      faza={faza}
      indeks={p ? (s === "a" ? p.indeksA : p.indeksB) : undefined}
      pobednik={p?.tacan === s}
      izabran={izabran(s)}
      ispada={odlazi && Boolean(p) && p!.tacan !== s}
      zakljucano={zakljucano}
      naTap={() => tapni(s)}
    />
  );

  return (
    <section className="g-duel">
      {/* Isti red drži naslov, a posle odgovora presudu: kartice se zato ne pomeraju. */}
      <div className="g-duel-vrh">
        {faza === "otkriveno" && ocena && p ? (
          <p key={`r${itemId}`} className="g-duel-presuda" role="status">
            <Pecat vrsta={p.izbor === null ? "vreme" : ocena.tacno ? "pogodak" : "promasaj"} />
            <Nalepnica poeni={ocena.poeni} />
          </p>
        ) : (
          <h1 className="g-duel-naslov">Šta se više gugla?</h1>
        )}
      </div>

      <div className="g-duel-arena">
        {kartica("a")}
        <div className="g-duel-sredina" aria-hidden="true">
          <span className={faza === "pitanje" ? "g-ili" : "g-ili sklonjen"}>ili</span>
        </div>
        {kartica("b")}
      </div>

      {faza === "pitanje" && <p className="g-opseg center">Tapni pojam koji se u Srbiji više tražio na Guglu. Pobednik ostaje.</p>}
      {faza === "merenje" && <p className="g-opseg center">Brojimo pretrage…</p>}
      {faza === "otkriveno" && p && (
        <div key={`k${itemId}`} className="g-duel-ishod">
          <p className="g-duel-komentar">{komentar}</p>
          <p className="g-opseg">
            <strong>{p.tacan === "a" ? p.a : p.b}</strong>: {broj1(p.puta)} puta više pretraga.
            <span className="g-duel-izvor"> Google Trends, Srbija, {p.period}.</span>
          </p>
          <button type="button" className="btn btn-lg g-dole g-samo-dalje" onClick={naDalje} aria-disabled={zakljucano} autoFocus>
            <i className="g-samo-dalje-traka" style={{ animationDuration: `${SAMO_DALJE_MS}ms` }} />
            <span>Dalje</span>
            <IconStrelica size={26} />
          </button>
        </div>
      )}
    </section>
  );
}
