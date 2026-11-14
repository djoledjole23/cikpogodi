import { NextResponse, type NextRequest } from "next/server";
import { svezKlip } from "@/lib/audio";
import { getDb } from "@/lib/db";
import { audioZaPitanje } from "@/lib/game/engine";
import { procitajIdentitet } from "@/lib/game/identity";
import { beogradskiDatum, dodajDane } from "@/lib/time";

/**
 * Zvuk za pitanje: preusmerava na svež zvanični klip od 30 s (Deezer, pa iTunes).
 * U adresi je broj pitanja, a ne ID pesme, i radi samo za pitanje koje je ovom igraču već poslato,
 * pa adresa ne odaje koja je pesma niti dozvoljava preslušavanje unapred.
 */
export async function GET(_zahtev: NextRequest, ctx: RouteContext<"/api/track/[itemId]">) {
  const { itemId: sirovo } = await ctx.params;
  const itemId = Number(sirovo);
  const bezKesa = { "cache-control": "no-store" };
  if (!Number.isInteger(itemId) || itemId <= 0) return new NextResponse(null, { status: 400, headers: bezKesa });

  const db = await getDb();
  const ident = await procitajIdentitet();
  if (!db || !ident) return new NextResponse(null, { status: 404, headers: bezKesa });

  // Igra započeta pre ponoći može da se završava i posle nje, pa se gleda i jučerašnji kviz.
  const danas = beogradskiDatum();
  const izvor = (await audioZaPitanje(db, ident, danas, itemId)) ?? (await audioZaPitanje(db, ident, dodajDane(danas, -1), itemId));
  if (!izvor) return new NextResponse(null, { status: 404, headers: bezKesa });

  const url = await svezKlip(izvor);
  if (!url) return new NextResponse(null, { status: 502, headers: bezKesa });
  return NextResponse.redirect(url, { status: 302, headers: bezKesa });
}
