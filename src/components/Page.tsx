import type { ReactNode } from "react";
import { Footer } from "./Footer";
import { Header } from "./Header";

/** Okvir obične strane: zaglavlje, sadržaj, podnožje. */
export function Page({ children, logo = true }: { children: ReactNode; logo?: boolean }) {
  return (
    <div className="shell">
      <Header logo={logo} />
      <main className="main">{children}</main>
      <Footer />
    </div>
  );
}
