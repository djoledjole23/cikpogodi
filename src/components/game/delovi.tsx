"use client";

import Link from "next/link";
import { useEffect, useRef, useState, type CSSProperties, type ReactNode } from "react";
import { IconStrelica, IconVatra, SegmentIcon } from "@/components/icons";
import { SoundToggle } from "@/components/SoundToggle";
import { SEGMENTI } from "@/config/quiz.config";
import { broj, din } from "@/lib/format";
import { komentarSegmenta } from "@/lib/game/komentari";
import type { Prikaz, SegmentStanje, Stanje } from "@/lib/game/types";
import { sfx } from "@/lib/sound";
import { brojZvezdica, Konfete, smanjenoKretanje, useBrojac, Zvezde } from "./efekti";

// ───────────────────────── zaglavlje igre ─────────────────────────

/**
 * Stalno vidljivo: u kom sam segmentu, kako su prošla pitanja do sada (tačkice), niz pogodaka i zbir.
 * `tok` su ishodi već odgovorenih pitanja u segmentu, `pozicija` je pitanje koje je sad na redu.
 */
export function Zaglavlje({
  segment,
  pozicija,
  ukupno,
  tok,
  niz = 0,
  zbir,
}: {
  segment?: number;
  pozicija?: number;
  ukupno?: number;
  tok?: (0 | 1 | 2)[];
  niz?: number;
  zbir: number;
}) {
  const prikaz = useBrojac(zbir);
  const [skok, setSkok] = useState(false);
  const prethodni = useRef(zbir);

  useEffect(() => {
    if (prethodni.current === zbir) return;
    prethodni.current = zbir;
    const pali = requestAnimationFrame(() => setSkok(true));
    const gasi = setTimeout(() => setSkok(false), 450);
    return () => {
      cancelAnimationFrame(pali);
      clearTimeout(gasi);
    };
  }, [zbir]);

  const naziv = segment !== undefined ? SEGMENTI.find((s) => s.n === segment)?.naziv : undefined;

  return (
    <header className="g-top">
      <div className="g-gde">
        {segment !== undefined && (
          <span className="g-gde-seg">
            {segment}/{SEGMENTI.length} · {naziv}
          </span>
        )}
        {ukupno !== undefined && (
          <>
            <span className="g-tacke" aria-hidden="true">
              {Array.from({ length: ukupno }, (_, i) => {
                const ishod = tok?.[i];
                const klasa =
                  ishod === undefined ? (i === (pozicija ?? 0) - 1 ? "sada" : "") : ishod === 2 ? "pun" : ishod === 1 ? "pola" : "nula";
                return <i key={i} className={`g-tacka ${klasa}`} />;
              })}
            </span>
            {pozicija !== undefined && (
              <span className="sr-only">
                Pitanje {pozicija} od {ukupno}
              </span>
            )}
          </>
        )}
      </div>
      <div className="g-zbir-omot">
        {niz >= 2 && (
          <span key={niz} className="g-niz" aria-label={`${niz} pogodaka zaredom`}>
            <IconVatra size={16} strokeWidth={2.8} />x{niz}
          </span>
        )}
        <p id="g-zbir" className={skok ? "g-zbir skok" : "g-zbir"} aria-live="polite">
          <span className="sr-only">Zbir: </span>
          <strong>{broj(prikaz)}</strong> <span>poena</span>
        </p>
      </div>
      <SoundToggle />
    </header>
  );
}

// ───────────────────────── tajmer ─────────────────────────

/**
 * Traka koja se prazni. Poslednje 3 sekunde pocrveni i kucka.
 * `kljuc` se menja sa svakim pitanjem, pa se traka i satovi prave ispočetka.
 */
