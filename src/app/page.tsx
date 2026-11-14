import Link from "next/link";
import { Suspense } from "react";
import { Countdown } from "@/components/Countdown";
import { IconStrelica, SegmentIcon } from "@/components/icons";
import { Page } from "@/components/Page";
import { MAX_BONUS, MAX_OSNOVNO, MAX_UKUPNO, SEGMENTI } from "@/config/quiz.config";
import { getDanasnjaIgra } from "@/lib/plays";

export default function Pocetna() {
  return (
    <Page logo={false}>
      <section className="stack" style={{ gap: 14 }}>
        <h1 className="logo">
          <span className="logo-cik">ČIK</span>
          <span className="logo-pogodi">Pogodi!</span>
        </h1>
        <p className="lead">
          Pet mini igara, jedan pokušaj dnevno. Svi dobijaju ista pitanja, pa da vidimo ko stvarno zna, a ko samo
          priča. Ista pitanja za sve, trofej samo za jednog.
        </p>
        {/* Zavisi od toga da li je igrač danas već igrao, pa stiže naknadno. */}
        <Suspense fallback={<div className="skeleton" style={{ height: 74 }} aria-hidden="true" />}>
          <StanjeIgre />
        </Suspense>
      </section>

      <section className="stack" aria-labelledby="kako-ide">
        <h2 id="kako-ide" className="h2">
          Kako ide
        </h2>
        <ol className="rules">
          <li>
            <span className="rules-n" aria-hidden="true">
              1
            </span>
            <span>Igraš jednom dnevno. Nema popravnog.</span>
          </li>
          <li>
            <span className="rules-n" aria-hidden="true">
              2
            </span>
            <span>Pet segmenata idu redom, a vreme curi.</span>
          </li>
          <li>
            <span className="rules-n" aria-hidden="true">
              3
            </span>
            <span>Na kraju sačuvaš rezultat i vidiš gde si na rang listi.</span>
          </li>
        </ol>
      </section>

      <section className="stack" aria-labelledby="bodovanje">
        <h2 id="bodovanje" className="h2">
          Bodovanje
        </h2>
        <ul className="score-list">
          {SEGMENTI.map((s) => (
            <li key={s.key} className={s.bonus ? "score-row is-bonus" : "score-row"}>
              <span className="score-icon">
                <SegmentIcon segment={s.key} />
              </span>
              <span className="score-text">
                <span className="score-name">{s.naziv}</span>
                <span className="score-rule">{s.bodovanje}</span>
              </span>
              <span className="score-max">
                <span className="sr-only">najviše </span>
                {s.bonus ? `+${s.max}` : s.max}
              </span>
            </li>
          ))}
        </ul>
        <div className="score-total">
          <span className="score-text">
            <span className="display" style={{ fontSize: 22, lineHeight: 1.2 }}>
              Ukupno
            </span>
            <span className="score-rule">
              {MAX_OSNOVNO} + {MAX_BONUS} bonus
            </span>
          </span>
          <span className="score-total-n">{MAX_UKUPNO}</span>
        </div>
      </section>
    </Page>
  );
}

async function StanjeIgre() {
  const igra = await getDanasnjaIgra();

  if (igra?.status === "zavrseno" || igra?.status === "uredjaj_igrao") {
    const max = igra.segmenti.reduce((z, s) => z + s.max, 0) || MAX_UKUPNO;
    return (
      <div className="played">
        {igra.status === "zavrseno" ? (
          <>
            <p className="small muted">Današnju igru si odigrao. Tvoj rezultat:</p>
            <p className="played-score">
              {igra.score}
              <small> / {max}</small>
            </p>
          </>
        ) : (
          <p className="small muted">Sa ovog uređaja je današnja igra već odigrana.</p>
        )}
        <p className="small muted">Sledeća igra za</p>
        <Countdown />
        <Link href={igra.status === "zavrseno" ? "/igra" : "/prijava?next=/igra"} className="btn btn-ghost">
          {igra.status === "zavrseno" ? "Vidi odgovore" : "Prijavi se"}
        </Link>
      </div>
    );
  }

  return (
    <>
      <Link href="/igra" className="btn btn-lg">
        <span>{igra?.status === "u_toku" ? "Nastavi igru" : "Započni igru"}</span>
        <IconStrelica size={26} />
      </Link>
      <p className="small muted center">Nova igra svake noći u ponoć.</p>
    </>
  );
}
