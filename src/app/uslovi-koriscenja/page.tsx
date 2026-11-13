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
          klipovi su zvanični odlomci sa servisa Deezer, video inserti se puštaju sa zvaničnih YouTube kanala, a
          slike proizvoda su sa Open Food Facts. Podaci o pretragama su iz Google Trends. Sva prava ostaju kod
          vlasnika.
        </p>

        <h2>Bez garancija</h2>
        <p>
          Trudimo se da sve radi i da podaci budu tačni, ali to ne možemo da garantujemo. Ovo je igra, a ne
          cenovnik ni izvor zvaničnih informacija. Nema nagrada, osim slave na rang listi.
        </p>

        <h2>Izmene i kontakt</h2>
        <p>
          Pravila možemo da menjamo, a nova važe od objave na ovoj strani. Pitanja šalji na{" "}
          <span className="todo">[MEJL ZA KONTAKT]</span>. Sajtom upravlja{" "}
          <span className="todo">[IME I PREZIME ILI FIRMA]</span>.
        </p>

        <p className="muted small">Poslednja izmena: <span className="todo">[DATUM]</span></p>
      </div>
    </Page>
  );
}
