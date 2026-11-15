"use client";

import { useCallback, useEffect, useMemo, useRef, useState, type CSSProperties } from "react";
import { PESMA_PRAGOVI } from "@/config/quiz.config";
import { IconLupa, IconNota, IconPauza, IconPusti, IconStrelica } from "@/components/icons";
import type { Ocena, OdgovorPesma, PrikazPesma } from "@/lib/game/types";
import { nadjiUKatalogu } from "@/lib/match";
import { sfx } from "@/lib/sound";
import { api, katalogPesama, type PesmaIzKataloga } from "./api";
import { Konfete, Nalepnica, Pecat, smanjenoKretanje } from "./efekti";

/**
 * „Pogodi pesmu”: pusti, slušaj što kraće, izaberi pesmu.
 * Ista komponenta drži i pitanje i njegov rezultat, da plejer ne prestane da svira kad se pesma otkrije.
 *
 * Meri se ukupno preslušano vreme (ne vreme koje je prošlo): pauza zaustavlja sat.
 * Server paralelno vodi svoj račun preko poruka „pušteno / pauzirano”, pa osvežavanje strane ne vraća sat na nulu.
 */

const MERENJE_MS = 700;
/** Tišina između dve pesme. */
const TISINA_MS = 350;
const NAJVISE_PREDLOGA = 4;
const sekunde = (ms: number) => (ms / 1000).toLocaleString("sr-Latn-RS", { minimumFractionDigits: 1, maximumFractionDigits: 1 });

// ───── traka sa zonama ─────

/** Poslednja zona (do kraja klipa) je šira, ostale dele ostatak: inače bi prve tri bile nevidljivo uske. */
const SIRINA_POSLEDNJE = 34;
const ZONE = PESMA_PRAGOVI.map((p, i) => {
  const ostale = (100 - SIRINA_POSLEDNJE) / (PESMA_PRAGOVI.length - 1);
  const poslednja = i === PESMA_PRAGOVI.length - 1;
  return {
    odMs: i === 0 ? 0 : PESMA_PRAGOVI[i - 1].doMs,
    doMs: p.doMs,
    poeni: p.poeni,
    od: i * ostale,
    sirina: poslednja ? SIRINA_POSLEDNJE : ostale,
  };
});

/** Gde je na traci (0–1) dato preslušano vreme. */
function mestoNaTraci(ms: number): number {
  const z = ZONE.find((x) => ms <= x.doMs) ?? ZONE[ZONE.length - 1];
  const uZoni = Math.min(1, Math.max(0, (ms - z.odMs) / (z.doMs - z.odMs)));
  return (z.od + uZoni * z.sirina) / 100;
}

const zonaZa = (ms: number) => ZONE.findIndex((x) => ms <= x.doMs);

// ───── glavna komponenta ─────

