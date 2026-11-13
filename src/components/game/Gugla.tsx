"use client";

import { useState, type CSSProperties } from "react";
import type { Ocena, PitanjeGugla, PrikazGugla } from "@/lib/game/types";
import { Konfete, Nalepnica, useBrojac } from "./efekti";

/** „KupujemProdajem” sme da se prelomi na mestu gde počinje veliko slovo (meka crtica), da stane u uzanu karticu. */
const saPrelomom = (naziv: string) => naziv.replace(/([a-zčćšžđ])([A-ZČĆŠŽĐ])/g, "$1\u00AD$2");

// ───────────────────────── pitanje ─────────────────────────

export function GuglaPitanje({
  pitanje,
  zakljucano,
  naIzbor,
}: {
  pitanje: PitanjeGugla;
  zakljucano: boolean;
  naIzbor: (izbor: "a" | "b") => void;
}) {
  const [tapnuto, setTapnuto] = useState<"a" | "b" | null>(null);
  const tapni = (izbor: "a" | "b") => {
    if (zakljucano || tapnuto) return;
    setTapnuto(izbor);
    naIzbor(izbor);
  };
  const klasa = (izbor: "a" | "b") => (tapnuto === izbor ? "g-pojam tapnut" : "g-pojam");

  return (
    <section className="g-pitanje g-gugla">
      <h1 className="g-komentar">Šta se više gugla?</h1>
      <div className="g-gugla-izbor">
        <button type="button" className={klasa("a")} onClick={() => tapni("a")} disabled={zakljucano && tapnuto !== "a"}>
          {saPrelomom(pitanje.a)}
        </button>
        <span className="g-ili" aria-hidden="true">
          ili
        </span>
        <button type="button" className={klasa("b")} onClick={() => tapni("b")} disabled={zakljucano && tapnuto !== "b"}>
          {saPrelomom(pitanje.b)}
        </button>
      </div>
      <p className="g-opseg center">Tapni pojam koji se u Srbiji više tražio na Guglu za poslednjih 12 meseci.</p>
    </section>
  );
}

// ───────────────────────── rezultat pitanja ─────────────────────────

function Traka({ naziv, indeks, pobednik, izabran }: { naziv: string; indeks: number; pobednik: boolean; izabran: boolean }) {
  const broj = useBrojac(indeks, 700, 0);
  return (
    <div className={pobednik ? "g-traka pobednik" : "g-traka"}>
      <p className="g-traka-naziv">
        <strong>{naziv}</strong>
        {izabran && <span className="g-traka-izbor">tvoj izbor</span>}
      </p>
      <div className="g-traka-red">
        <div className="g-traka-put">
          <span style={{ "--do": `${Math.max(indeks, 3)}%` } as CSSProperties} />
        </div>
        <span className="g-traka-broj">{broj}</span>
      </div>
    </div>
  );
}

/** Dve trake koje se pune: ko se više gugla, šta si ti tapnuo i koliko si poena dobio. */
export function GuglaOcena({ ocena, prikaz: p }: { ocena: Ocena; prikaz: PrikazGugla }) {
  return (
    <>
      <div className={ocena.tacno ? "g-trake pogodak" : "g-trake promasaj"}>
        {ocena.tacno && <Konfete jacina={1} />}
        <Traka naziv={p.a} indeks={p.indeksA} pobednik={p.tacan === "a"} izabran={p.izbor === "a"} />
        <Traka naziv={p.b} indeks={p.indeksB} pobednik={p.tacan === "b"} izabran={p.izbor === "b"} />
        <div className="g-rez-dno">
          <span className="g-rez-procenat">{p.izbor === null ? "bez odgovora" : ocena.tacno ? "tačno" : "netačno"}</span>
          <Nalepnica poeni={ocena.poeni} />
        </div>
      </div>
      <p className="g-opseg">
        Google Trends, Srbija, {p.period}. Broj je odnos pretraga: pojam koji se više tražio ima 100.
      </p>
    </>
  );
}
