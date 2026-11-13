"use client";

import Link from "next/link";
import { useCallback, useEffect, useRef, useState } from "react";
import type { Ocena, SegmentStanje, Stanje, Trenutno } from "@/lib/game/types";
import { haptika, sfx } from "@/lib/sound";
import { api, NijeNaRedu } from "./api";
import { komentarCena, komentarGugla } from "@/lib/game/komentari";
import { CenaOcena, CenaPitanje } from "./Cena";
import { KrajSegmenta, Kraj, OkvirOcene, Poruka, Tajmer, UvodSegmenta, Zaglavlje } from "./delovi";
import { GuglaOcena, GuglaPitanje } from "./Gugla";
import { smanjenoKretanje } from "./efekti";

/**
 * Ceo tok igre u browseru. Server odlučuje sve (koje je pitanje, koliko je vremena, koliko poena);
 * ova komponenta samo prikazuje ekran koji odgovara stanju i šalje ono što igrač uradi.
 */
type Ekran =
  | { vrsta: "ucitavanje" }
  | { vrsta: "greska" }
  | { vrsta: "stanje"; stanje: Stanje } // uvod, pitanje, kraj ili poruka: zavisi od stanja
  | { vrsta: "ocena"; stanje: Stanje; ocena: Ocena; pitanje: Trenutno; krajSegmenta?: SegmentStanje }
  | { vrsta: "kraj_segmenta"; stanje: Stanje; segment: SegmentStanje };

