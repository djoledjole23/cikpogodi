import "server-only";
import { randomUUID } from "node:crypto";
import { cookies } from "next/headers";
import { getIgrac } from "@/lib/auth";
import type { Identitet } from "./types";

export const KOLACIC_UREDJAJA = "cp_dev";
const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-8][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

export const jeUuid = (x: unknown): x is string => typeof x === "string" && UUID.test(x);

/** Samo čita: ko je igrač, ako već ima oznaku uređaja. Za strane koje ne smeju da upisuju kolačiće. */
export async function procitajIdentitet(): Promise<Identitet | null> {
  const igrac = await getIgrac();
  const izKolacica = (await cookies()).get(KOLACIC_UREDJAJA)?.value;
  if (!jeUuid(izKolacica)) return igrac ? { userId: igrac.id, deviceId: randomUUID() } : null;
  return { userId: igrac?.id ?? null, deviceId: izKolacica.toLowerCase() };
}

/**
 * Za API rute: vraća identitet i po potrebi upisuje kolačić uređaja.
 * Redosled: kolačić → oznaka iz localStorage koju pošalje browser → nova oznaka.
 * (Dva mesta, da brisanje samo kolačića ili samo localStorage ne donese drugu igru istog dana.)
 */
export async function obezbediIdentitet(izBrowsera: unknown): Promise<Identitet> {
  const igrac = await getIgrac();
  const kolacici = await cookies();
  const izKolacica = kolacici.get(KOLACIC_UREDJAJA)?.value;

  let deviceId: string;
  if (jeUuid(izKolacica)) deviceId = izKolacica.toLowerCase();
  else {
    deviceId = jeUuid(izBrowsera) ? izBrowsera.toLowerCase() : randomUUID();
    kolacici.set(KOLACIC_UREDJAJA, deviceId, {
      httpOnly: true,
      sameSite: "lax",
      secure: process.env.NODE_ENV === "production",
      path: "/",
      maxAge: 60 * 60 * 24 * 400,
    });
  }
  return { userId: igrac?.id ?? null, deviceId };
}
