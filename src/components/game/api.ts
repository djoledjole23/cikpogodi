"use client";

import type { OdgovorServera, Stanje } from "@/lib/game/types";

const KLJUC_UREDJAJA = "cp_uredjaj";

/** Oznaka uređaja u localStorage (druga kopija je u kolačiću koji postavlja server). */
function uredjaj(): string | undefined {
  try {
    let id = window.localStorage.getItem(KLJUC_UREDJAJA);
    if (!id) {
      id = crypto.randomUUID();
      window.localStorage.setItem(KLJUC_UREDJAJA, id);
    }
    return id;
  } catch {
    return undefined; // privatni režim: ostaje samo kolačić
  }
}

export class NijeNaRedu extends Error {
  constructor(public stanje: Stanje) {
    super("nije_na_redu");
  }
}

async function posalji<T>(telo: Record<string, unknown>, uPozadini = false): Promise<T> {
  const odgovor = await fetch("/api/igra", {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify({ ...telo, deviceId: uredjaj() }),
    cache: "no-store",
    // Zahtev koji sme da preživi zatvaranje strane (pauza pesme kad igrač ode).
    keepalive: uPozadini,
  });
  if (odgovor.status === 409) {
    const podaci = (await odgovor.json()) as { stanje: Stanje };
    throw new NijeNaRedu(podaci.stanje);
  }
  if (!odgovor.ok) throw new Error(`server ${odgovor.status}`);
  return (await odgovor.json()) as T;
}

export const api = {
  stanje: (datum?: string) => posalji<Stanje>({ akcija: "stanje", datum }),
  start: () => posalji<Stanje>({ akcija: "start" }),
  pitanje: (datum: string) => posalji<Stanje>({ akcija: "pitanje", datum }),
  odgovor: (datum: string, itemId: number, odgovor: unknown, istek = false, slusanoMs?: number) =>
    posalji<OdgovorServera>({ akcija: "odgovor", datum, itemId, odgovor, istek, slusanoMs }),
  /** Pesma je puštena ili pauzirana. */
  slusanje: (datum: string, itemId: number, pusteno: boolean) =>
    posalji<Stanje>({ akcija: "slusanje", datum, itemId, pusteno }, true),
};

// ───── katalog pesama (za biranje odgovora) ─────

export type PesmaIzKataloga = { izvodjac: string; naslov: string };
let katalog: Promise<PesmaIzKataloga[]> | null = null;

/** Ceo spisak pesama (više hiljada). Učitava se jednom po poseti; ako ne uspe, sledeći poziv pokušava ponovo. */
export function katalogPesama(): Promise<PesmaIzKataloga[]> {
  katalog ??= fetch("/api/pesme")
    .then((o) => (o.ok ? o.json() : Promise.reject(new Error(`pesme ${o.status}`))))
    .then((p: { izvodjaci: [string, string[]][] }) => p.izvodjaci.flatMap(([izvodjac, naslovi]) => naslovi.map((naslov) => ({ izvodjac, naslov }))))
    .catch((e) => {
      katalog = null;
      throw e;
    });
  return katalog;
}
