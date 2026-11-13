import type { Metadata } from "next";
import Link from "next/link";
import { Suspense } from "react";
import { OAuthDugmad, PrijavaForma } from "@/components/auth/forms";
import { Page } from "@/components/Page";
import { bezbedanNext } from "@/lib/auth";

export const metadata: Metadata = { title: "Prijava" };

const GRESKE: Record<string, string> = {
  link: "Link je istekao ili je već iskorišćen. Prijavi se ili zatraži novi.",
  oauth: "Prijava preko Google ili Apple naloga nije uspela. Probaj ponovo.",
};

export default function Prijava({ searchParams }: PageProps<"/prijava">) {
  return (
    <Page>
      <h1 className="h1">Prijava</h1>
      <Suspense fallback={<div className="skeleton" style={{ height: 360 }} aria-hidden="true" />}>
        <Sadrzaj searchParams={searchParams} />
      </Suspense>
    </Page>
  );
}

async function Sadrzaj({ searchParams }: Pick<PageProps<"/prijava">, "searchParams">) {
  const sp = await searchParams;
  const next = bezbedanNext(sp.next);
  const greska = typeof sp.greska === "string" ? GRESKE[sp.greska] : undefined;
  return (
    <div className="stack-lg">
      {greska && (
        <p className="form-error" role="alert">
          {greska}
        </p>
      )}
      <div className="stack">
        <PrijavaForma next={next} />
        <p className="center">
          <Link href="/zaboravljena-sifra" className="text-link tap">
            Zaboravio sam šifru
          </Link>
        </p>
      </div>
      <p className="divider">ili</p>
      <OAuthDugmad next={next} />
      <p className="center">
        <Link href={`/registracija?next=${encodeURIComponent(next)}`} className="text-link tap">
          Nemam nalog → Napravi ga
        </Link>
      </p>
    </div>
  );
}
