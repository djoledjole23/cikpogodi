import type { Metadata } from "next";
import { NovaSifraForma } from "@/components/auth/forms";
import { Page } from "@/components/Page";

export const metadata: Metadata = { title: "Nova šifra" };

export default function NovaSifra() {
  return (
    <Page>
      <div className="stack">
        <h1 className="h1">Nova šifra</h1>
        <p className="lead">Smisli novu, pa je ovaj put negde i zapiši.</p>
      </div>
      <NovaSifraForma />
    </Page>
  );
}
