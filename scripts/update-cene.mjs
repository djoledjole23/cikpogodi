#!/usr/bin/env node
/**
 * update-cene: osvežava data/products.json iz zvaničnih cenovnika trgovinskih lanaca.
 *
 * Šta radi:
 *   1. čita postojeći data/products.json: spisak artikala (po barkodu) ostaje isti, menjaju se samo cene
 *   2. preko data.gov.rs API-ja nalazi CSV cenovnike lanaca (uz rezervni spisak poznatih adresa)
 *   3. iz svakog cenovnika uzima REDOVNU cenu (bez akcija) za naše barkodove; unutar lanca prosek svih objekata
 *   4. cena artikla = prosek između lanaca; uz to min, max i najjeftiniji lanac
 *   5. artiklima bez slike traži sliku na Open Food Facts po barkodu
 *   6. upisuje novi products.json
 *
 * Pravila:
 *   - Cena se nikad ne izmišlja. Artikal koji nije nađen u bar MIN_LANACA lanaca se izbacuje (i prijavljuje).
 *   - Artikal bez slike ostaje u fajlu, ali ga igra ne koristi.
 *   - Ako nešto izgleda pogrešno (premalo artikala, premalo lanaca), stari fajl ostaje netaknut.
 *
 * Pokretanje:   npm run update-cene            (Node 18+, bez dodatnih paketa)
 *               npm run update-cene -- --suvo  (samo izveštaj, ništa se ne upisuje)
 * Podešavanja (promenljive okruženja):
 *   MIN_LANACA=3        u koliko najmanje lanaca artikal mora da postoji
 *   MIN_PROIZVODA=40    ako ostane manje artikala sa cenom, ništa se ne upisuje
 *   NAJVECI_SKOK=40     promena cene u % preko koje se artikal izbacuje kao sumnjiv
 *   BEZ_SLIKA=1         preskoči Open Food Facts
 *   KONTAKT=mejl        ide u User-Agent (Open Food Facts to traži)
 *
 * Posle osvežavanja: `npm run seed -- <datum> <dana>` pravi SQL za nove dane kviza.
 * Dani koji su već u bazi zadržavaju cenu sa kojom su napravljeni.
 */
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

const KOREN = join(dirname(fileURLToPath(import.meta.url)), "..");
const FAJL = process.env.IZLAZ || join(KOREN, "data", "products.json");
const API = "https://data.gov.rs/api/1";
const OFF = "https://world.openfoodfacts.org/api/v2/product";

/** Kako se organizacija sa portala zove u igri. Redosled je bitan: prvi pogodak pobeđuje. */
export const LANCI = [
  [/delhaize|delez|maxi/i, "Maxi"],
  [/lidl/i, "Lidl"],
  [/mercator|merkator|idea/i, "Idea"],
  [/univerexport|univereksport/i, "Univerexport"],
  [/gomex|gomeks/i, "Gomex"],
  [/aman/i, "Aman"],
  [/veropoulos|veropulos|\bvero\b/i, "Super Vero"],
];

/** Rezerva ako pretraga portala ne nađe lanac. Samo adrese bez pristupnih tokena. */
export const POZNATE_ADRESE = {
  Maxi: ["https://tsmdelhaizeserbia.delhaize.rs/PublicDoc/cene_proizvoda_Delhaize.csv"],
  Lidl: ["https://www.lidl.rs/explore/assets/webPriceData/rs/cene_proizvoda_Lidl.csv"],
  Idea: ["https://ideacenovnici.blob.core.windows.net/cenovnici/drzavni/cene_proizvoda_ideamarketi.csv"],
  Univerexport: ["https://ucloud.univerexport.rs/opendata/univer.csv"],
  Gomex: ["https://aswcene.gomex.rs/upload/cene_proizvoda_gomex.csv"],
};

// ───────────────────────── čitanje CSV-a ─────────────────────────

/** Bajtovi → tekst. Cenovnici su u UTF-8 ili windows-1250. */
export function dekodiraj(bajtovi) {
  let tekst = new TextDecoder("utf-8").decode(bajtovi);
  if ((tekst.match(/�/g) || []).length > 20) tekst = new TextDecoder("windows-1250").decode(bajtovi);
  return tekst.replace(/^﻿/, "");
}

function podeliRed(red, sep) {
  const polja = [];
  let tekuce = "";
  let uNavodnicima = false;
  for (let i = 0; i < red.length; i++) {
    const c = red[i];
    if (c === '"') {
      if (uNavodnicima && red[i + 1] === '"') {
        tekuce += '"';
        i++;
      } else uNavodnicima = !uNavodnicima;
    } else if (c === sep && !uNavodnicima) {
      polja.push(tekuce);
      tekuce = "";
    } else tekuce += c;
  }
  polja.push(tekuce);
  return polja.map((s) => s.trim());
}

