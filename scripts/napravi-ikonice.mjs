// Pravi PNG ikonice za PWA iz src/app/icon.svg.  Pokretanje: node scripts/napravi-ikonice.mjs
import { readFileSync } from "node:fs";
import sharp from "sharp";

const svg = readFileSync("src/app/icon.svg", "utf8");
// Maskable: bez zaobljenih uglova (sistem ih sam seče), znak ostaje u sigurnoj zoni.
const maskable = svg.replace('rx="112"', 'rx="0"');

await sharp(Buffer.from(svg)).resize(192, 192).png().toFile("public/icons/icon-192.png");
await sharp(Buffer.from(svg)).resize(512, 512).png().toFile("public/icons/icon-512.png");
await sharp(Buffer.from(maskable)).resize(512, 512).png().toFile("public/icons/icon-maskable-512.png");
await sharp(Buffer.from(maskable)).resize(180, 180).png().toFile("src/app/apple-icon.png");
console.log("Ikonice su napravljene.");