export function PesmaIgra({
  datum,
  itemId,
  pocetnoMs,
  limitMs,
  serverMisliDaSvira,
  ocena,
  otkriveno,
  zakljucano,
  komentar,
  naOdgovor,
  naOtkrij,
  naDalje,
}: {
  datum: string;
  itemId: number;
  /** Koliko je već preslušano (posle osvežavanja strane nije nula). */
  pocetnoMs: number;
  limitMs: number;
  serverMisliDaSvira: boolean;
  /** Stiže kad server oceni odgovor. Dok je nema, traje pitanje. */
  ocena?: Ocena;
  otkriveno: boolean;
  zakljucano: boolean;
  komentar: string;
  naOdgovor: (odgovor: OdgovorPesma | null, slusanoMs: number, istek: boolean) => void;
  naOtkrij: () => void;
  naDalje: () => void;
}) {
  const audio = useRef<HTMLAudioElement>(null);
  const traka = useRef<HTMLElement>(null);
  const polje = useRef<HTMLInputElement>(null);
  const koren = useRef<HTMLElement>(null);
  /** Razlika između preslušanog vremena i položaja u klipu (nije nula samo ako premotavanje posle osvežavanja ne uspe). */
  const pomak = useRef(0);
  /** Poruke serveru idu jedna po jedna, redom kojim su nastale. */
  const red = useRef<Promise<unknown>>(Promise.resolve());
  const zavrseno = useRef(false);
  /** Sprečava da dva brza tapa na „Dalje” preskoče pesmu. */
  const odlazi = useRef(false);
  const naOdgovorRef = useRef(naOdgovor);
  const otkrijRef = useRef(naOtkrij);
  useEffect(() => {
    naOdgovorRef.current = naOdgovor;
    otkrijRef.current = naOtkrij;
  }, [naOdgovor, naOtkrij]);

  const [svira, setSvira] = useState(false);
  const [ms, setMs] = useState(pocetnoMs);
  const [greska, setGreska] = useState(false);
  /** Igrač je tapnuo „pusti”, a zvuk još nije krenuo (klip se učitava). Sat za to vreme ne teče. */
  const [ucitava, setUcitava] = useState(false);
  const [pokusaj, setPokusaj] = useState(0);
  const [upit, setUpit] = useState("");
  const [oznacen, setOznacen] = useState(0);
  const [kuca, setKuca] = useState(false);
  const [katalog, setKatalog] = useState<PesmaIzKataloga[]>([]);

  const p = ocena?.prikaz.vrsta === "pesma" ? (ocena.prikaz as PrikazPesma) : undefined;
  const gotovo = Boolean(p);
  useEffect(() => {
    zavrseno.current = gotovo;
  }, [gotovo]);

  const sada = useCallback(() => {
    const a = audio.current;
    return Math.min(limitMs, Math.max(0, Math.round(pomak.current + (a ? a.currentTime * 1000 : 0))));
  }, [limitMs]);

  const javi = useCallback(
    (pusteno: boolean) => {
      red.current = red.current.then(() => api.slusanje(datum, itemId, pusteno)).catch(() => undefined);
    },
    [datum, itemId],
  );

  // Katalog za predloge. Ako ne stigne, i dalje može da se kuca slobodan tekst.
  useEffect(() => {
    let ziv = true;
    katalogPesama()
      .then((k) => ziv && setKatalog(k))
      .catch(() => undefined);
    return () => {
      ziv = false;
    };
  }, []);

  // Posle osvežavanja strane server možda i dalje misli da pesma svira: javi mu da je stala.
  useEffect(() => {
    if (serverMisliDaSvira) javi(false);
    // Samo pri prvom prikazu pitanja.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Plejer: događaji, premotavanje na već preslušano, crtanje trake dok svira.
  useEffect(() => {
    const a = audio.current;
    if (!a) return;
    let kadar = 0;
    let poslednjaDesetinka = -1;

    const crtaj = () => {
      // Posle odgovora traka stoji na preslušanom vremenu, iako muzika svira dalje.
      if (zavrseno.current) return;
      const t = sada();
      if (traka.current) traka.current.style.transform = `scaleX(${mestoNaTraci(t)})`;
      const desetinka = Math.floor(t / 100);
      if (desetinka !== poslednjaDesetinka) {
        poslednjaDesetinka = desetinka;
        setMs(t);
      }
      if (!a.paused && !a.ended) kadar = requestAnimationFrame(crtaj);
    };

    const naMeta = () => {
      if (pocetnoMs > 0 && a.currentTime === 0) {
        try {
          a.currentTime = Math.min(pocetnoMs / 1000, Math.max(0, (a.duration || 30) - 0.05));
        } catch {
          /* premotavanje nije uspelo: nadoknadi razliku pomakom */
        }
      }
      pomak.current = Math.max(0, pocetnoMs - a.currentTime * 1000);
      crtaj();
    };
    const naPusteno = () => {
      setSvira(true);
      setUcitava(false);
      setGreska(false);
      if (!zavrseno.current) javi(true);
      cancelAnimationFrame(kadar);
      kadar = requestAnimationFrame(crtaj);
    };
    const naPauzu = () => {
      setSvira(false);
      setUcitava(false);
      if (!zavrseno.current && !a.ended) javi(false);
      crtaj();
    };
    const naKraj = () => {
      setSvira(false);
      crtaj();
      // Klip je odsviran do kraja bez odgovora.
      if (!zavrseno.current) naOdgovorRef.current(null, limitMs, true);
    };
    const naGresku = () => {
      setSvira(false);
      setUcitava(false);
      setGreska(true);
    };
    const naOdlazak = () => {
      if (!a.paused && !zavrseno.current) void api.slusanje(datum, itemId, false).catch(() => undefined);
    };

    a.addEventListener("loadedmetadata", naMeta);
    a.addEventListener("playing", naPusteno);
    a.addEventListener("pause", naPauzu);
    a.addEventListener("ended", naKraj);
    a.addEventListener("error", naGresku);
    window.addEventListener("pagehide", naOdlazak);
    if (a.readyState >= 1) naMeta();
    else crtaj();
    return () => {
      cancelAnimationFrame(kadar);
      a.removeEventListener("loadedmetadata", naMeta);
      a.removeEventListener("playing", naPusteno);
      a.removeEventListener("pause", naPauzu);
      a.removeEventListener("ended", naKraj);
      a.removeEventListener("error", naGresku);
      window.removeEventListener("pagehide", naOdlazak);
    };
    // `pokusaj` menja adresu klipa, pa se plejer vezuje ponovo.
  }, [datum, itemId, javi, limitMs, pocetnoMs, sada, pokusaj]);

  /**
   * Tvrdo gašenje: na Androidu `pause()` ponekad ne uhvati klip koji se tek pustio,
   * pa se muzika prelivala u sledeću rundu. Zato se izvor i skida sa plejera.
   */
  const ugasiZvuk = useCallback(() => {
    const a = audio.current;
    if (!a) return;
    try {
      a.pause();
      a.currentTime = 0;
      a.removeAttribute("src");
      a.load();
    } catch {
      /* plejer je već sklonjen */
    }
  }, []);

  // Kad igrač ode sa pitanja (sledeće pitanje, kraj segmenta), muzika staje.
  useEffect(() => ugasiZvuk, [ugasiZvuk]);

  const pustiIliPauziraj = useCallback(() => {
    const a = audio.current;
    if (!a) return;
    if (a.paused) {
      if (a.ended) a.currentTime = 0;
      setUcitava(true);
      a.play().catch((e: unknown) => {
        setUcitava(false);
        // Prekid zbog pauze pre nego što je zvuk krenuo nije greška.
        if (!(e instanceof DOMException && e.name === "AbortError")) setGreska(true);
      });
    } else a.pause();
  }, []);

  // Space pušta i pauzira (osim dok se u polje nešto kuca).
  useEffect(() => {
    const naTaster = (e: KeyboardEvent) => {
      if (e.code !== "Space" || e.repeat) return;
      const cilj = e.target as HTMLElement | null;
      if (cilj instanceof HTMLInputElement && cilj.value !== "") return;
      if (cilj instanceof HTMLButtonElement || cilj instanceof HTMLAnchorElement) return;
      e.preventDefault();
      pustiIliPauziraj();
    };
    window.addEventListener("keydown", naTaster);
    return () => window.removeEventListener("keydown", naTaster);
  }, [pustiIliPauziraj]);

  // Odgovor je stigao: kratka napetost, pa otkrivanje. Muzika se nastavlja (ili kreće) uz omot.
  useEffect(() => {
    if (!gotovo) return;
    const trajanje = smanjenoKretanje() ? 0 : MERENJE_MS;
    if (trajanje) sfx.vrti(trajanje);
    const sat = setTimeout(() => {
      otkrijRef.current();
      // Uz omot ide i pesma: nastavlja se tamo gde je stala (ili kreće, ako je igrač nije ni pustio).
      const a = audio.current;
      if (a && a.paused && !a.ended) a.play().catch(() => undefined);
    }, trajanje);
    return () => clearTimeout(sat);
  }, [gotovo]);

  // Traka i brojka se zaustavljaju na vremenu koje je server priznao.
  const konacnoMs = p?.slusanoMs;
  useEffect(() => {
    if (konacnoMs === undefined) return;
    zavrseno.current = true;
    if (traka.current) traka.current.style.transform = `scaleX(${mestoNaTraci(konacnoMs)})`;
  }, [konacnoMs]);

  const posalji = (odgovor: OdgovorPesma) => {
    if (zakljucano || gotovo) return;
    sfx.klik();
    polje.current?.blur();
    const preslusano = sada();
    // Prvo neka stignu poruke „pušteno / pauzirano”, pa odgovor.
    void red.current.then(() => naOdgovorRef.current(odgovor, preslusano, false));
  };

  const nadjeno = useMemo(() => nadjiUKatalogu(katalog, upit, NAJVISE_PREDLOGA), [katalog, upit]);
  const predlozi = gotovo ? [] : nadjeno.stavke;
  const josPredloga = gotovo ? 0 : nadjeno.ukupno - predlozi.length;
  const izabran = Math.min(oznacen, Math.max(0, predlozi.length - 1));
  const posaljiPredlog = (s: PesmaIzKataloga) => posalji({ izbor: { izvodjac: s.izvodjac, naslov: s.naslov }, tekst: `${s.izvodjac} – ${s.naslov}` });

  const prikazanoMs = konacnoMs ?? ms;
  const zona = zonaZa(prikazanoMs);
  const klase = ["g-pesma"];
  if (kuca && !gotovo) klase.push("kuca");
  if (svira) klase.push("svira");

  const plej = (velicina: number, dodatno: string) => (
    <button
      type="button"
      className={`g-plej ${dodatno}`}
      // Tap na dugme ne sme da zatvori tastaturu dok igrač kuca.
      onPointerDown={(e) => e.preventDefault()}
      onClick={pustiIliPauziraj}
      aria-label={svira ? "Pauziraj pesmu" : "Pusti pesmu"}
      aria-pressed={svira}
    >
      {svira ? <IconPauza size={velicina} strokeWidth={3} /> : <IconPusti size={velicina} strokeWidth={2.6} />}
    </button>
  );

  return (
    <section ref={koren} className={klase.join(" ")}>
      <audio ref={audio} src={`/api/track/${itemId}${pokusaj ? `?p=${pokusaj}` : ""}`} preload="auto" playsInline />

      <div className="g-zone" role="timer" aria-label={`Preslušano ${sekunde(prikazanoMs)} sekundi`}>
        <div className="g-zone-put">
          {ZONE.map((z, i) => (
            <span key={z.doMs} className={i === zona ? "g-zona sada" : i < zona ? "g-zona prosla" : "g-zona"} style={{ width: `${z.sirina}%` }}>
              {z.poeni}
            </span>
          ))}
          <i ref={traka} className="g-zone-ispuna" style={{ transform: `scaleX(${mestoNaTraci(prikazanoMs)})` }} />
        </div>
        <p className="g-zone-natpisi" aria-hidden="true">
          {ZONE.map((z) => (
            <span key={z.doMs} style={{ width: `${z.sirina}%` }}>
              {z.doMs / 1000} s
            </span>
          ))}
        </p>
      </div>

      {!gotovo && (
        <>
          <div className="g-pesma-srediste">
            {plej(56, "veliki")}
            <p className="g-pesma-stanje" aria-live="off">
              {greska
                ? "Klip neće da se učita."
                : svira
                  ? `Svira… ${sekunde(ms)} s`
                  : ucitava
                    ? "Učitavam…"
                    : ms > 0
                      ? `Pauza na ${sekunde(ms)} s`
                      : "Pusti pesmu"}
            </p>
            {greska ? (
              <button type="button" className="g-tekst-dugme" onClick={() => setPokusaj((n) => n + 1)}>
                Pokušaj ponovo
              </button>
            ) : (
              <p className="g-opseg center">Što kraće slušaš, to više poena. Pauza ne košta ništa.</p>
            )}
          </div>

          <form
            className="g-pesma-unos"
            onSubmit={(e) => {
              e.preventDefault();
              if (predlozi.length) posaljiPredlog(predlozi[izabran]);
              else if (upit.trim()) posalji({ tekst: upit });
            }}
          >
            <div className="g-pesma-red">
              {plej(28, "mali")}
              <label className="g-pesma-polje">
                <IconLupa size={22} />
                <span className="sr-only">Koja je pesma?</span>
                <input
                  ref={polje}
                  value={upit}
                  onChange={(e) => {
                    setUpit(e.target.value);
                    setOznacen(0);
                  }}
                  onFocus={() => {
                    setKuca(true);
                    // Kad tastatura iskoči, traka sa zonama ostaje na vrhu vidljivog dela.
                    setTimeout(() => koren.current?.scrollIntoView({ block: "start", behavior: "smooth" }), 250);
                  }}
                  onBlur={() => setKuca(false)}
                  onKeyDown={(e) => {
                    if (e.key === "ArrowDown") {
                      e.preventDefault();
                      setOznacen(Math.min(izabran + 1, predlozi.length - 1));
                    } else if (e.key === "ArrowUp") {
                      e.preventDefault();
                      setOznacen(Math.max(izabran - 1, 0));
                    } else if (e.key === "Escape") e.currentTarget.blur();
                  }}
                  placeholder="Izvođač ili naziv pesme"
                  autoComplete="off"
                  autoCorrect="off"
                  autoCapitalize="off"
                  spellCheck={false}
                  enterKeyHint="done"
                  role="combobox"
                  aria-expanded={predlozi.length > 0}
                  aria-controls="g-predlozi"
                  aria-activedescendant={predlozi.length ? `g-predlog-${izabran}` : undefined}
                  disabled={zakljucano}
                />
              </label>
            </div>

            {upit.trim() !== "" && (
              <ul id="g-predlozi" className="g-predlozi" role="listbox">
                {predlozi.map((s, i) => (
                  <li key={`${s.izvodjac}|${s.naslov}`} id={`g-predlog-${i}`} role="option" aria-selected={i === izabran}>
                    <button
                      type="button"
                      className={i === izabran ? "g-predlog oznacen" : "g-predlog"}
                      onPointerDown={(e) => e.preventDefault()}
                      onClick={() => posaljiPredlog(s)}
                      tabIndex={-1}
                    >
                      <strong>{s.naslov}</strong>
                      <span>{s.izvodjac}</span>
                    </button>
                  </li>
                ))}
                {josPredloga > 0 && <li className="g-predlozi-jos">i još {josPredloga}. Kucaj dalje.</li>}
                {predlozi.length === 0 && (
                  <li className="g-predlozi-prazno">Nema je na spisku. Enter šalje ono što si ukucao.</li>
                )}
              </ul>
            )}

            <button type="button" className="g-tekst-dugme g-ne-znam" onClick={() => posalji({ neZnam: true })} aria-disabled={zakljucano}>
              Ne znam
            </button>
          </form>
        </>
      )}

      {p && ocena && (
        <div className="g-pesma-ishod">
          <div className={otkriveno ? "g-otkrivanje otkriveno" : "g-otkrivanje"}>
            <div className="g-omot">
              <span className="g-ploca" aria-hidden="true" />
              {otkriveno ? (
                // eslint-disable-next-line @next/next/no-img-element -- omot stiže sa Deezera, bez obrade na našem serveru
                <img src={p.omot} alt="" width={132} height={132} />
              ) : (
                <span className="g-omot-pitanje" aria-hidden="true">
                  ?
                </span>
              )}
              {otkriveno && ocena.poeni > 0 && <Konfete jacina={ocena.poeni === ocena.maxPoena ? 3 : 2} />}
            </div>
            <div className="g-pesma-ko">
              {otkriveno ? (
                <>
                  <p className="g-pesma-izvodjac">{p.izvodjac}</p>
                  <p className="g-pesma-naslov">{p.naslov}</p>
                  <button type="button" className="g-tekst-dugme g-pesma-pauza" onClick={pustiIliPauziraj}>
                    {svira ? <IconPauza size={18} strokeWidth={3} /> : <IconNota size={18} />}
                    {svira ? "Zaustavi" : "Pusti"}
                  </button>
                </>
              ) : (
                <p className="g-pesma-izvodjac">Bila je to…</p>
              )}
            </div>
          </div>

          {otkriveno && (
            <>
              <p className="g-duel-presuda" role="status">
                <Pecat vrsta={ocena.istek ? "vreme" : p.neZnam ? "neznam" : p.tacno ? "pogodak" : "promasaj"} />
                <Nalepnica poeni={ocena.poeni} />
              </p>
              <p className="g-duel-komentar">{komentar}</p>
              <p className="g-opseg">
                Preslušano {sekunde(p.slusanoMs)} s
                {!p.tacno && p.odgovor && (
                  <>
                    {" "}
                    · tvoj odgovor: <strong>{p.odgovor}</strong>
                  </>
                )}
              </p>
            </>
          )}

          <button
            type="button"
            className="btn btn-lg g-dole"
            onClick={() => {
              if (!otkriveno || odlazi.current) return;
              odlazi.current = true;
              sfx.klik();
              ugasiZvuk();
              // Kratka tišina, da se stara pesma ne prelije u sledeću rundu.
              setTimeout(naDalje, TISINA_MS);
            }}
            aria-disabled={zakljucano || !otkriveno}
            autoFocus
            style={{ "--kasni": "0ms" } as CSSProperties}
          >
            <span>{zakljucano ? "Stiže…" : "Dalje"}</span>
            {!zakljucano && <IconStrelica size={26} />}
          </button>
        </div>
      )}
    </section>
  );
}