export function Igra() {
  const [ekran, setEkran] = useState<Ekran>({ vrsta: "ucitavanje" });
  const [ceka, setCeka] = useState(false);
  /** Zbir koji se vidi u zaglavlju: kasni za pravim dok poeni „lete”. */
  const [zbir, setZbir] = useState(0);
  /** Koliko je pitanja zaredom donelo poene. */
  const [niz, setNiz] = useState(0);
  const saljem = useRef(false);

  /** Prikaži ono što stanje kaže. Ako je sledeće pitanje samo spremno (nije prvo u segmentu), odmah ga zatraži. */
  const prikazi = useCallback(async (stanje: Stanje) => {
    let s = stanje;
    if (s.status === "nije_poceo") s = await api.start();
    if (s.status === "u_toku" && s.trenutno?.faza === "sledece") s = await api.pitanje(s.datum);
    setZbir(s.score);
    setEkran({ vrsta: "stanje", stanje: s });
  }, []);

  const ucitaj = useCallback(async () => {
    setEkran({ vrsta: "ucitavanje" });
    try {
      await prikazi(await api.stanje());
    } catch {
      setEkran({ vrsta: "greska" });
    }
  }, [prikazi]);

  useEffect(() => {
    // Prvo učitavanje: stanje stiže sa servera, pa se ekran postavlja tek kad odgovor dođe.
    // eslint-disable-next-line react-hooks/set-state-in-effect
    void ucitaj();
  }, [ucitaj]);

  /** Zajednički omotač za akcije: jedan zahtev u isto vreme, a kad se browser i server raziđu, veruj serveru. */
  const uradi = useCallback(
    async (posao: () => Promise<void>) => {
      if (saljem.current) return;
      saljem.current = true;
      setCeka(true);
      try {
        await posao();
      } catch (e) {
        if (e instanceof NijeNaRedu) await prikazi(e.stanje).catch(() => setEkran({ vrsta: "greska" }));
        else setEkran({ vrsta: "greska" });
      } finally {
        saljem.current = false;
        setCeka(false);
      }
    },
    [prikazi],
  );

  const kreni = (stanje: Stanje) =>
    uradi(async () => {
      const s = await api.pitanje(stanje.datum);
      setZbir(s.score);
      setEkran({ vrsta: "stanje", stanje: s });
    });

  const odgovori = (stanje: Stanje, odgovor: unknown, istek = false) =>
    uradi(async () => {
      const pitanje = stanje.trenutno!;
      const r = await api.odgovor(stanje.datum, pitanje.itemId, odgovor, istek);
      const noviNiz = r.ocena.tacno ? niz + 1 : 0;
      setNiz(noviNiz);
      if (r.ocena.tacno) {
        sfx.ding(noviNiz);
        haptika.tacno();
      } else {
        sfx.bonk();
        haptika.netacno();
      }
      setEkran({ vrsta: "ocena", stanje: r.stanje, ocena: r.ocena, pitanje, krajSegmenta: r.krajSegmenta });
      // Zbir u zaglavlju se menja kad poeni „dolete” do njega.
      setTimeout(() => setZbir(r.stanje.score), r.ocena.poeni > 0 && !smanjenoKretanje() ? 870 : 0);
    });

  const dalje = (e: Extract<Ekran, { vrsta: "ocena" }>) => {
    if (e.krajSegmenta) {
      setNiz(0);
      setEkran({ vrsta: "kraj_segmenta", stanje: e.stanje, segment: e.krajSegmenta });
      return;
    }
    void uradi(() => prikazi(e.stanje));
  };

  // ───── crtanje ─────

  if (ekran.vrsta === "ucitavanje") {
    return (
      <>
        <Zaglavlje zbir={zbir} />
        <div className="skeleton g-cekanje" role="status" aria-label="Učitavam igru" />
      </>
    );
  }

  if (ekran.vrsta === "greska") {
    return (
      <>
        <Zaglavlje zbir={zbir} />
        <Poruka
          naslov="Nešto je zapelo"
          dugme={
            <button type="button" className="btn" onClick={() => void ucitaj()}>
              Pokušaj ponovo
            </button>
          }
        >
          Ne možemo da dobijemo server. Proveri internet pa probaj opet. Ono što si već odgovorio je sačuvano.
        </Poruka>
      </>
    );
  }

  if (ekran.vrsta === "ocena") {
    const { pitanje, ocena } = ekran;
    return (
      <>
        <Zaglavlje segment={pitanje.segment} pozicija={pitanje.pozicija} ukupno={pitanje.ukupno} zbir={zbir} />
        <OkvirOcene
          key={pitanje.itemId}
          komentar={
            ocena.prikaz.vrsta === "cena"
              ? komentarCena(ocena, ocena.prikaz, pitanje.itemId)
              : komentarGugla(ocena, ocena.prikaz, pitanje.itemId)
          }
          niz={niz}
          naDalje={() => dalje(ekran)}
          ceka={ceka}
        >
          {ocena.prikaz.vrsta === "cena" ? (
            <CenaOcena
              ocena={ocena}
              prikaz={ocena.prikaz}
              slika={pitanje.pitanje?.vrsta === "cena" ? pitanje.pitanje.slika : ""}
            />
          ) : (
            <GuglaOcena ocena={ocena} prikaz={ocena.prikaz} />
          )}
        </OkvirOcene>
      </>
    );
  }

  if (ekran.vrsta === "kraj_segmenta") {
    return (
      <>
        <Zaglavlje segment={ekran.segment.n} zbir={zbir} />
        <KrajSegmenta segment={ekran.segment} naDalje={() => void uradi(() => prikazi(ekran.stanje))} />
      </>
    );
  }

  const { stanje } = ekran;

  switch (stanje.status) {
    case "nije_povezano":
      return (
        <>
          <Zaglavlje zbir={0} />
          <Poruka naslov="Igra još nije povezana">Baza nije podešena, pa nema ni pitanja. Javi onome ko održava sajt.</Poruka>
        </>
      );
    case "nema_kviza":
    case "nije_poceo":
      return (
        <>
          <Zaglavlje zbir={0} />
          <Poruka naslov="Današnji kviz još nije spreman">Pitanja za danas još nisu postavljena. Svrati malo kasnije.</Poruka>
        </>
      );
    case "uredjaj_igrao":
      return (
        <>
          <Zaglavlje zbir={0} />
          <Poruka
            naslov="Ovde je danas već igrano"
            dugme={
              <Link href="/prijava?next=/igra" className="btn">
                Prijavi se
              </Link>
            }
          >
            Sa ovog uređaja je današnja igra već odigrana. Prijavi se da vidiš svoj rezultat. Nova igra stiže u ponoć.
          </Poruka>
        </>
      );
    case "zavrseno":
      return (
        <>
          <Zaglavlje zbir={zbir} />
          <Kraj stanje={stanje} />
        </>
      );
    case "u_toku": {
      const t = stanje.trenutno!;
      const segment = stanje.segmenti.find((s) => s.n === t.segment)!;
      if (t.faza !== "pitanje" || !t.pitanje) {
        return (
          <>
            <Zaglavlje segment={t.segment} zbir={zbir} />
            <UvodSegmenta segment={segment} naKreni={() => void kreni(stanje)} ceka={ceka} />
          </>
        );
      }
      return (
        <>
          <Zaglavlje segment={t.segment} pozicija={t.pozicija} ukupno={t.ukupno} zbir={zbir} />
          <Tajmer
            key={t.itemId}
            limitMs={t.limitMs!}
            preostaloMs={t.preostaloMs!}
            zaustavljen={ceka}
            naIstek={() => void odgovori(stanje, null, true)}
          />
          {t.pitanje.vrsta === "cena" ? (
            <CenaPitanje
              key={`p${t.itemId}`}
              pitanje={t.pitanje}
              zakljucano={ceka}
              naPotvrdi={(unos) => void odgovori(stanje, { unos })}
            />
          ) : (
            <GuglaPitanje
              key={`p${t.itemId}`}
              pitanje={t.pitanje}
              zakljucano={ceka}
              naIzbor={(izbor) => void odgovori(stanje, { izbor })}
            />
          )}
        </>
      );
    }
  }
}
