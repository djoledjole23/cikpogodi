import type { Metadata } from "next";
import Link from "next/link";
import { ZaboravljenaSifraForma } from "@/components/auth/forms";
import { Page } from "@/components/Page";

export const metadata: Metadata = { title: "Zaboravljena šifra" };

export default function ZaboravljenaSifra() {
  return (
    <Page>
      <div className="stack">
        <h1 className="h1">Zaboravljena šifra</h1>
        <p className="lead">Dešava se i najboljima. Upiši mejl i šaljemo ti link za novu.</p>
      </div>
      <ZaboravljenaSifraForma />
      <p className="center">
        <Link href="/prijava" className="text-link tap">
          Nazad na prijavu
        </Link>
      </p>
    </Page>
  );
}
