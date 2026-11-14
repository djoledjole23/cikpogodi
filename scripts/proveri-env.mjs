// Provera fajla .env.local: ispisuje koji redovi postoje i da li su popunjeni.
// NIKAD ne ispisuje same vrednosti — samo dužinu i početak, da se vidi da je nešto tu.
import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";

const fajl = join(process.cwd(), ".env.local");
if (!existsSync(fajl)) {
  console.log("\n  Fajl .env.local NE POSTOJI. Pokreni podesi.bat da ga napravis.\n");
  process.exit(0);
}

const tekst = readFileSync(fajl, "utf8");
const imaBom = tekst.charCodeAt(0) === 0xfeff;
const redovi = tekst.replace(/^﻿/, "").split(/\r?\n/);

const vrednosti = new Map();
for (const red of redovi) {
  const t = red.trim();
  if (!t || t.startsWith("#")) continue;
  const i = t.indexOf("=");
  if (i < 1) continue;
  vrednosti.set(t.slice(0, i).trim(), t.slice(i + 1).trim());
}

const trazeni = [
  ["NEXT_PUBLIC_SITE_URL", true],
  ["NEXT_PUBLIC_SUPABASE_URL", true],
  ["NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY", false],
  ["NEXT_PUBLIC_SUPABASE_ANON_KEY", false],
  ["SUPABASE_SECRET_KEY", true],
  ["DATABASE_URL", true],
];

console.log("\n  Provera fajla .env.local");
console.log("  (vrednosti se NE ispisuju, samo da li su tu)\n");
if (imaBom) console.log("  ! Fajl ima nevidljiv znak na pocetku (BOM). Sacuvaj ga ponovo u Notepad-u kao UTF-8.\n");

for (const [ime] of trazeni) {
  const v = vrednosti.get(ime);
  if (v === undefined) {
    console.log(`  ${ime.padEnd(38)} nema tog reda`);
  } else if (!v) {
    console.log(`  ${ime.padEnd(38)} PRAZNO`);
  } else {
    const pocetak = ime.includes("URL") ? ` (pocinje sa: ${v.slice(0, 12)}...)` : "";
    console.log(`  ${ime.padEnd(38)} popunjeno, ${v.length} znakova${pocetak}`);
  }
}

const url = vrednosti.get("NEXT_PUBLIC_SUPABASE_URL") ?? "";
const kljuc = vrednosti.get("NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY") || vrednosti.get("NEXT_PUBLIC_SUPABASE_ANON_KEY") || "";
console.log("");
if (url && kljuc) console.log("  => Nalozi bi trebalo da rade. Ako ne rade, ugasi crni prozor i pokreni pokreni.bat ponovo.");
else console.log("  => Nalozi NE RADE. Fali: " + [!url && "adresa projekta", !kljuc && "publishable/anon kljuc"].filter(Boolean).join(" i "));
console.log("");
