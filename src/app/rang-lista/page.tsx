import type { Metadata } from "next";
import Link from "next/link";
import { Page } from "@/components/Page";

export const metadata: Metadata = { title: "Rang lista" };

// TODO (korak „rezultat i rang lista”): Danas / Ova nedelja / Ukupno preko funkcije public.leaderboard.
export default function RangLista() {
  return (
    <Page>
      <div className="stack">
        <h1 className="h1">Rang lista</h1>
        <p className="lead">Još je prazna. Lista se puni čim krene prva igra.</p>
      </div>
      <Link href="/" className="btn btn-ghost">
        Nazad na početnu
      </Link>
    </Page>
  );
}
