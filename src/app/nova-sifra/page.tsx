import type { Metadata } from "next";
import { redirect } from "next/navigation";
import { Suspense } from "react";
import { NovaSifraForma } from "@/components/auth/forms";
import { Page } from "@/components/Page";
import { getIgrac } from "@/lib/auth";

export const metadata: Metadata = { title: "Promeni \u0161ifru" };

export default function NovaSifra() {
  return (
    <Page>
      <div className="stack">
        <h1 className="h1">Promeni \u0161ifru</h1>
        <p className="lead">Smisli novu, pa je ovaj put negde i zapi\u0161i.</p>
      </div>
      <Suspense fallback={<div className="skeleton" style={{ height: 220 }} aria-hidden="true" />}>
        <Sadrzaj />
      </Suspense>
    </Page>
  );
}

async function Sadrzaj() {
  if (!(await getIgrac())) redirect("/prijava?next=/nova-sifra");
  return <NovaSifraForma />;
}
