import type { Metadata } from "next";
import { redirect } from "next/navigation";
import { Suspense } from "react";
import { BrisanjeNalogaForma, KorisnickoImeForma } from "@/components/auth/forms";
import { Page } from "@/components/Page";
import { getIgrac } from "@/lib/auth";
import { odjava } from "@/lib/auth-actions";

export const metadata: Metadata = { title: "Moj nalog" };

export default function Nalog({ searchParams }: PageProps<"/nalog">) {
  return (
    <Page>
      <h1 className="h1">Moj nalog</h1>
      <Suspense fallback={<div className="skeleton" style={{ height: 360 }} aria-hidden="true" />}>
        <Sadrzaj searchParams={searchParams} />
      </Suspense>
    </Page>
  );
}

async function Sadrzaj({ searchParams }: Pick<PageProps<"/nalog">, "searchParams">) {
  const igrac = await getIgrac();
  if (!igrac) redirect("/prijava?next=/nalog");
  if (!igrac.username) redirect("/nalog/korisnicko-ime");
  const sp = await searchParams;

  return (
    <div className="stack-lg">
      {sp.sifra === "promenjena" && (
        <p className="form-ok" role="status">
          Šifra je promenjena.
        </p>
      )}
      <div className="card stack">
        <p className="small muted">Prijavljen si kao</p>
        <p className="display" style={{ fontSize: 28, lineHeight: 1.1 }}>
          {igrac.username}
        </p>
        <p className="muted" style={{ overflowWrap: "anywhere" }}>
          {igrac.email}
        </p>
        {!igrac.mejlPotvrdjen && (
          <p className="field-error">Mejl još nije potvrđen, pa ti rezultati ne ulaze na rang listu.</p>
        )}
      </div>

      <section className="stack" aria-labelledby="promena-imena">
        <h2 id="promena-imena" className="h2">
          Promeni ime
        </h2>
        <KorisnickoImeForma trenutno={igrac.username} next="/nalog" />
      </section>

      <form action={odjava}>
        <button type="submit" className="btn btn-ghost">
          Odjavi se
        </button>
      </form>

      <section className="stack" aria-labelledby="brisanje">
        <h2 id="brisanje" className="h2">
          Brisanje naloga
        </h2>
        <BrisanjeNalogaForma />
      </section>
    </div>
  );
}
