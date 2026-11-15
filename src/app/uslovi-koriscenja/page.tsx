import type { Metadata } from "next";
import { Page } from "@/components/Page";

export const metadata: Metadata = { title: "Uslovi korišćenja" };

// NACRT: pre puštanja sajta popuni obeležena mesta i daj pravniku da pogleda.
export default function UsloviKoriscenja() {
  return (
    <Page>
      <h1 className="h1">Uslovi korišćenja</h1>
      <div className="prose">
        <p>Čik Pogodi! je besplatan dnevni kviz za zabavu. Igranjem prihvataš ova pravila.</p>

        <h2>Fer igra</h2>
        <ul>
          <li>Jedna igra dnevno po igraču. Više naloga, botovi i slično nisu dozvoljeni.</li>
          <li>Rezultate dobijene varanjem možemo da uklonimo sa rang liste, a nalog da ugasimo.</li>
        </ul>

        <h2>Korisničko ime</h2>
        <p>
          Bez psovki, vređanja i predstavljanja kao neko drugi. Ime koje krši ovo pravilo možemo da promenimo ili
          uklonimo.
        </p>

        <h2>Sadržaj</h2>
        <p>
          Cene su iz zvaničnih cenovnika trgovinskih lanaca (data.gov.rs) i važe za dan kada su preuzete. Muzički
          klipovi su zvanični odlomci sa servisa Deezer. Fotografije proizvoda pripadaju proizvođačima i trgovcima, a
          kadrovi iz filmova i serija njihovim producentima. Podaci o pretragama su iz Google Trends. Sva prava
          ostaju kod vlasnika.
        </p>

        <h2>Bez garancija</h2>
        <p>
          Trudimo se da sve radi i da podaci budu tačni, ali to ne možemo da garantujemo. Ovo je igra, a ne
          cenovnik ni izvor zvaničnih informacija. Nema nagrada, osim slave na rang listi.
        </p>

        <h2>Izmene i kontakt</h2>
        <p>
          Pravila možemo da menjamo, a nova važe od objave na ovoj strani. Pitanja šalji na{" "}
          <a href="mailto:djordjeilic02@gmail.com">djordjeilic02@gmail.com</a>. Sajtom upravlja Djordje Ilic.
        </p>

        <p className="muted small">Poslednja izmena: 15. novembra 2026.</p>
      </div>
    </Page>
  );
}
