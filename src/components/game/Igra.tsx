"use client";

import Link from "next/link";
import { useCallback, useEffect, useRef, useState } from "react";
import type { Ocena, SegmentStanje, Stanje, Trenutno } from "@/lib/game/types";
import { haptika, sfx } from "@/lib/sound";
import { api, katalogPesama, NijeNaRedu } from "./api";
import { komentarCena, komentarFilm, komentarGugla, komentarJoker, komentarPesma } from "@/lib/game/komentari";
import { CenaOcena, CenaPitanje } from "./Cena";
import { KrajSegmenta, Kraj, OkvirOcene, Poruka, Tajmer, UvodSegmenta, Zaglavlje } from "./delovi";
import { FilmOcena, FilmPitanje } from "./Film";
import { JokerOcena, JokerPitanje } from "./Joker";
import { SacuvajRezultat } from "./Sacuvaj";
import { GuglaDuel } from "./Gugla";
import { PesmaIgra } from "./Pesma";
import { Odbrojavanje, smanjenoKretanje } from "./efekti";

/**
 * Ceo tok igre u browseru. Server odlučuje sve (koje je pitanje, koliko je vremena, koliko poena);
 * ova komponenta samo prikazuje ekran koji odgovara stanju i šalje ono što igrač uradi.
 */
type EkranOcene = {
  vrsta: "ocena";
  /** Stanje pre odgovora: zaglavlje ga pokazuje dok se rezultat ne otkrije (da tačkice ne odaju ishod). */
  pre: Stanje;
  stanje: Stanje;
  ocena: Ocena;
  pitanje: Trenutno;
  krajSegmenta?: SegmentStanje;
  /** Napetost je gotova: vidi se presuda, čuje se zvuk, poeni lete u zbir. */
  otkriveno: boolean;
  /** „Šta se više gugla”: gubitnik ispada dok stiže sledeći duel. */
  odlazi: boolean;
};

type Ekran =
  | { vrsta: "ucitavanje" }
  | { vrsta: "greska" }
  | { vrsta: "stanje"; stanje: Stanje } // uvod, pitanje, kraj ili poruka: zavisi od stanja
  | { vrsta: "odbrojavanje"; stanje: Stanje } // „3, 2, 1” pred prvo pitanje segmenta
  | EkranOcene
  | { vrsta: "kraj_segmenta"; stanje: Stanje; segment: SegmentStanje };

const cekaj = (ms: number) => new Promise<void>((gotovo) => setTimeout(gotovo, ms));
const tokSegmenta = (stanje: Stanje, n: number) => stanje.segmenti.find((s) => s.n === n)?.tok ?? [];
/** Koliko je poslednjih pitanja zaredom donelo poene. */
const nizPogodaka = (tok: number[]) => {
  let n = 0;
  for (let i = tok.length - 1; i >= 0 && tok[i] > 0; i--) n++;
  return n;
};

/** Ako igra još nije počela ili je sledeće pitanje samo spremno (nije prvo u segmentu), odmah ga zatraži. */
async function razresi(stanje: Stanje): Promise<Stanje> {
  let s = stanje;
  if (s.status === "nije_poceo") s = await api.start();
  if (s.status === "u_toku" && s.trenutno?.faza === "sledece") s = await api.pitanje(s.datum);
  return s;
}

const KLJUC_PRESKAKANJA = "cp_preskocio";