/** „1.234,56”, „1234.56”, „1 234,5” → broj. */
export function broj(s) {
  if (!s) return NaN;
  let t = String(s).replace(/\s/g, "");
  if (/,\d{1,2}$/.test(t)) t = t.replace(/\./g, "").replace(",", ".");
  else t = t.replace(/,/g, "");
  return parseFloat(t);
}

/** Barkod sveden na cifre bez vodećih nula, da se „08600…” i „8600…” poklope. */
export const normBarkod = (s) => String(s ?? "").replace(/\D/g, "").replace(/^0+/, "");

/** „13-11-2026”, „13.11.2026.”, „2026-11-13” → „2026-11-13” (ili null). */
export function normDatum(s) {
  const t = String(s ?? "").trim();
  let m = t.match(/^(\d{4})-(\d{1,2})-(\d{1,2})/);
  if (m) return `${m[1]}-${m[2].padStart(2, "0")}-${m[3].padStart(2, "0")}`;
  m = t.match(/^(\d{1,2})[-./](\d{1,2})[-./](\d{4})/);
  if (m) return `${m[3]}-${m[2].padStart(2, "0")}-${m[1].padStart(2, "0")}`;
  return null;
}

/**
 * Iz jednog cenovnika izvlači redovne cene za tražene barkodove.
 * Vraća { cene: Map(barkod → [cena, cena...]), datum, redova } ili baca grešku ako fajl nije cenovnik.
 */
export function procitajCenovnik(tekst, trazeni) {
  const redovi = tekst.split(/\r?\n/).filter((l) => l.trim());
  if (redovi.length < 2) throw new Error("prazan fajl");
  const sep = [";", ",", "\t"]
    .map((s) => [s, redovi[0].split(s).length])
    .sort((a, b) => b[1] - a[1])[0][0];
  const zaglavlje = podeliRed(redovi[0], sep).map((h) => h.toLowerCase());
  const kolona = (re) => zaglavlje.findIndex((h) => re.test(h));

  const iBarkod = kolona(/barkod|bar-kod|bar kod/);
  const iRedovna = kolona(/redovna cena/);
  const iVrsta = kolona(/vrsta/);
  const iDatum = kolona(/datum cenovnika/);
  if (iBarkod < 0 || iRedovna < 0) {
    throw new Error(`nema kolona „barkod” i „redovna cena” (zaglavlje: ${zaglavlje.slice(0, 8).join(" | ")})`);
  }

  let podaci = redovi.slice(1).map((r) => podeliRed(r, sep));
  // Neki lanci u istom fajlu drže i stare preseke: uzmi samo važeći cenovnik.
  if (iVrsta >= 0 && podaci.some((r) => /va[zž]e[cć]i/i.test(r[iVrsta] || ""))) {
    podaci = podaci.filter((r) => /va[zž]e[cć]i/i.test(r[iVrsta] || ""));
  }
  // Ako i dalje ima više datuma, uzmi najnoviji.
  let datum = null;
  if (iDatum >= 0) {
    const datumi = podaci.map((r) => normDatum(r[iDatum])).filter(Boolean);
    datum = datumi.sort().at(-1) ?? null;
    if (datum && new Set(datumi).size > 1) podaci = podaci.filter((r) => normDatum(r[iDatum]) === datum);
  }

  const cene = new Map();
  for (const r of podaci) {
    const barkod = normBarkod(r[iBarkod]);
    if (!trazeni.has(barkod)) continue;
    const cena = broj(r[iRedovna]);
    if (!(cena > 0)) continue;
    if (!cene.has(barkod)) cene.set(barkod, []);
    cene.get(barkod).push(cena);
  }
  return { cene, datum, redova: podaci.length };
}

// ───────────────────────── računanje ─────────────────────────

const zaokruzi2 = (x) => Math.round(x * 100) / 100;
const prosek = (niz) => niz.reduce((a, b) => a + b, 0) / niz.length;

/**
 * Spaja cene iz svih lanaca u novi spisak artikala.
 * `poLancima`: { "Lidl": Map(barkod → [cene]), ... }
 */
