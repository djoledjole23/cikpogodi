import type { Metadata } from "next";
import Link from "next/link";
import { connection } from "next/server";
import { Suspense } from "react";
import { Avatar } from "@/components/Avatar";
import { Page } from "@/components/Page";
import { getIgrac } from "@/lib/auth";
import { getDb } from "@/lib/db";
import { jePeriod, NAJVISE_NA_LISTI, NAZIV_PERIODA, PERIODI, rangLista, type Period, type RedListe } from "@/lib/game/lista";
import { beogradskiDatum } from "@/lib/time";

export const metadata: Metadata = { title: "Rang lista" };

export default function RangLista({ searchParams }: PageProps<"/rang-lista">) {
  return (
    <Page>
      <div className="stack">
        <h1 className="h1">Rang lista</h1>
        <p className="lead">Ista pitanja za sve. Kod istog broja poena bolji je onaj ko je brže odgovarao.</p>
      </div>
      <Suspense fallback={<div className="skeleton" style={{ height: 360 }} aria-hidden="true" />}>
        <Lista searchParams={searchParams} />
      </Suspense>
    </Page>
  );
}

/** „1:07” (minuti i sekunde odgovaranja); služi da se vidi zašto je neko ispred kod istog broja poena. */
function vreme(ms: number): string {
  const s = Math.round(ms / 1000);
  return `${Math.floor(s / 60)}:${String(s % 60).padStart(2, "0")}`;
}

async function Lista({ searchParams }: Pick<PageProps<"/rang-lista">, "searchParams">) {
  // Lista se uvek čita sveže (zavisi od trenutka i od toga ko gleda).
  await connection();
  const trazeno = (await searchParams).period;
  const period: Period = jePeriod(trazeno) ? trazeno : "danas";
  const igrac = await getIgrac();
  const db = await getDb();

  let redovi: RedListe[] = [];
  let greska = false;
  if (db) {
    try {
      redovi = await rangLista(db, period, beogradskiDatum(), igrac?.id ?? null);
    } catch (e) {
      console.error("[rang lista]", e);
      greska = true;
    }
  }
  const vrh = redovi.filter((r) => r.mesto <= NAJVISE_NA_LISTI);
  const ja = redovi.find((r) => r.ja);
  const jaIspodVrha = ja && !vrh.includes(ja) ? ja : null;

  return (
    <div className="stack-lg">
      <nav className="tabs" aria-label="Period">
        {PERIODI.map((p) => (
          <Link key={p} href={p === "danas" ? "/rang-lista" : `/rang-lista?period=${p}`} className="tab" aria-current={p === period ? "page" : undefined}>
            {NAZIV_PERIODA[p]}
          </Link>
        ))}
      </nav>

      {!db || greska ? (
        <p className="lead">Rang lista trenutno ne može da se učita. Probaj malo kasnije.</p>
      ) : vrh.length === 0 ? (
        <div className="stack">
          <p className="lead">{period === "danas" ? "Danas još niko nije na listi. Budi prvi." : "Još je prazna."}</p>
          <Link href="/igra" className="btn">
            Igraj
          </Link>
        </div>
      ) : (
        <ol className="rang">
          {vrh.map((r) => (
            <Red key={r.userId} red={r} period={period} />
          ))}
          {jaIspodVrha && (
            <>
              <li className="rang-razmak" aria-hidden="true">
                ⋯
              </li>
              <Red red={jaIspodVrha} period={period} />
            </>
          )}
        </ol>
      )}

      {db && !greska && vrh.length > 0 && !ja && (
        <p className="small muted">
          {igrac ? (
            period === "danas" ? "Tvoj današnji rezultat još nije na listi." : "Još nemaš rezultat na ovoj listi."
          ) : (
            <>
              <Link href="/prijava?next=/rang-lista" className="text-link">
                Prijavi se
              </Link>{" "}
              da vidiš gde si ti.
            </>
          )}
        </p>
      )}

      <Link href="/" className="btn btn-ghost">
        Nazad na početnu
      </Link>
    </div>
  );
}

function Red({ red: r, period }: { red: RedListe; period: Period }) {
  return (
    <li className={r.ja ? "rang-red ja" : "rang-red"} aria-current={r.ja ? "true" : undefined}>
      <span className={r.mesto <= 3 ? `rang-mesto top${r.mesto}` : "rang-mesto"}>{r.mesto}.</span>
      <Avatar seme={r.userId} size={40} />
      <span className="rang-ime">
        <strong>{r.username}</strong>
        <small>
          {period === "danas" ? `${vreme(r.vremeMs)} odgovaranja` : `${r.igara} ${r.igara === 1 ? "igra" : r.igara % 10 >= 2 && r.igara % 10 <= 4 && (r.igara % 100 < 10 || r.igara % 100 >= 20) ? "igre" : "igara"}`}
          {r.ja ? " · to si ti" : ""}
        </small>
      </span>
      <span className="rang-poeni">{r.poeni}</span>
    </li>
  );
}
