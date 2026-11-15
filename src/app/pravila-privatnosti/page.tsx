import type { Metadata } from "next";
import Link from "next/link";
import { Page } from "@/components/Page";

export const metadata: Metadata = { title: "Pravila privatnosti" };

export default function PravilaPrivatnosti() {
  return (
    <Page>
      <h1 className="h1">Pravila privatnosti</h1>
      <div className="prose">
        <p>
          Kratko: skupljamo samo ono što je potrebno da igra radi i da rang lista bude fer. Ništa ne prodajemo i
          nema reklamnog praćenja.
        </p>

        <h2>Ko upravlja podacima</h2>
        <p>
          Djordje Ilic, fizicko lice, Srbija. Kontakt:{" "}
          <a href="mailto:djordjeilic02@gmail.com">djordjeilic02@gmail.com</a>.
        </p>

        <h2>Šta čuvamo</h2>
        <ul>
          <li>
            <strong>Nalog:</strong> nadimak i lozinku (lozinka se čuva samo kao nečitljiv otisak, ne vidi je niko).
            Mejl se ne traži i ne čuva.
          </li>
          <li>
            <strong>Igra:</strong> tvoje odgovore, poene i vreme odgovaranja za svaki dan. Na rang listi se vide
            samo korisničko ime, poeni i vreme.
          </li>
          <li>
            <strong>Uređaj:</strong> nasumičnu oznaku uređaja, da bi svako mogao da igra jednom dnevno i bez
            naloga.
          </li>
          <li>
            <strong>Tehnički zapisi:</strong> IP adresu i tip pregledača, koje server beleži radi bezbednosti.
          </li>
        </ul>

        <h2>Kolačići</h2>
        <p>
          Koristimo samo neophodne: za prijavu i za oznaku uređaja. Izbor zvuka i potvrdu ovog obaveštenja pamti
          tvoj pregledač. Nema analitičkih ni reklamnih kolačića.
        </p>

        <h2>Ko još obrađuje podatke</h2>
        <ul>
          <li>Supabase: baza i nalozi (serveri u Irskoj, Evropska unija).</li>
          <li>Vercel: hosting sajta (server u Frankfurtu, Nemačka).</li>
          <li>
            Deezer: muzički klipovi i omoti albuma se učitavaju sa njihovih servera, pa oni pritom vide tvoju IP
            adresu.
          </li>
        </ul>

        <h2>Koliko dugo</h2>
        <p>Dok imaš nalog. Kad ga obrišeš, brišu se i profil i svi tvoji rezultati.</p>

        <h2>Tvoja prava</h2>
        <p>
          Možeš da tražiš uvid, ispravku i brisanje podataka, kao i da uložiš pritužbu Povereniku za informacije
          od javnog značaja i zaštitu podataka o ličnosti. Nalog brišeš sam na strani{" "}
          <Link href="/nalog">Moj nalog</Link>, a za sve ostalo nam piši.
        </p>

        <p className="muted small">Poslednja izmena: 15. novembra 2026.</p>
      </div>
    </Page>
  );
}