export function izracunaj(stari, poLancima, opcije = {}) {
  const minLanaca = opcije.minLanaca ?? 3;
  const najveciSkok = opcije.najveciSkok ?? 40;
  const proizvodi = [];
  const izbaceni = [];

  for (const p of stari) {
    const kljuc = normBarkod(p.barkod);
    const cene = {};
    for (const [lanac, mapa] of Object.entries(poLancima)) {
      const lista = mapa.get(kljuc);
      // Unutar lanca: prosek svih objekata/formata.
      if (lista?.length) cene[lanac] = zaokruzi2(prosek(lista));
    }
    const lanci = Object.keys(cene);
    const ime = `${p.naziv} ${p.kolicina}`;
    if (lanci.length < minLanaca) {
      izbaceni.push({ naziv: ime, razlog: `nađen u ${lanci.length} lanaca (treba bar ${minLanaca})` });
      continue;
    }
    const vrednosti = Object.values(cene);
    const tacna = zaokruzi2(prosek(vrednosti));
    const min = Math.min(...vrednosti);
    const promena = p.cena_tacna > 0 ? ((tacna - p.cena_tacna) / p.cena_tacna) * 100 : 0;
    if (Math.abs(promena) > najveciSkok) {
      izbaceni.push({ naziv: ime, razlog: `cena skočila ${promena.toFixed(0)}% (${p.cena_tacna} → ${tacna}): proveri ručno` });
      continue;
    }
    proizvodi.push({
      id: p.id ?? p.barkod,
      barkod: p.barkod,
      naziv: p.naziv,
      kolicina: p.kolicina,
      kategorija: p.kategorija,
      cena_rsd: Math.round(tacna),
      cena_tacna: tacna,
      cena_min: min,
      cena_max: Math.max(...vrednosti),
      najjeftinije_u: lanci.find((l) => cene[l] === min),
      cene_po_lancima: cene,
      broj_lanaca: lanci.length,
      slika_url: p.slika_url ?? null,
    });
  }
  return { proizvodi, izbaceni };
}

// ───────────────────────── mreža ─────────────────────────

const UA = `CikPogodi/1.0 (update-cene; ${process.env.KONTAKT || "kontakt nije podesen"})`;

async function preuzmi(url, kaoJson = false) {
  const odgovor = await fetch(url, { headers: { "user-agent": UA, accept: "*/*" }, signal: AbortSignal.timeout(120_000) });
  if (!odgovor.ok) throw new Error(`HTTP ${odgovor.status}`);
  return kaoJson ? odgovor.json() : new Uint8Array(await odgovor.arrayBuffer());
}

/** Nalazi CSV adrese cenovnika na data.gov.rs i grupiše ih po lancu. */
async function nadjiCenovnike() {
  const poLancu = {};
  const upit = encodeURIComponent("Ценовници производа према Правилнику");
  for (let strana = 1; strana <= 6; strana++) {
    let podaci;
    try {
      podaci = await preuzmi(`${API}/datasets/?q=${upit}&page_size=50&page=${strana}`, true);
    } catch (e) {
      console.warn(`  ! data.gov.rs pretraga (strana ${strana}): ${e.message}`);
      break;
    }
    for (const skup of podaci.data ?? []) {
      const org = `${skup.organization?.name ?? ""} ${skup.title ?? ""}`;
      const lanac = LANCI.find(([re]) => re.test(org))?.[1];
      if (!lanac) continue;
      const adrese = (skup.resources ?? [])
        .filter((r) => /csv/i.test(r.format ?? "") || /\.csv(\?|$)/i.test(r.url ?? ""))
        .sort((a, b) => String(b.last_modified ?? "").localeCompare(String(a.last_modified ?? "")))
        .map((r) => r.url);
      (poLancu[lanac] ??= []).push(...adrese);
    }
    if ((podaci.data ?? []).length < 50) break;
  }
  for (const [lanac, adrese] of Object.entries(POZNATE_ADRESE)) {
    poLancu[lanac] = [...new Set([...(poLancu[lanac] ?? []), ...adrese])];
  }
  return poLancu;
}

async function slikaSaOff(barkod) {
  try {
    const podaci = await preuzmi(`${OFF}/${barkod}.json?fields=image_front_url`, true);
    const url = podaci?.product?.image_front_url;
    return typeof url === "string" && url.startsWith("https://") ? url : null;
  } catch {
    return null;
  }
}

// ───────────────────────── glavni tok ─────────────────────────

