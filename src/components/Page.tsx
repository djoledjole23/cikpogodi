import type { ReactNode } from "react";
import { Footer } from "./Footer";
import { Header } from "./Header";

/** Okvir obične strane: zaglavlje, sadržaj, podnožje. */
/** `pocetna`: na širokom ekranu sadržaj ide u dve kolone (vidi „desktop” u globals.css); telefon se ne menja. */
export function Page({ children, logo = true, pocetna = false }: { children: ReactNode; logo?: boolean; pocetna?: boolean }) {
  return (
    <div className={pocetna ? "shell shell-pocetna" : "shell"}>
      <Header logo={logo} />
      <main className={pocetna ? "main main-pocetna" : "main"}>{children}</main>
      <Footer />
    </div>
  );
}
