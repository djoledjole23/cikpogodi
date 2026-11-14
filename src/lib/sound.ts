"use client";

/**
 * Svi zvukovi se prave u hodu kroz Web Audio API. Nema nijednog audio fajla.
 * Podešavanje (uključen/isključen) se pamti u localStorage.
 */

const KLJUC = "cp_zvuk";
const DOGADJAJ = "cp:zvuk";

let ctx: AudioContext | null = null;

export function zvukUkljucen(): boolean {
  try {
    return window.localStorage.getItem(KLJUC) !== "0";
  } catch {
    return true;
  }
}

export function postaviZvuk(ukljucen: boolean) {
  try {
    window.localStorage.setItem(KLJUC, ukljucen ? "1" : "0");
  } catch {
    // privatni režim: važi samo do zatvaranja strane
  }
  window.dispatchEvent(new Event(DOGADJAJ));
}

export function pratiZvuk(callback: () => void) {
  window.addEventListener(DOGADJAJ, callback);
  window.addEventListener("storage", callback);
  return () => {
    window.removeEventListener(DOGADJAJ, callback);
    window.removeEventListener("storage", callback);
  };
}

function audio(): AudioContext | null {
  if (typeof window === "undefined" || !zvukUkljucen()) return null;
  if (!ctx) {
    const Ctor =
      window.AudioContext ??
      (window as unknown as { webkitAudioContext?: typeof AudioContext }).webkitAudioContext;
    if (!Ctor) return null;
    ctx = new Ctor();
  }
  if (ctx.state === "suspended") void ctx.resume();
  return ctx;
}

type Ton = {
  frekvencija: number;
  /** kad počinje, u sekundama od sada */
  od?: number;
  trajanje: number;
  oblik?: OscillatorType;
  jacina?: number;
  /** ako je zadato, ton klizi do ove frekvencije */
  klizi?: number;
};

function sviraj(tonovi: Ton[]) {
  const a = audio();
  if (!a) return;
  const sad = a.currentTime;
  for (const t of tonovi) {
    const pocetak = sad + (t.od ?? 0);
    const osc = a.createOscillator();
    const gain = a.createGain();
    osc.type = t.oblik ?? "sine";
    osc.frequency.setValueAtTime(t.frekvencija, pocetak);
    if (t.klizi) osc.frequency.exponentialRampToValueAtTime(t.klizi, pocetak + t.trajanje);
    const jacina = t.jacina ?? 0.14;
    gain.gain.setValueAtTime(0.0001, pocetak);
    gain.gain.exponentialRampToValueAtTime(jacina, pocetak + 0.012);
    gain.gain.exponentialRampToValueAtTime(0.0001, pocetak + t.trajanje);
    osc.connect(gain).connect(a.destination);
    osc.start(pocetak);
    osc.stop(pocetak + t.trajanje + 0.03);
  }
}

// Durska lestvica od C5: svaki sledeći tačan odgovor zaredom zvuči za stepenik više.
const LESTVICA = [523.25, 587.33, 659.25, 698.46, 783.99, 880, 987.77, 1046.5];