export function Tajmer({
  limitMs,
  preostaloMs,
  zaustavljen,
  naIstek,
}: {
  limitMs: number;
  preostaloMs: number;
  zaustavljen: boolean;
  naIstek: () => void;
}) {
  const [sekunde, setSekunde] = useState(() => Math.ceil(preostaloMs / 1000));
  const istekRef = useRef(naIstek);
  useEffect(() => {
    istekRef.current = naIstek;
  }, [naIstek]);

  useEffect(() => {
    if (zaustavljen) return;
    const kraj = performance.now() + preostaloMs;
    let poslednjiTik = 4;
    const id = setInterval(() => {
      const ostalo = kraj - performance.now();
      const s = Math.max(0, Math.ceil(ostalo / 1000));
      setSekunde(s);
      if (s <= 3 && s >= 1 && s < poslednjiTik) {
        poslednjiTik = s;
        sfx.tik();
      }
      if (ostalo <= 0) {
        clearInterval(id);
        istekRef.current();
      }
    }, 100);
    return () => clearInterval(id);
    // Namerno samo pri pokretanju i zaustavljanju: `preostaloMs` je početna vrednost za ovo pitanje.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [zaustavljen]);

  const kriticno = sekunde <= 3;
  const stil = {
    "--od": Math.min(1, preostaloMs / limitMs),
    animationDuration: `${preostaloMs}ms`,
    animationPlayState: zaustavljen ? "paused" : "running",
  } as CSSProperties;

  return (
    <div className={kriticno ? "g-tajmer kriticno" : "g-tajmer"} role="timer" aria-label={`Preostalo ${sekunde} sekundi`}>
      <div className="g-tajmer-traka">
        <span style={stil} />
      </div>
      <span className="g-tajmer-broj" aria-hidden="true">
        {sekunde}
      </span>
    </div>
  );
}

// ───────────────────────── ekran pre segmenta ─────────────────────────

// Napomena za „Kreni” i „Dalje”: dok zahtev traje dugme je samo označeno kao zauzeto (aria-disabled), ne i
// stvarno isključeno. Isključeno dugme ne može da primi fokus, pa Enter na tastaturi ne bi radio.
// Dupli klik ionako ne prolazi: Igra propušta samo jedan zahtev u isto vreme.
export function UvodSegmenta({ segment, naKreni, ceka }: { segment: SegmentStanje; naKreni: () => void; ceka: boolean }) {
  const k = SEGMENTI.find((s) => s.n === segment.n)!;
  return (
    <section className="g-uvod">
      <span className="g-uvod-ikona">
        <SegmentIcon segment={segment.key} size={56} />
      </span>
      <p className="g-uvod-broj">
        Segment {segment.n} od {SEGMENTI.length}
      </p>
      <h1 className="h1">{segment.naziv}</h1>
      <p className="lead">{segment.pravilo}</p>
      <ul className="g-uvod-cinjenice">
        <li>
          <strong>{segment.pitanja}</strong> {segment.key === "pesma" ? "pesama" : segment.pitanja === 1 ? "pitanje" : "pitanja"}
        </li>
        <li>
          {segment.key === "pesma" ? (
            <>
              klip od <strong>{k.limitS} s</strong>
            </>
          ) : (
            <>
              <strong>{k.limitS} s</strong> po pitanju
            </>
          )}
        </li>
        <li>
          do <strong>{segment.max}</strong> poena
        </li>
      </ul>
      <button
        type="button"
        className="btn btn-lg g-dole"
        onClick={() => {
          sfx.klik();
          naKreni();
        }}
        aria-disabled={ceka}
        autoFocus
      >
        <span>{ceka ? "Stiže…" : "Kreni"}</span>
        {!ceka && <IconStrelica size={26} />}
      </button>
    </section>
  );
}

// ───────────────────────── kraj segmenta ─────────────────────────

export function KrajSegmenta({ segment, naDalje }: { segment: SegmentStanje; naDalje: () => void }) {
  const zvezdice = brojZvezdica(segment.poeni, segment.max);
  useEffect(() => {
    // Zbir se „vrti” uz tikove, pa se pale zvezdice. Fanfara ide samo za sve tri.
    if (smanjenoKretanje()) return;
    sfx.vrti(850);
    if (zvezdice < 3) return;
    const sat = setTimeout(() => sfx.fanfare(), 950 + 3 * 330);
    return () => clearTimeout(sat);
  }, [zvezdice]);
  const prikaz = useBrojac(segment.poeni, 900, 0);
  return (
    <section className="g-uvod g-kraj-seg">
      <p className="g-uvod-broj">Gotov segment</p>
      <h1 className="h1">{segment.naziv}</h1>
      <div className="g-kraj-seg-zvezde">
        <Zvezde broj={zvezdice} kasnjenjeMs={950} />
        {zvezdice > 0 && <Konfete jacina={zvezdice === 3 ? 3 : 2} kasnjenjeMs={smanjenoKretanje() ? 0 : 950 + (zvezdice - 1) * 330} />}
      </div>
      <p className="g-veliki-zbir">
        {broj(prikaz)}
        <small> / {segment.max}</small>
      </p>
      <p className="lead">{komentarSegmenta(segment)}</p>
      <button
        type="button"
        className="btn btn-lg g-dole"
        onClick={() => {
          sfx.klik();
          naDalje();
        }}
        autoFocus
      >
        <span>Dalje</span>
        <IconStrelica size={26} />
      </button>
    </section>
  );
}

// ───────────────────────── kraj (privremeni ekran dok ne stignu rezultat i rang lista) ─────────────────────────

export function Kraj({ stanje }: { stanje: Stanje }) {
  const max = stanje.segmenti.reduce((z, s) => z + s.max, 0);
  return (
    <section className="stack-lg">
      <div className="stack">
        <p className="g-uvod-broj">Kraj za danas</p>
        <p className="g-veliki-zbir">
          {broj(stanje.score)}
          <small> / {max}</small>
        </p>
        <p className="muted small">
Za sada se igraju „Pogodi cenu” i „Šta se više gugla”. Ostali segmenti, čuvanje rezultata i rang lista
          stižu u sledećim koracima.
        </p>
      </div>

      {stanje.segmenti.map((seg) => (
        <div key={seg.n} className="stack">
          <h2 className="h2 g-rez-naslov">
            <span>{seg.naziv}</span>
            <span>
              {seg.poeni}/{seg.max}
            </span>
          </h2>
          <ol className="g-lista">
            {stanje.rezultat
              ?.filter((r) => r.segment === seg.n)
              .map((r) => (
                <li key={r.pozicija} className={r.poeni > 0 ? "g-red" : "g-red promasaj"}>
                  <span className="g-red-tekst">
                    <RedRezultata prikaz={r.prikaz} />
                  </span>
                  <span className="g-red-poeni">{r.poeni > 0 ? `+${r.poeni}` : "0"}</span>
                </li>
              ))}
          </ol>
        </div>
      ))}

      <Link href="/" className="btn">
        Na početnu
      </Link>
    </section>
  );
}

function RedRezultata({ prikaz: p }: { prikaz: Prikaz }) {
  if (p.vrsta === "pesma") {
    const sek = (p.slusanoMs / 1000).toLocaleString("sr-Latn-RS", { minimumFractionDigits: 1, maximumFractionDigits: 1 });
    return (
      <>
        <strong>
          {p.izvodjac} – {p.naslov}
        </strong>
        <span>
          {p.tacno ? `Pogođeno posle ${sek} s slušanja` : p.neZnam ? "Ne znam" : p.odgovor ? `Ti: ${p.odgovor}` : "bez odgovora"}
        </span>
      </>
    );
  }
  if (p.vrsta === "cena") {
    return (
      <>
        <strong>
          {p.naziv} <span className="muted">{p.kolicina}</span>
        </strong>
        <span>
          Ti: {p.unos === null ? "bez odgovora" : din(p.unos)} · Prava: {din(p.prava)}
        </span>
      </>
    );
  }
  const naziv = (strana: "a" | "b") => (strana === "a" ? p.a : p.b);
  return (
    <>
      <strong>
        {p.a} ili {p.b}
      </strong>
      <span>
        Ti: {p.izbor === null ? "bez odgovora" : naziv(p.izbor)} · Više se gugla: {naziv(p.tacan)}
      </span>
    </>
  );
}

// ───────────────────────── okvir rezultata pitanja ─────────────────────────

/**
 * Zajedničko za rezultat pitanja: komentar gore, sadržaj segmenta u sredini, „Dalje” dole.
 * Dok rezultat nije otkriven (igla još klizi), umesto komentara stoji `najava`, a „Dalje” čeka.
 */
export function OkvirOcene({
  komentar,
  najava,
  otkriveno,
  children,
  naDalje,
  ceka,
}: {
  komentar: string;
  najava: string;
  otkriveno: boolean;
  children: ReactNode;
  naDalje: () => void;
  ceka: boolean;
}) {
  return (
    <section className="g-ocena">
      <h1 key={otkriveno ? "komentar" : "najava"} className={otkriveno ? "g-komentar stigao" : "g-komentar"} role="status">
        {otkriveno ? komentar : najava}
      </h1>
      {children}
      <button
        type="button"
        className="btn btn-lg g-dole"
        onClick={() => {
          if (!otkriveno) return;
          sfx.klik();
          naDalje();
        }}
        aria-disabled={ceka || !otkriveno}
        autoFocus
      >
        <span>{ceka ? "Stiže…" : "Dalje"}</span>
        {!ceka && <IconStrelica size={26} />}
      </button>
    </section>
  );
}

// ───────────────────────── poruke ─────────────────────────

export function Poruka({ naslov, children, dugme }: { naslov: string; children: ReactNode; dugme?: ReactNode }) {
  return (
    <section className="stack-lg">
      <div className="stack">
        <h1 className="h1">{naslov}</h1>
        <p className="lead">{children}</p>
      </div>
      {dugme}
      <Link href="/" className="btn btn-ghost">
        Nazad na početnu
      </Link>
    </section>
  );
}
