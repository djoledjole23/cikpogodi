import type { Metadata } from "next";
import Link from "next/link";
import { Suspense } from "react";
import { IconPismo } from "@/components/icons";
import { Page } from "@/components/Page";

export const metadata: Metadata = { title: "Proveri mejl" };

export default function ProveriMejl({ searchParams }: PageProps<"/proveri-mejl">) {
  return (
    <Page>
      <div className="stack">
        <span className="score-icon" style={{ width: 64, height: 64, borderRadius: 18 }}>
          <IconPismo size={36} />
        </span>
        <h1 className="h1">Još jedan korak: potvrdi mejl</h1>
        <p className="lead">
          Poslali smo ti link
          <Suspense fallback={null}>
            <Adresa searchParams={searchParams} />
          </Suspense>
          . Klikni na njega i nalog je spreman.
        </p>
      </div>
      <div className="card stack">
        <p>Rezultat ti je sačuvan i čeka. Na rang listu ulazi čim potvrdiš mejl.</p>
        <p className="muted small">
          Nema mejla posle par minuta? Pogledaj u spam. Ako si se već ranije registrovao sa ovim mejlom, novi link
          ne stiže: samo se prijavi.
        </p>
      </div>
      <div className="stack">
        <Link href="/prijava" className="btn">
          Prijavi se
        </Link>
        <Link href="/" className="btn btn-ghost">
          Nazad na početnu
        </Link>
      </div>
    </Page>
  );
}

async function Adresa({ searchParams }: Pick<PageProps<"/proveri-mejl">, "searchParams">) {
  const email = (await searchParams).email;
  if (typeof email !== "string" || !email.includes("@") || email.length > 120) return null;
  return (
    <>
      {" "}
      na <strong>{email}</strong>
    </>
  );
}
