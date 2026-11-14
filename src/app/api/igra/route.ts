import { NextResponse, type NextRequest } from "next/server";
import { MAX_UKUPNO } from "@/config/quiz.config";
import { getDb, privremenaBaza } from "@/lib/db";
import { GreskaIgre, odgovori, posaljiPitanje, slusanje, stanjeIgre, zapocniIgru } from "@/lib/game/engine";
import { obezbediIdentitet } from "@/lib/game/identity";
import { dopuniStanje } from "@/lib/game/lista";
import type { Stanje } from "@/lib/game/types";
import { staFaliSupabase, supabasePodesen } from "@/lib/supabase/env";
import { beogradskiDatum, dodajDane } from "@/lib/time";

/**
 * Jedina ulazna tačka igre. Browser šalje `akcija` i dobija stanje (bez tačnih odgovora).
 *   stanje   – gde sam stao
 *   start    – počni današnju igru
 *   pitanje  – daj mi tekuće pitanje i pokreni vreme
 *   odgovor  – evo odgovora (ili `istek: true` kad je vreme prošlo)
 *   slusanje – pesma je puštena ili pauzirana (server sabira preslušano vreme)
 */
let upozoreno = false;
function upozori() {
  if (upozoreno) return;
  const fali = staFaliSupabase();
  if (!fali) return;
  upozoreno = true;
  console.error(
    `\n[nalozi] Nalozi ne rade jer u .env.local fali: ${fali}.\n` +
      "   Popuni ih (dupli klik na podesi.bat), pa ugasi ovaj prozor i pokreni pokreni.bat ponovo.\n",
  );
}

export async function POST(request: NextRequest) {
  let telo: Record<string, unknown>;
  try {
    telo = (await request.json()) as Record<string, unknown>;
  } catch {
    return NextResponse.json({ greska: "los_zahtev" }, { status: 400 });
  }

  const danas = beogradskiDatum();
  const db = await getDb();
  if (!db) {
    const prazno: Stanje = { status: "nije_povezano", datum: danas, score: 0, maxUkupno: MAX_UKUPNO, segmenti: [] };
    return NextResponse.json(prazno);
  }

  // Jednom po pokretanju: ako nalozi ne rade, reci u konzoli šta tačno fali u .env.local.
  upozori();

  const ident = await obezbediIdentitet(telo.deviceId);

  // Igra započeta malo pre ponoći se završava i posle ponoći, pod jučerašnjim datumom.
  let datum = danas;
  const juce = dodajDane(danas, -1);
  if (telo.datum === juce && telo.akcija !== "start") {
    const jucerasnje = await stanjeIgre(db, ident, juce);
    if (jucerasnje.status === "u_toku" || jucerasnje.status === "zavrseno") datum = juce;
  }

  // Uz stanje idu i podaci o nalogu i mesto na rang listi (ekran „Sačuvaj rezultat” i ekran rezultata).
  const dopuni = (stanje: Stanje) => dopuniStanje(db, ident, stanje, supabasePodesen(), privremenaBaza());

  try {
    switch (telo.akcija) {
      case "stanje":
        return NextResponse.json(await dopuni(await stanjeIgre(db, ident, datum)));
      case "start":
        return NextResponse.json(await dopuni(await zapocniIgru(db, ident, datum)));
      case "pitanje":
        return NextResponse.json(await dopuni(await posaljiPitanje(db, ident, datum)));
      case "odgovor": {
        if (typeof telo.itemId !== "number" || !Number.isInteger(telo.itemId)) {
          return NextResponse.json({ greska: "los_zahtev" }, { status: 400 });
        }
        const ishod = await odgovori(db, ident, datum, {
          itemId: telo.itemId,
          odgovor: telo.odgovor,
          istek: telo.istek === true,
          slusanoMs: typeof telo.slusanoMs === "number" ? telo.slusanoMs : undefined,
        });
        return NextResponse.json({ ...ishod, stanje: await dopuni(ishod.stanje) });
      }
      case "slusanje": {
        if (typeof telo.itemId !== "number" || !Number.isInteger(telo.itemId) || typeof telo.pusteno !== "boolean") {
          return NextResponse.json({ greska: "los_zahtev" }, { status: 400 });
        }
        return NextResponse.json(await dopuni(await slusanje(db, ident, datum, { itemId: telo.itemId, pusteno: telo.pusteno })));
      }
      default:
        return NextResponse.json({ greska: "los_zahtev" }, { status: 400 });
    }
  } catch (e) {
    if (e instanceof GreskaIgre) {
      // Browser i server su se razišli (dupli klik, drugi tab, isteklo vreme): pošalji sveže stanje.
      return NextResponse.json({ greska: e.kod, stanje: await dopuni(await stanjeIgre(db, ident, datum)) }, { status: 409 });
    }
    console.error("[igra]", e);
    return NextResponse.json({ greska: "server" }, { status: 500 });
  }
}
