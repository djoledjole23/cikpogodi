#!/usr/bin/env node
// Privremeni posao za GitHub Actions (grana sadrzaj-cene-pesme): radi ono što traži mrežu
// (cenovnici sa data.gov.rs, Deezer, iTunes, slike iz Maxi prodavnice) i upisuje rezultat u ci/izlaz/.
// Šta se radi piše u ci/zadatak.json. Ne menja data/ ni public/ osim koraka „slike”.
import { mkdirSync, readFileSync, writeFileSync, existsSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { LANCI, POZNATE_ADRESE, dekodiraj, broj, normBarkod, normDatum } from "../scripts/update-cene.mjs";

const KOREN = join(dirname(fileURLToPath(import.meta.url)), "..");
const IZLAZ = join(KOREN, "ci", "izlaz");
mkdirSync(IZLAZ, { recursive: true });
const zadatak = JSON.parse(readFileSync(join(KOREN, "ci", "zadatak.json"), "utf8"));
const cekaj = (ms) => new Promise((r) => setTimeout(r, ms));
const UA = { "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36", "accept-language": "sr-RS,sr;q=0.9,en;q=0.8" };
const prosto = (s) => String(s ?? "").toLowerCase().replace(/đ/g, "dj").normalize("NFD").replace(/[̀-ͯ]/g, "").replace(/['’`´]/g, "").replace(/[^a-z0-9]+/g, " ").trim();

async function preuzmi(url, kaoJson = false) {
  const o = await fetch(url, { headers: { ...UA, accept: "*/*" }, signal: AbortSignal.timeout(180_000) });
  if (!o.ok) throw new Error(`HTTP ${o.status}`);
  return kaoJson ? o.json() : new Uint8Array(await o.arrayBuffer());
}

function podeliRed(red, sep) {
  const polja = []; let t = ""; let u = false;
  for (let i = 0; i < red.length; i++) {
    const c = red[i];
    if (c === '"') { if (u && red[i + 1] === '"') { t += '"'; i++; } else u = !u; }
    else if (c === sep && !u) { polja.push(t); t = ""; } else t += c;
  }
  polja.push(t);
  return polja.map((p) => p.trim());
}

async function nadjiCenovnike() {
  const poLancu = {};
  const upit = encodeURIComponent("Ценовници производа према Правилнику");
  for (let strana = 1; strana <= 6; strana++) {
    let podaci;
    try { podaci = await preuzmi(`https://data.gov.rs/api/1/datasets/?q=${upit}&page_size=50&page=${strana}`, true); }
    catch (e) { console.warn(`data.gov.rs strana ${strana}: ${e.message}`); break; }
    for (const skup of podaci.data ?? []) {
      const org = `${skup.organization?.name ?? ""} ${skup.title ?? ""}`;
      const lanac = LANCI.find(([re]) => re.test(org))?.[1];
      if (!lanac) continue;
      const adrese = (skup.resources ?? []).filter((r) => /csv/i.test(r.format ?? "") || /\.csv(\?|$)/i.test(r.url ?? ""))
        .sort((a, b) => String(b.last_modified ?? "").localeCompare(String(a.last_modified ?? ""))).map((r) => r.url);
      (poLancu[lanac] ??= []).push(...adrese);
    }
    if ((podaci.data ?? []).length < 50) break;
  }
  for (const [l, a] of Object.entries(POZNATE_ADRESE)) poLancu[l] = [...new Set([...(poLancu[l] ?? []), ...a])];
  return poLancu;
}

/** Ceo cenovnik jednog lanca: barkod → { cene: [], nazivi: Set, kategorije: Set, marke: Set, kolicine: Set }. */
function procitajSve(tekst) {
  const redovi = tekst.split(/\r?\n/).filter((l) => l.trim());
  const sep = [";", ",", "\t"].map((s) => [s, redovi[0].split(s).length]).sort((a, b) => b[1] - a[1])[0][0];
  const zag = podeliRed(redovi[0], sep).map((h) => h.toLowerCase());
  const k = (re) => zag.findIndex((h) => re.test(h));
  const iB = k(/barkod|bar-kod|bar kod/), iR = k(/redovna cena/), iV = k(/vrsta/), iD = k(/datum cenovnika/);
  const iN = k(/naziv proizvoda|^naziv$|naziv artikla|naziv/), iK = k(/kategorij/), iM = k(/marka|brend/), iJ = k(/jedinica|kolicin|količin|neto/);
  if (iB < 0 || iR < 0) throw new Error(`zaglavlje: ${zag.join(" | ")}`);
  let podaci = redovi.slice(1).map((r) => podeliRed(r, sep));
  if (iV >= 0 && podaci.some((r) => /va[zž]e[cć]i/i.test(r[iV] || ""))) podaci = podaci.filter((r) => /va[zž]e[cć]i/i.test(r[iV] || ""));
  if (iD >= 0) {
    const datumi = podaci.map((r) => normDatum(r[iD])).filter(Boolean);
    const d = datumi.sort().at(-1);
    if (d && new Set(datumi).size > 1) podaci = podaci.filter((r) => normDatum(r[iD]) === d);
  }
  const m = new Map();
  for (const r of podaci) {
    const b = normBarkod(r[iB]); const c = broj(r[iR]);
    if (!b || b.length < 8 || !(c > 0)) continue;
    const z = m.get(b) ?? { cene: [], nazivi: new Set(), kategorije: new Set(), marke: new Set(), jedinice: new Set() };
    z.cene.push(c);
    if (iN >= 0 && r[iN]) z.nazivi.add(r[iN]);
    if (iK >= 0 && r[iK]) z.kategorije.add(r[iK]);
    if (iM >= 0 && r[iM]) z.marke.add(r[iM]);
    if (iJ >= 0 && r[iJ]) z.jedinice.add(r[iJ]);
    m.set(b, z);
  }
  return { mapa: m, zaglavlje: zag, primer: podaci.slice(0, 3) };
}

async function kandidatiCene() {
  const postojeci = new Set(JSON.parse(readFileSync(join(KOREN, "data", "products.json"), "utf8")).proizvodi.map((p) => normBarkod(p.barkod)));
  const poLancu = await nadjiCenovnike();
  const lanci = {}; const izvestaj = {};
  for (const [lanac, adrese] of Object.entries(poLancu)) {
    for (const url of adrese.slice(0, 4)) {
      try {
        const r = procitajSve(dekodiraj(await preuzmi(url)));
        if (r.mapa.size < 500) { izvestaj[lanac] = `${url}: samo ${r.mapa.size} artikala`; continue; }
        lanci[lanac] = r.mapa; izvestaj[lanac] = { url, artikala: r.mapa.size, zaglavlje: r.zaglavlje, primer: r.primer };
        break;
      } catch (e) { izvestaj[lanac] = `${url}: ${e.message}`; }
    }
  }
  const svi = new Map();
  for (const [lanac, mapa] of Object.entries(lanci)) for (const [b, z] of mapa) {
    const s = svi.get(b) ?? { barkod: b, lanci: {}, nazivi: [], kategorije: [], marke: [], jedinice: [] };
    s.lanci[lanac] = Math.round((z.cene.reduce((a, x) => a + x, 0) / z.cene.length) * 100) / 100;
    s.nazivi.push(...z.nazivi); s.kategorije.push(...z.kategorije); s.marke.push(...z.marke); s.jedinice.push(...z.jedinice);
    svi.set(b, s);
  }
  const kandidati = [...svi.values()].filter((s) => Object.keys(s.lanci).length >= 4 && !postojeci.has(s.barkod)).map((s) => ({
    barkod: s.barkod, broj_lanaca: Object.keys(s.lanci).length, lanci: s.lanci,
    nazivi: [...new Set(s.nazivi)].slice(0, 4), kategorije: [...new Set(s.kategorije)].slice(0, 3), marke: [...new Set(s.marke)].slice(0, 2), jedinice: [...new Set(s.jedinice)].slice(0, 2),
  })).sort((a, b) => b.broj_lanaca - a.broj_lanaca);
  writeFileSync(join(IZLAZ, "cene-izvestaj.json"), JSON.stringify(izvestaj, null, 1));
  writeFileSync(join(IZLAZ, "cene-kandidati.json"), JSON.stringify({ preuzeto: new Date().toISOString(), lanci: Object.keys(lanci), broj: kandidati.length, kandidati }, null, 0));
  console.log(`kandidati: ${kandidati.length}, lanci: ${Object.keys(lanci).join(", ")}`);
}

async function deezer(putanja) {
  for (let p = 1; p <= 6; p++) {
    await cekaj(150);
    try {
      const j = await (await fetch(`https://api.deezer.com/${putanja}`)).json();
      if (j?.error?.code === 4) { await cekaj(2500 * p); continue; }
      if (j?.error) return { greska: j.error.message ?? String(j.error.code) };
      return j;
    } catch (e) { if (p === 6) return { greska: String(e) }; await cekaj(1500 * p); }
  }
  return { greska: "previše poziva" };
}

async function itunes(izvodjac, naslov) {
  try {
    await cekaj(3200);
    const j = await (await fetch(`https://itunes.apple.com/search?term=${encodeURIComponent(`${izvodjac} ${naslov}`)}&entity=song&limit=10&country=rs`, { headers: UA })).json();
    const r = (j.results ?? []).find((t) => prosto(t.artistName).includes(prosto(izvodjac).split(" ")[0]) && prosto(t.trackName).startsWith(prosto(naslov)) && t.previewUrl);
    return r?.trackId ?? null;
  } catch { return null; }
}

async function pesme() {
  const ulaz = JSON.parse(readFileSync(join(KOREN, "ci", "pesme-ulaz.json"), "utf8")).pesme;
  const nadjene = []; const nije = [];
  for (const p of ulaz) {
    const q = encodeURIComponent(`artist:"${p.izvodjac}" track:"${p.naslov}"`);
    let r = await deezer(`search?q=${q}&limit=25`);
    let lista = r.data ?? [];
    if (!lista.length) { r = await deezer(`search?q=${encodeURIComponent(`${p.izvodjac} ${p.naslov}`)}&limit=25`); lista = r.data ?? []; }
    const pi = prosto(p.izvodjac), pn = prosto(p.naslov);
    const dobri = lista.filter((t) => t.preview && t.readable !== false && prosto(t.artist?.name) === pi && (prosto(t.title) === pn || prosto(t.title_short) === pn))
      .filter((t) => !/live|uzivo|uživo|remix|karaoke|instrumental|acoustic/i.test(`${t.title} ${t.title_version ?? ""}`))
      .sort((a, b) => (b.rank ?? 0) - (a.rank ?? 0));
    const t = dobri[0];
    if (!t) { nije.push({ ...p, razlog: r.greska ?? `nema tačnog pogotka (prvi: ${lista[0] ? `${lista[0].artist?.name} – ${lista[0].title}` : "ništa"})` }); continue; }
    nadjene.push({ izvodjac: p.izvodjac, naslov: p.naslov, zanr: p.zanr, deezer_id: t.id, omot: t.album?.cover_medium ?? null, itunes_id: await itunes(p.izvodjac, p.naslov), deezer_naslov: t.title, rank: t.rank ?? null });
    console.log(`✓ ${p.izvodjac} – ${p.naslov}`);
  }
  writeFileSync(join(IZLAZ, "pesme.json"), JSON.stringify({ provereno: new Date().toISOString(), nadjene, nije_nadjeno: nije }, null, 1));
  console.log(`pesme: nađeno ${nadjene.length}, nije ${nije.length}`);
}

async function maxiSlika(barkod) {
  const promenljive = { lang: "sr", searchQuery: barkod, pageNumber: 0, pageSize: 20, filterFlag: true, fields: "PRODUCT_TILE", plainChildCategories: true, useSpellingSuggestion: true };
  const upit = { persistedQuery: { version: 1, sha256Hash: "1aed18b70ca933de3c1352038f798f0b8375ac515e9d0f93a23556402015418a" } };
  const adresa = `https://www.maxi.rs/api/v1/?operationName=GetProductSearch&variables=${encodeURIComponent(JSON.stringify(promenljive))}&extensions=${encodeURIComponent(JSON.stringify(upit))}`;
  const o = await fetch(adresa, { headers: { ...UA, "content-type": "application/json", "x-apollo-operation-name": "GetProductSearch", accept: "application/json" } });
  if (!o.ok) return null;
  const a = (await o.json())?.data?.productSearch?.products ?? [];
  if (a.length !== 1) return null;
  const s = Object.fromEntries((a[0].images ?? []).map((x) => [x.format, x.url]));
  const p = s.zoom ?? s.xlarge ?? s.respListGrid ?? s.small;
  return p ? { url: `https://static.maxi.rs${p}`, naziv: a[0].name, izvor: "Maxi" } : null;
}

async function slike() {
  const { default: sharp } = await import("sharp");
  const barkodovi = JSON.parse(readFileSync(join(KOREN, "ci", "slike-ulaz.json"), "utf8")).barkodovi;
  const dir = join(KOREN, "public", "artikli");
  const rez = {};
  for (const b of barkodovi) {
    if (existsSync(join(dir, `${b}.webp`))) { rez[b] = "već postoji"; continue; }
    let izvor = null;
    try { izvor = await maxiSlika(b); } catch {}
    // Samo zvanična fotografija iz Maxi prodavnice, tražena po barkodu (kao scripts/slike-artikala.mjs).
    if (!izvor) { rez[b] = "nema slike u Maxi prodavnici"; continue; }
    try {
      const o = await fetch(izvor.url, { headers: UA });
      if (!o.ok) { rez[b] = `HTTP ${o.status}`; continue; }
      const bajtovi = Buffer.from(await o.arrayBuffer());
      await sharp(bajtovi).flatten({ background: "#ffffff" }).resize(640, 640, { fit: "inside", withoutEnlargement: true }).webp({ quality: 82 }).toFile(join(dir, `${b}.webp`));
      rez[b] = izvor;
    } catch (e) { rez[b] = String(e); }
    await cekaj(400);
  }
  writeFileSync(join(IZLAZ, "slike.json"), JSON.stringify(rez, null, 1));
  console.log(`slike: ${Object.values(rez).filter((x) => typeof x === "object").length} novih`);
}

const KORACI = { "kandidati-cene": kandidatiCene, pesme, slike };
for (const k of zadatak.koraci) { console.log(`── ${k}`); await KORACI[k](); }