async function glavni() {
  const suvo = process.argv.includes("--suvo");
  const minLanaca = Number(process.env.MIN_LANACA) || 3;
  const minProizvoda = Number(process.env.MIN_PROIZVODA) || 40;
  const najveciSkok = Number(process.env.NAJVECI_SKOK) || 40;

  const stariFajl = JSON.parse(readFileSync(FAJL, "utf8"));
  const stari = stariFajl.proizvodi;
  const trazeni = new Set(stari.map((p) => normBarkod(p.barkod)));
  console.log(`Artikala na spisku: ${stari.length}`);

  console.log("Tražim cenovnike na data.gov.rs…");
  const adrese = await nadjiCenovnike();

  const poLancima = {};
  const datumi = [];
  for (const [, lanac] of LANCI) {
    const lista = adrese[lanac] ?? [];
    let uspelo = false;
    // Lanac može da ima više fajlova (po formatu prodavnice): probaj prvih nekoliko dok jedan ne uspe.
    for (const url of lista.slice(0, 4)) {
      try {
        const { cene, datum, redova } = procitajCenovnik(dekodiraj(await preuzmi(url)), trazeni);
        if (cene.size === 0) throw new Error("nijedan naš barkod u fajlu");
        poLancima[lanac] = cene;
        if (datum) datumi.push(datum);
        console.log(`  ✓ ${lanac}: ${cene.size} artikala (${redova} redova, cenovnik od ${datum ?? "?"})`);
        uspelo = true;
        break;
      } catch (e) {
        console.warn(`  ! ${lanac}: ${e.message}  [${url.slice(0, 70)}]`);
      }
    }
    if (!uspelo) console.warn(`  ✗ ${lanac}: cenovnik nije preuzet`);
  }

  const brojLanaca = Object.keys(poLancima).length;
  if (brojLanaca < minLanaca) {
    console.error(`\nPreuzeto je samo ${brojLanaca} lanaca (treba bar ${minLanaca}). Stari fajl ostaje netaknut.`);
    process.exit(1);
  }

  const { proizvodi, izbaceni } = izracunaj(stari, poLancima, { minLanaca, najveciSkok });
  if (proizvodi.length < minProizvoda) {
    console.error(`\nSa cenom je ostalo samo ${proizvodi.length} artikala (treba bar ${minProizvoda}). Stari fajl ostaje netaknut.`);
    for (const x of izbaceni.slice(0, 20)) console.error(`  - ${x.naziv}: ${x.razlog}`);
    process.exit(1);
  }

  if (!process.env.BEZ_SLIKA) {
    const bezSlike = proizvodi.filter((p) => !p.slika_url);
    if (bezSlike.length) console.log(`Tražim slike za ${bezSlike.length} artikala na Open Food Facts…`);
    for (const p of bezSlike) {
      p.slika_url = await slikaSaOff(p.barkod);
      if (p.slika_url) console.log(`  ✓ slika: ${p.naziv} ${p.kolicina}`);
      await new Promise((r) => setTimeout(r, 700)); // da ne opteretimo njihov server
    }
  }

  // Datum cenovnika: onaj koji se javlja kod najviše lanaca.
  const ucestalost = new Map();
  for (const d of datumi) ucestalost.set(d, (ucestalost.get(d) ?? 0) + 1);
  const datum = [...ucestalost.entries()].sort((a, b) => b[1] - a[1] || b[0].localeCompare(a[0]))[0]?.[0] ?? new Date().toISOString().slice(0, 10);

  const promene = proizvodi
    .map((p) => ({ p, stara: stari.find((s) => s.barkod === p.barkod)?.cena_rsd }))
    .filter((x) => x.stara !== undefined && x.stara !== x.p.cena_rsd);

  console.log(`\nCenovnik od: ${datum} · lanaca: ${brojLanaca}`);
  console.log(`Sa cenom: ${proizvodi.length} · sa slikom (igra ih koristi): ${proizvodi.filter((p) => p.slika_url).length}`);
  console.log(`Promenjena cena: ${promene.length}`);
  for (const { p, stara } of promene.slice(0, 15)) console.log(`  ${p.naziv} ${p.kolicina}: ${stara} → ${p.cena_rsd} din`);
  if (promene.length > 15) console.log(`  … i još ${promene.length - 15}`);
  if (izbaceni.length) {
    console.log(`Izbačeno: ${izbaceni.length}`);
    for (const x of izbaceni) console.log(`  - ${x.naziv}: ${x.razlog}`);
  }

  if (suvo) {
    console.log("\n--suvo: ništa nije upisano.");
    return;
  }
  const novi = {
    izvor: `Zvanični cenovnici trgovinskih lanaca (Portal otvorenih podataka, data.gov.rs) – ${Object.keys(poLancima).join(", ")}`,
    datum_cenovnika: datum,
    napomena: stariFajl.napomena,
    slike: stariFajl.slike,
    broj_proizvoda: proizvodi.length,
    proizvodi,
  };
  writeFileSync(FAJL, JSON.stringify(novi, null, 2) + "\n");
  console.log(`\nUpisano: ${FAJL}`);
  console.log("Sledeće: npm run seed -- <prvi dan> <broj dana>   (pravi SQL za nove dane kviza)");
}

// Pokreni samo kad je skripta pozvana direktno (testovi uvoze funkcije odozgo).
if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  glavni().catch((e) => {
    console.error("update-cene nije uspeo:", e.message);
    process.exit(1);
  });
}
