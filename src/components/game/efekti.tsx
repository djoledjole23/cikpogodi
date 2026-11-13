"use client";

import { useEffect, useRef, useState, type CSSProperties } from "react";

export function smanjenoKretanje(): boolean {
  return typeof window !== "undefined" && window.matchMedia("(prefers-reduced-motion: reduce)").matches;
}

/** Broj koji se „vrti” do nove vrednosti (od `od`, ako je zadato). Uz smanjeno kretanje se samo promeni. */
export function useBrojac(cilj: number, trajanjeMs = 500, od?: number): number {
  const [prikaz, setPrikaz] = useState(od ?? cilj);
  const odakle = useRef(od ?? cilj);

  useEffect(() => {
    const start = odakle.current;
    if (start === cilj) return;
    if (smanjenoKretanje()) {
      odakle.current = cilj;
      const id = requestAnimationFrame(() => setPrikaz(cilj));
      return () => cancelAnimationFrame(id);
    }
    let raf = 0;
    const t0 = performance.now();
    const korak = (t: number) => {
      const p = Math.min(1, (t - t0) / trajanjeMs);
      const ublazeno = 1 - Math.pow(1 - p, 3);
      const sada = Math.round(start + (cilj - start) * ublazeno);
      odakle.current = sada;
      setPrikaz(sada);
      if (p < 1) raf = requestAnimationFrame(korak);
    };
    raf = requestAnimationFrame(korak);
    return () => cancelAnimationFrame(raf);
  }, [cilj, trajanjeMs]);

  return prikaz;
}

/** Deterministički „slučajan” broj 0–1 iz rednog broja, da se konfete ne menjaju pri ponovnom crtanju. */
const rnd = (i: number, so: number) => {
  const x = Math.sin(i * 127.1 + so * 311.7) * 43758.5453;
  return x - Math.floor(x);
};

/**
 * Kratke konfete iz sredine roditelja. Samo transform i opacity (ide preko GPU-a, ne koči ni slabiji telefon).
 * `jacina`: 1 = malo (pola poena), 2 = normalno, 3 = veliko (20 poena, rebus).
 */
export function Konfete({ jacina = 2 }: { jacina?: 1 | 2 | 3 }) {
  const [vidljive, setVidljive] = useState(() => !smanjenoKretanje());
  useEffect(() => {
    const id = setTimeout(() => setVidljive(false), 1300);
    return () => clearTimeout(id);
  }, []);
  if (!vidljive) return null;

  const broj = jacina === 1 ? 10 : jacina === 2 ? 22 : 40;
  const domet = jacina === 3 ? 190 : 140;
  return (
    <span className="g-konfete" aria-hidden="true">
      {Array.from({ length: broj }, (_, i) => {
        const ugao = rnd(i, 1) * Math.PI * 2;
        const daljina = domet * (0.45 + rnd(i, 2) * 0.55);
        const stil = {
          "--x": `${Math.round(Math.cos(ugao) * daljina)}px`,
          "--y": `${Math.round(Math.sin(ugao) * daljina - 40)}px`,
          "--r": `${Math.round(rnd(i, 3) * 540 - 270)}deg`,
          animationDelay: `${Math.round(rnd(i, 4) * 90)}ms`,
        } as CSSProperties;
        return <i key={i} className={i % 3 === 0 ? "kremast" : i % 3 === 1 ? "crven" : "okrugao"} style={stil} />;
      })}
    </span>
  );
}

/** Poeni „odlete” od nalepnice do zbira u zaglavlju. Vraća koliko animacija traje (0 ako je preskočena). */
export function poletiDoZbira(izvor: HTMLElement | null, tekst: string): number {
  const cilj = document.getElementById("g-zbir");
  if (!izvor || !cilj || smanjenoKretanje() || typeof izvor.animate !== "function") return 0;
  const a = izvor.getBoundingClientRect();
  const b = cilj.getBoundingClientRect();
  const leti = document.createElement("span");
  leti.className = "g-leti";
  leti.textContent = tekst;
  leti.style.left = `${a.left + a.width / 2}px`;
  leti.style.top = `${a.top + a.height / 2}px`;
  document.body.appendChild(leti);
  const dx = b.left + b.width / 2 - (a.left + a.width / 2);
  const dy = b.top + b.height / 2 - (a.top + a.height / 2);
  const trajanje = 520;
  leti
    .animate(
      [
        { transform: "translate(-50%, -50%) scale(1)", opacity: 1 },
        { transform: `translate(calc(-50% + ${dx * 0.5}px), calc(-50% + ${dy * 0.5 - 30}px)) scale(1.25)`, opacity: 1, offset: 0.5 },
        { transform: `translate(calc(-50% + ${dx}px), calc(-50% + ${dy}px)) scale(0.5)`, opacity: 0.4 },
      ],
      { duration: trajanje, delay: 350, easing: "cubic-bezier(.5,0,.6,1)", fill: "both" },
    )
    .finished.finally(() => leti.remove());
  return trajanje + 350;
}

/** Nalepnica sa poenima na rezultatu pitanja. Kad ima poena, oni odatle „odlete” u zbir. */
export function Nalepnica({ poeni }: { poeni: number }) {
  const ref = useRef<HTMLSpanElement>(null);
  useEffect(() => {
    if (poeni > 0) poletiDoZbira(ref.current, `+${poeni}`);
  }, [poeni]);
  return (
    <span ref={ref} className={poeni > 0 ? "g-nalepnica" : "g-nalepnica nula"}>
      {poeni > 0 ? `+${poeni}` : "0"} <small>poena</small>
    </span>
  );
}
