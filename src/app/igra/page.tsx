import type { Metadata } from "next";
import { Igra } from "@/components/game/Igra";
import "./igra.css";

export const metadata: Metadata = { title: "Igra" };

/** Sama igra je u celosti u browseru (komponenta Igra), a pitanja i ocene stižu sa /api/igra. */
export default function IgraStrana() {
  return (
    <div className="shell g-shell">
      <main className="main g-main">
        <Igra />
      </main>
    </div>
  );
}