export const sfx = {
  /** Klik na dugme. */
  klik() {
    sviraj([{ frekvencija: 420, klizi: 260, trajanje: 0.06, oblik: "triangle", jacina: 0.1 }]);
  },
  /** Tik tajmera u poslednje 3 sekunde. */
  tik() {
    sviraj([{ frekvencija: 1100, trajanje: 0.045, oblik: "square", jacina: 0.05 }]);
  },
  /** Tačno. `niz` = koliko je tačnih zaredom (1, 2, 3...), ton raste sa nizom. */
  ding(niz = 1) {
    const i = Math.min(Math.max(niz, 1), LESTVICA.length) - 1;
    const f = LESTVICA[i];
    sviraj([
      { frekvencija: f, trajanje: 0.16, oblik: "triangle", jacina: 0.16 },
      { frekvencija: f * 1.5, od: 0.07, trajanje: 0.26, oblik: "sine", jacina: 0.13 },
    ]);
  },
  /** Netačno: tup „bonk”. */
  bonk() {
    sviraj([
      { frekvencija: 160, klizi: 70, trajanje: 0.22, oblik: "sine", jacina: 0.22 },
      { frekvencija: 95, trajanje: 0.12, oblik: "square", jacina: 0.05 },
    ]);
  },
  /** Nešto uleće na ekran (novi pojam, novo pitanje). */
  vuus() {
    sviraj([{ frekvencija: 240, klizi: 880, trajanje: 0.16, oblik: "sine", jacina: 0.07 }]);
  },
  /** Jedno slovo dok se pojam „kuca”. */
  kucaj() {
    sviraj([{ frekvencija: 1500, trajanje: 0.022, oblik: "square", jacina: 0.025 }]);
  },
  /** Napetost pred rezultat: sitni tikovi koji ubrzavaju i rastu, ukupno `ms` milisekundi. */
  vrti(ms = 800) {
    const tonovi: Ton[] = [];
    const koraka = Math.max(6, Math.round(ms / 70));
    for (let i = 0; i < koraka; i++) {
      // Razmak između tikova se smanjuje ka kraju.
      const udeo = i / koraka;
      tonovi.push({
        frekvencija: 520 + 620 * udeo,
        od: (ms / 1000) * (1 - Math.pow(1 - udeo, 1.6)),
        trajanje: 0.035,
        oblik: "triangle",
        jacina: 0.05 + 0.04 * udeo,
      });
    }
    sviraj(tonovi);
  },
  /** Pečat lupi o rezultat. */
  pecat() {
    sviraj([
      { frekvencija: 110, klizi: 55, trajanje: 0.14, oblik: "sine", jacina: 0.25 },
      { frekvencija: 320, trajanje: 0.04, oblik: "square", jacina: 0.04 },
    ]);
  },
  /** Odbrojavanje pred segment: 3, 2, 1 pa „kreni”. */
  odbroj(kreni = false) {
    if (kreni) {
      sviraj([
        { frekvencija: 783.99, trajanje: 0.3, oblik: "triangle", jacina: 0.16 },
        { frekvencija: 1174.66, od: 0.02, trajanje: 0.34, oblik: "sine", jacina: 0.12 },
      ]);
    } else {
      sviraj([{ frekvencija: 392, trajanje: 0.13, oblik: "triangle", jacina: 0.15 }]);
    }
  },
  /** Zvezdica na kraju segmenta: prva, druga, treća (svaka viša). */
  zvezda(redni = 1) {
    const f = [659.25, 830.61, 1046.5][Math.min(Math.max(redni, 1), 3) - 1];
    sviraj([
      { frekvencija: f, trajanje: 0.2, oblik: "triangle", jacina: 0.15 },
      { frekvencija: f * 2, od: 0.03, trajanje: 0.26, oblik: "sine", jacina: 0.07 },
    ]);
  },
  /** Kraj segmenta. */
  fanfare() {
    const note = [523.25, 659.25, 783.99, 1046.5];
    sviraj([
      ...note.map((f, i) => ({ frekvencija: f, od: i * 0.11, trajanje: 0.18, oblik: "triangle" as const, jacina: 0.15 })),
      { frekvencija: 1318.5, od: 0.46, trajanje: 0.5, oblik: "triangle", jacina: 0.14 },
      { frekvencija: 783.99, od: 0.46, trajanje: 0.5, oblik: "sine", jacina: 0.1 },
    ]);
  },
};

/** Haptika (radi na Androidu; iOS je ignoriše). */
export const haptika = {
  tacno() {
    if (mozeVibracija()) navigator.vibrate?.(30);
  },
  netacno() {
    if (mozeVibracija()) navigator.vibrate?.([40, 60, 40]);
  },
  /** Kratak dodir (tap na karticu, odbrojavanje). */
  tap() {
    if (mozeVibracija()) navigator.vibrate?.(12);
  },
};

function mozeVibracija() {
  return typeof navigator !== "undefined" && typeof navigator.vibrate === "function";
}
