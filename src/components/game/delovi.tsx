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
import { Konfete, useBrojac } from "./efekti";

// ───────────────────────── zaglavlje igre ─────────────────────────

/** Stalno vidljivo: gde sam (segment X/5, pitanje Y/N) i koliko imam poena. */
export function Zaglavlje({
  segment,
  pozicija,
  ukupno,
  zbir,
}: {
  segment?: number;
  pozicija?: number;
  ukupno?: number;
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

  return (
    <header className="g-top">
      <p className="g-gde">
        {segment !== undefined && (
          <span className="g-gde-seg">
            Segment {segment}/{SEGMENTI.length}
          </span>
        )}
        {pozicija !== undefined && ukupno !== undefined && (
          <span className="g-gde-pit">
            Pitanje {pozicija}/{ukupno}
          </span>
        )}
      </p>
      <p id="g-zbir" className={skok ? "g-zbir skok" : "g-zbir"} aria-live="polite">
        <span className="sr-only">Zbir: </span>
        <strong>{broj(prikaz)}</strong> <span>poena</span>
      </p>
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
          <strong>{segment.pitanja}</strong> {segment.pitanja === 1 ? "pitanje" : "pitanja"}
        </li>
        <li>
          <strong>{k.limitS} s</strong> po pitanju
        </li>
        <li>
          do <strong>{segment.max}</strong> poena
        </li>
      </ul>
      <button type="button" className="btn btn-lg g-dole" onClick={naKreni} aria-disabled={ceka} autoFocus>
        <span>{ceka ? "Stiže…" : "Kreni"}</span>
        {!ceka && <IconStrelica size={26} />}
      </button>
    </section>
  );
}

// ───────────────────────── kraj segmenta ─────────────────────────

export function KrajSegmenta({ segment, naDalje }: { segment: SegmentStanje; naDalje: () => void }) {
  useEffect(() => {
    sfx.fanfare();
  }, []);
  const prikaz = useBrojac(segment.poeni, 900);
  return (
    <section className="g-uvod">
      <span className="g-uvod-ikona">
        <SegmentIcon segment={segment.key} size={56} />
        {segment.poeni > 0 && <Konfete jacina={segment.poeni === segment.max ? 3 : 2} />}
      </span>
      <p className="g-uvod-broj">Gotov segment</p>
      <h1 className="h1">{segment.naziv}</h1>
      <p className="g-veliki-zbir">
        {broj(prikaz)}
        <small> / {segment.max}</small>
      </p>
      <p className="lead">{komentarSegmenta(segment)}</p>
      <button type="button" className="btn btn-lg g-dole" onClick={naDalje} autoFocus>
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

/** Zajedničko za sve segmente: komentar gore, niz tačnih, sadržaj segmenta u sredini, „Dalje” dole. */
export function OkvirOcene({
  komentar,
  niz,
  children,
  naDalje,
  ceka,
}: {
  komentar: string;
  niz: number;
  children: ReactNode;
  naDalje: () => void;
  ceka: boolean;
}) {
  return (
    <section className="g-ocena">
      <h1 className="g-komentar">{komentar}</h1>
      {children}
      {niz >= 2 && (
        <p className="g-niz">
          <IconVatra size={22} /> x{niz} zaredom
        </p>
      )}
      <button type="button" className="btn btn-lg g-dole" onClick={naDalje} aria-disabled={ceka} autoFocus>
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
