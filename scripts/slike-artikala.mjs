// Fotografije artikala za „Pogodi cenu”: za svaki barkod iz data/products.json traži zvaničnu
// fotografiju pakovanja u internet prodavnici Maxi, a ako je tamo nema, uzima adresu iz data/slike-rucno.json
// (nađena pretragom po barkodu na Cenoteci). Artikal se traži isključivo po barkodu, pa slika ne može
// da bude od druge gramaže ili ukusa.
//
//   node scripts/slike-artikala.mjs          → tmp/artikli/<barkod>.<format> + tmp/artikli/izvestaj.json
//   node scripts/slike-artikala.mjs --rucno  → samo artikli iz data/slike-rucno.json
//
// Fotografije su vlasništvo proizvođača i trgovaca; da li se koriste na sajtu odlučuje vlasnik sajta.
// Posle preuzimanja se pregledaju i prebacuju u public/artikli/ (vidi README).

import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const KOREN = join(dirname(fileURLToPath(import.meta.url)), "..");
const IZLAZ = join(KOREN, "tmp", "artikli");
const ZAGLAVLJA = {
  "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36",
  "accept-language": "sr-RS,sr;q=0.9,en;q=0.8",
};
const cekaj = (ms) => new Promise((r) => setTimeout(r, ms));

async function maxi(barkod) {
  const promenljive = { lang: "sr", searchQuery: barkod, pageNumber: 0, pageSize: 20, filterFlag: true, fields: "PRODUCT_TILE", plainChildCategories: true, useSpellingSuggestion: true };
  const upit = { persistedQuery: { version: 1, sha256Hash: "1aed18b70ca933de3c1352038f798f0b8375ac515e9d0f93a23556402015418a" } };
  const adresa = `https://www.maxi.rs/api/v1/?operationName=GetProductSearch&variables=${encodeURIComponent(JSON.stringify(promenljive))}&extensions=${encodeURIComponent(JSON.stringify(upit))}`;
  const o = await fetch(adresa, { headers: { ...ZAGLAVLJA, "content-type": "application/json", "x-apollo-operation-name": "GetProductSearch", accept: "application/json" } });
  if (!o.ok) throw new Error(`Maxi ${o.status}`);
  const artikli = (await o.json())?.data?.productSearch?.products ?? [];
  if (artikli.length !== 1) return null;
  const slike = Object.fromEntries((artikli[0].images ?? []).map((s) => [s.format, s.url]));
  const putanja = slike.zoom ?? slike.xlarge ?? slike.respListGrid ?? slike.small;
  if (!putanja) return null;
  return { izvor: "Maxi", nadjeno: artikli[0].name, adrese: [`https://static.maxi.rs${putanja}`] };
}

/** Artikli kojih nema u Maxi prodavnici: adrese fotografija nađene ručno (Cenoteka ne pušta skripte na pretragu). */
const RUCNO = JSON.parse(readFileSync(join(KOREN, "data", "slike-rucno.json"), "utf8")).artikli;
const SAMO_RUCNO = process.argv.includes("--rucno");

async function rucno(barkod) {
  return RUCNO[barkod] ?? null;
}

async function preuzmi(adrese) {
  for (const adresa of adrese) {
    const o = await fetch(adresa, { headers: ZAGLAVLJA });
    const vrsta = o.headers.get("content-type") ?? "";
    if (!o.ok || !vrsta.startsWith("image/")) continue;
    const bajtovi = Buffer.from(await o.arrayBuffer());
    if (bajtovi.length < 2000) continue;
    const format = vrsta.includes("png") ? "png" : vrsta.includes("webp") ? "webp" : vrsta.includes("avif") ? "avif" : "jpg";
    return { adresa, bajtovi, format };
  }
  return null;
}

const proizvodi = JSON.parse(readFileSync(join(KOREN, "data", "products.json"), "utf8")).proizvodi;
mkdirSync(IZLAZ, { recursive: true });
const izvestaj = [];
let n = 0;
for (const p of proizvodi) {
  n++;
  if (SAMO_RUCNO && !RUCNO[p.barkod]) continue;
  const red = { barkod: p.barkod, naziv: `${p.naziv} ${p.kolicina}`, izvor: null, nadjeno: null, adresa: null, fajl: null, greske: [] };
  for (const izvor of SAMO_RUCNO ? [rucno] : [maxi, rucno]) {
    try {
      const nadjen = await izvor(p.barkod);
      await cekaj(250);
      if (!nadjen) continue;
      const slika = await preuzmi(nadjen.adrese);
      if (!slika) {
        red.greske.push(`${nadjen.izvor}: slika nije preuzeta`);
        continue;
      }
      red.izvor = nadjen.izvor;
      red.nadjeno = nadjen.nadjeno;
      red.adresa = slika.adresa;
      red.fajl = `${p.barkod}.${slika.format}`;
      writeFileSync(join(IZLAZ, red.fajl), slika.bajtovi);
      break;
    } catch (e) {
      red.greske.push(String(e?.message ?? e));
    }
  }
  izvestaj.push(red);
  console.log(`${n}/${proizvodi.length} ${red.naziv}: ${red.izvor ?? "NEMA"} ${red.greske.join("; ")}`);
}
writeFileSync(join(IZLAZ, SAMO_RUCNO ? "izvestaj-rucno.json" : "izvestaj.json"), JSON.stringify(izvestaj, null, 1));
console.log(`Gotovo: ${izvestaj.filter((r) => r.fajl).length} od ${izvestaj.length} artikala ima fotografiju.`);
