import type { Metadata } from "next";
import { redirect } from "next/navigation";
import { Suspense } from "react";
import { KorisnickoImeForma } from "@/components/auth/forms";
import { Page } from "@/components/Page";
import { bezbedanNext, getIgrac } from "@/lib/auth";

export const metadata: Metadata = { title: "Izaberi ime" };

export default function IzaberiIme({ searchParams }: PageProps<"/nalog/korisnicko-ime">) {
  return (
    <Page>
      <div className="stack">
        <h1 className="h1">Još samo ime</h1>
        <p className="lead">Pod ovim imenom te drugi vide na rang listi. Biraj pametno.</p>
      </div>
      <Suspense fallback={<div className="skeleton" style={{ height: 180 }} aria-hidden="true" />}>
        <Sadrzaj searchParams={searchParams} />
      </Suspense>
    </Page>
  );
}

async function Sadrzaj({ searchParams }: Pick<PageProps<"/nalog/korisnicko-ime">, "searchParams">) {
  const igrac = await getIgrac();
  const next = bezbedanNext((await searchParams).next);
  if (!igrac) redirect(`/prijava?next=${encodeURIComponent(next)}`);
  return <KorisnickoImeForma next={next} trenutno={igrac.username} dugme="To sam ja" />;
}
