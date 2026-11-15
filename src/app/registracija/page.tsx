import type { Metadata } from "next";
import Link from "next/link";
import { Suspense } from "react";
import { OAuthDugmad, OAuthRazdvojnik, RegistracijaForma } from "@/components/auth/forms";
import { Page } from "@/components/Page";
import { bezbedanNext } from "@/lib/auth";

export const metadata: Metadata = { title: "Napravi nalog" };

export default function Registracija({ searchParams }: PageProps<"/registracija">) {
  return (
    <Page>
      <div className="stack">
        <h1 className="h1">Napravi nalog</h1>
        <p className="lead">Da ti rezultat ostane zapisan i da uđeš na rang listu.</p>
      </div>
      <Suspense fallback={<div className="skeleton" style={{ height: 420 }} aria-hidden="true" />}>
        <Sadrzaj searchParams={searchParams} />
      </Suspense>
    </Page>
  );
}

async function Sadrzaj({ searchParams }: Pick<PageProps<"/registracija">, "searchParams">) {
  const next = bezbedanNext((await searchParams).next);
  return (
    <div className="stack-lg">
      <OAuthDugmad next={next} />
      <OAuthRazdvojnik />
      <RegistracijaForma next={next} />
      <Link href={`/prijava?next=${encodeURIComponent(next)}`} className="btn btn-ghost">
        Već imaš nalog? Prijavi se
      </Link>
    </div>
  );
}