export function Igra() {
  const [ekran, setEkran] = useState<Ekran>({ vrsta: "ucitavanje" });
  const [ceka, setCeka] = useState(false);
  /** Zbir koji se vidi u zaglavlju: kasni za pravim dok poeni „lete”. */
  const [zbir, setZbir] = useState(0);
  /** Dan za koji je igrač rekao „Preskoči, samo mi pokaži rezultat” (pamti se na uređaju, da ga ne pitamo opet). */
  const [preskocio, setPreskocio] = useState<string | null>(null);
  useEffect(() => {
    try {
      // eslint-disable-next-line react-hooks/set-state-in-effect -- localStorage postoji tek u browseru
      setPreskocio(localStorage.getItem(KLJUC_PRESKAKANJA));
    } catch {
      // privatni režim bez localStorage: pitaćemo ponovo, ništa strašno
    }
  }, []);
  const zapamtiPreskakanje = useCallback((datum: string | null) => {
    setPreskocio(datum);
    window.scrollTo({ top: 0 });
    try {
      if (datum) localStorage.setItem(KLJUC_PRESKAKANJA, datum);
      else localStorage.removeItem(KLJUC_PRESKAKANJA);
    } catch {
      // vidi gore
    }
  }, []);
  const saljem = useRef(false);
  const ekranRef = useRef(ekran);
  useEffect(() => {
    ekranRef.current = ekran;
  }, [ekran]);

  const prikazi = useCallback(async (stanje: Stanje) => {
    const s = await razresi(stanje);
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

  /** Traži prvo pitanje segmenta (tad na serveru počinje da teče vreme). */
  const posaljiPrvo = (stanje: Stanje) =>
    uradi(async () => {
      const s = await api.pitanje(stanje.datum);
      setZbir(s.score);
      setEkran({ vrsta: "stanje", stanje: s });
    });

  const kreni = (stanje: Stanje) => {
    // Spisak pesama za biranje odgovora neka stigne dok traje odbrojavanje.
    if (stanje.trenutno?.segment === 1) void katalogPesama().catch(() => undefined);
    if (smanjenoKretanje()) void posaljiPrvo(stanje);
    else setEkran({ vrsta: "odbrojavanje", stanje });
  };

  const odgovori = (stanje: Stanje, odgovor: unknown, istek = false, slusanoMs?: number) =>
    uradi(async () => {
      const pitanje = stanje.trenutno!;
      const r = await api.odgovor(stanje.datum, pitanje.itemId, odgovor, istek, slusanoMs);
      // Presuda se još ne vidi: prvo ide napetost (igla klizi, trake se pune), pa `otkrij`.
      setEkran({
        vrsta: "ocena",
        pre: stanje,
        stanje: r.stanje,
        ocena: r.ocena,
        pitanje,
        krajSegmenta: r.krajSegmenta,
        otkriveno: false,
        odlazi: false,
      });
    });

  /** Trenutak istine: zvuk, vibracija, tačkica u zaglavlju i poeni koji lete u zbir. */
  const otkrij = useCallback(() => {
    const e = ekranRef.current;
    if (e.vrsta !== "ocena" || e.otkriveno) return;
    const otkriven: EkranOcene = { ...e, otkriveno: true };
    ekranRef.current = otkriven;
    setEkran(otkriven);
    if (e.ocena.tacno) {
      sfx.ding(nizPogodaka(tokSegmenta(e.stanje, e.pitanje.segment)));
      haptika.tacno();
    } else {
      sfx.bonk();
      haptika.netacno();
    }
    // Zbir u zaglavlju se menja kad poeni „dolete” do njega.
    setTimeout(() => setZbir((z) => Math.max(z, e.stanje.score)), e.ocena.poeni > 0 && !smanjenoKretanje() ? 870 : 0);
  }, []);

  const dalje = useCallback(() => {
    const e = ekranRef.current;
    if (e.vrsta !== "ocena" || !e.otkriveno || e.odlazi) return;
    if (e.krajSegmenta) {
      setZbir(e.stanje.score);
      setEkran({ vrsta: "kraj_segmenta", stanje: e.stanje, segment: e.krajSegmenta });
      return;
    }
    void uradi(async () => {
      // U duelu gubitnik prvo ispadne, pa uleti novi izazivač.
      const duel = e.ocena.prikaz.vrsta === "gugla" && !smanjenoKretanje();
      if (duel) setEkran({ ...e, odlazi: true });
      const [s] = await Promise.all([razresi(e.stanje), cekaj(duel ? 320 : 0)]);
      setZbir(s.score);
      setEkran({ vrsta: "stanje", stanje: s });
      if (duel) sfx.vuus();
    });
  }, [uradi]);

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

  if (ekran.vrsta === "odbrojavanje") {
    const t = ekran.stanje.trenutno!;
    return (
      <>
        <Zaglavlje segment={t.segment} ukupno={t.ukupno} tok={[]} zbir={zbir} />
        <Odbrojavanje naKraj={() => void posaljiPrvo(ekran.stanje)} />
      </>
    );
  }

  if (ekran.vrsta === "kraj_segmenta") {
    return (
      <>
        <Zaglavlje segment={ekran.segment.n} ukupno={ekran.segment.pitanja} tok={ekran.segment.tok} zbir={zbir} />
        <KrajSegmenta segment={ekran.segment} naDalje={() => void uradi(() => prikazi(ekran.stanje))} />
      </>
    );
  }

  // Pitanje i njegov rezultat dele isto zaglavlje: tačkice i niz se menjaju tek kad se rezultat otkrije.
  const pitanje = ekran.vrsta === "ocena" ? ekran.pitanje : ekran.stanje.status === "u_toku" ? ekran.stanje.trenutno : undefined;
  const zaZaglavlje = ekran.vrsta === "ocena" && !ekran.otkriveno ? ekran.pre : ekran.stanje;
  const tok = pitanje ? tokSegmenta(zaZaglavlje, pitanje.segment) : [];
  const zaglavlje = pitanje ? (
    <Zaglavlje segment={pitanje.segment} pozicija={pitanje.pozicija} ukupno={pitanje.ukupno} tok={tok} niz={nizPogodaka(tok)} zbir={zbir} />
  ) : (
    <Zaglavlje zbir={ekran.stanje.status === "zavrseno" ? zbir : 0} />
  );

  // „Šta se više gugla”: pitanje i rezultat su isti ekran (iste kartice), pa se crtaju na istom mestu u stablu.
  const duel =
    ekran.vrsta === "ocena"
      ? ekran.ocena.prikaz.vrsta === "gugla" && ekran.pitanje.pitanje?.vrsta === "gugla"
        ? { t: ekran.pitanje, pitanje: ekran.pitanje.pitanje, ocena: ekran.ocena, otkriveno: ekran.otkriveno, odlazi: ekran.odlazi }
        : null
      : pitanje?.faza === "pitanje" && pitanje.pitanje?.vrsta === "gugla"
        ? { t: pitanje, pitanje: pitanje.pitanje, ocena: undefined, otkriveno: false, odlazi: false }
        : null;

  if (duel) {
    const stanje = ekran.stanje;
    const { t, ocena } = duel;
    return (
      <>
        {zaglavlje}
        <Tajmer
          key={t.itemId}
          limitMs={t.limitMs!}
          preostaloMs={t.preostaloMs!}
          zaustavljen={ceka || Boolean(ocena)}
          naIstek={() => void odgovori(stanje, null, true)}
        />
        <GuglaDuel
          key="duel"
          itemId={t.itemId}
          pitanje={duel.pitanje}
          ocena={ocena}
          otkriveno={duel.otkriveno}
          odlazi={duel.odlazi}
          zakljucano={ceka}
          komentar={ocena?.prikaz.vrsta === "gugla" ? komentarGugla(ocena, ocena.prikaz, t.itemId) : ""}
          naIzbor={(izbor) => void odgovori(stanje, { izbor })}
          naOtkrij={otkrij}
          naDalje={dalje}
        />
      </>
    );
  }

  // „Pogodi pesmu”: pitanje i rezultat su ista komponenta, da muzika ne stane kad se pesma otkrije.
  const pesma =
    ekran.vrsta === "ocena"
      ? ekran.ocena.prikaz.vrsta === "pesma"
        ? { t: ekran.pitanje, ocena: ekran.ocena, otkriveno: ekran.otkriveno }
        : null
      : pitanje?.faza === "pitanje" && pitanje.pitanje?.vrsta === "pesma"
        ? { t: pitanje, ocena: undefined, otkriveno: false }
        : null;

  if (pesma) {
    // Dok se odgovara, „stanje” je ono pre odgovora (iz njega je pitanje poslato).
    const stanje = ekran.vrsta === "ocena" ? ekran.pre : ekran.stanje;
    const { t, ocena } = pesma;
    return (
      <>
        {zaglavlje}
        <PesmaIgra
          key={`pesma${t.itemId}`}
          datum={stanje.datum}
          itemId={t.itemId}
          pocetnoMs={Math.max(0, t.limitMs! - t.preostaloMs!)}
          limitMs={t.limitMs!}
          serverMisliDaSvira={Boolean(t.svira)}
          ocena={ocena}
          otkriveno={pesma.otkriveno}
          zakljucano={ceka}
          komentar={ocena?.prikaz.vrsta === "pesma" ? komentarPesma(ocena, ocena.prikaz, t.itemId) : ""}
          naOdgovor={(odgovor, slusanoMs, istek) => void odgovori(stanje, odgovor, istek, slusanoMs)}
          naOtkrij={otkrij}
          naDalje={dalje}
        />
      </>
    );
  }

  if (ekran.vrsta === "ocena" && ekran.ocena.prikaz.vrsta === "film") {
    const { ocena } = ekran;
    const prikaz = ocena.prikaz as Extract<typeof ocena.prikaz, { vrsta: "film" }>;
    return (
      <>
        {zaglavlje}
        <OkvirOcene
          key={ekran.pitanje.itemId}
          komentar={komentarFilm(ocena, prikaz, ekran.pitanje.itemId)}
          najava={prikaz.odgovor === null && !prikaz.neZnam ? "Vreme je isteklo. To je bio…" : "A to je…"}
          otkriveno={ekran.otkriveno}
          naDalje={dalje}
          ceka={ceka}
        >
          <FilmOcena ocena={ocena} prikaz={prikaz} otkriveno={ekran.otkriveno} naOtkrij={otkrij} />
        </OkvirOcene>
      </>
    );
  }

  if (ekran.vrsta === "ocena" && ekran.ocena.prikaz.vrsta === "joker") {
    const { ocena } = ekran;
    const prikaz = ocena.prikaz as Extract<typeof ocena.prikaz, { vrsta: "joker" }>;
    return (
      <>
        {zaglavlje}
        <OkvirOcene
          key={ekran.pitanje.itemId}
          komentar={komentarJoker(ocena, prikaz, ekran.pitanje.itemId)}
          najava={prikaz.odgovor === null && !prikaz.neZnam ? "Vreme je isteklo. Odgovor je…" : "A odgovor je…"}
          otkriveno={ekran.otkriveno}
          naDalje={dalje}
          ceka={ceka}
        >
          <JokerOcena ocena={ocena} prikaz={prikaz} otkriveno={ekran.otkriveno} naOtkrij={otkrij} />
        </OkvirOcene>
      </>
    );
  }

  if (ekran.vrsta === "ocena") {
    const { ocena } = ekran;
    if (ocena.prikaz.vrsta !== "cena") return null;
    return (
      <>
        {zaglavlje}
        <OkvirOcene
          key={ekran.pitanje.itemId}
          komentar={komentarCena(ocena, ocena.prikaz, ekran.pitanje.itemId)}
          najava={ocena.prikaz.unos === null ? "Vreme je isteklo. Prava cena je…" : "A prava cena je…"}
          otkriveno={ekran.otkriveno}
          naDalje={dalje}
          ceka={ceka}
        >
          <CenaOcena ocena={ocena} prikaz={ocena.prikaz} otkriveno={ekran.otkriveno} naOtkrij={otkrij} />
        </OkvirOcene>
      </>
    );
  }

  const { stanje } = ekran;

  switch (stanje.status) {
    case "nije_povezano":
      return (
        <>
          {zaglavlje}
          <Poruka naslov="Igra još nije povezana">Baza nije podešena, pa nema ni pitanja. Javi onome ko održava sajt.</Poruka>
        </>
      );
    case "nema_kviza":
    case "nije_poceo":
      return (
        <>
          {zaglavlje}
          <Poruka naslov="Današnji kviz još nije spreman">Pitanja za danas još nisu postavljena. Svrati malo kasnije.</Poruka>
        </>
      );
    case "uredjaj_igrao":
      return (
        <>
          {zaglavlje}
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
      // Gost koji još nije birao: prvo „Sačuvaj rezultat i uđi na rang listu”, pa tek onda rezultat.
      if (stanje.lista === "none" && !stanje.prijavljen && preskocio !== stanje.datum) {
        return (
          <>
            {zaglavlje}
            <SacuvajRezultat stanje={stanje} naPreskoci={() => zapamtiPreskakanje(stanje.datum)} />
          </>
        );
      }
      return (
        <>
          {zaglavlje}
          <Kraj stanje={stanje} naSacuvaj={() => zapamtiPreskakanje(null)} />
        </>
      );
    case "u_toku": {
      const t = stanje.trenutno!;
      const segment = stanje.segmenti.find((s) => s.n === t.segment)!;
      if (t.faza !== "pitanje" || !t.pitanje) {
        return (
          <>
            <Zaglavlje segment={t.segment} ukupno={t.ukupno} tok={segment.tok} zbir={zbir} />
            <UvodSegmenta segment={segment} naKreni={() => kreni(stanje)} ceka={ceka} />
          </>
        );
      }
      if (t.pitanje.vrsta !== "cena" && t.pitanje.vrsta !== "film" && t.pitanje.vrsta !== "joker") return null; // pesma i duel su nacrtani gore
      return (
        <>
          {zaglavlje}
          <Tajmer
            key={t.itemId}
            limitMs={t.limitMs!}
            preostaloMs={t.preostaloMs!}
            zaustavljen={ceka}
            naIstek={() => void odgovori(stanje, null, true)}
          />
          {t.pitanje.vrsta === "joker" ? (
            <JokerPitanje key={`j${t.itemId}`} pitanje={t.pitanje} zakljucano={ceka} naOdgovor={(odgovor) => void odgovori(stanje, odgovor)} />
          ) : t.pitanje.vrsta === "film" ? (
            <FilmPitanje key={`f${t.itemId}`} pitanje={t.pitanje} zakljucano={ceka} naOdgovor={(odgovor) => void odgovori(stanje, odgovor)} />
          ) : (
            <CenaPitanje key={`p${t.itemId}`} pitanje={t.pitanje} zakljucano={ceka} naPotvrdi={(unos) => void odgovori(stanje, { unos })} />
          )}
        </>
      );
    }
  }
}
