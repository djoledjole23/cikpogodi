// Širi spisak pesama za biranje odgovora u „Pogodi pesmu” (data/katalog.json).
//
// U kvizu se puštaju samo pesme iz data/songs.json. Ovaj spisak služi da izbor bude težak:
// kad igrač ukuca izvođača, vidi desetine njegovih pesama, a ne samo onu koja se pušta.
// Naslovi se ne izmišljaju: uzimaju se sa Deezera (najslušanije pesme izvođača).
//
//   node scripts/katalog-pesama.mjs preuzmi   → tmp/katalog-sirovo.json (traži internet, traje oko 2 minuta)
//   node scripts/katalog-pesama.mjs napravi   → data/katalog.json (čisti i slaže ono što je preuzeto)

import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const KOREN = join(dirname(fileURLToPath(import.meta.url)), "..");
const SIROVO = join(KOREN, "tmp", "katalog-sirovo.json");
const IZLAZ = join(KOREN, "data", "katalog.json");

/** Koliko pesama po izvođaču se traži od Deezera, a koliko najviše ostaje u spisku (izvođači iz kviza / ostali). */
const TRAZI_PO_IZVODJACU = 50;
const NAJVISE_PO_IZVODJACU = { uKvizu: 30, ostali: 20 };

/** Izvođači kojih nema u kvizu, a čije pesme ulaze u spisak za biranje. */
const DODATNI_IZVODJACI = [
  // narodna i folk
  "Jelena Karleuša", "Viki Miljković", "Goca Božinovska", "Nada Topčagić", "Šeki Turković", "Halid Bešlić",
  "Halid Muslimović", "Šerif Konjević", "Hanka Paldum", "Haris Džinović", "Snežana Đurišić", "Mira Škorić",
  "Biljana Jevtić", "Suzana Jovanović", "Sanja Đorđević", "Neda Ukraden", "Ljuba Aličić", "Kemal Malovčić",
  "Era Ojdanić", "Bora Drljača", "Miloš Bojanić", "Dragan Kojić Keba", "Vuk Mob", "Sloba Radanović",
  "Mirza Selimović", "Katarina Grujić", "Katarina Živković", "Olja Karleuša", "Slavica Ćukteraš",
  "Nataša Đorđević", "Zorica Marković", "Vera Matović", "Merima Njegomir", "Cune Gojković", "Novica Zdravković",
  "Nino Rešić", "Jašar Ahmedovski", "Ipče Ahmedovski", "Zlata Petrović", "Stojanka Novaković Stoja",
  "Jovan Perišić", "Dejan Matić", "Darko Filipović", "Ćana", "Bane Mojićević", "Milan Mitrović",
  "Tina Ivanović", "Sandra Afrika", "Barbara Bobak", "Andreana Čekić", "Mia Borisavljević", "Dušan Svilar",
  "Zvonko Bogdan", "Staniša Stošić", "Vasilija Radojčić", "Silvana Armenulić", "Safet Isović",
  // pop i zabavna
  "Dino Merlin", "Hari Mata Hari", "Crvena Jabuka", "Plavi Orkestar", "Magazin", "Novi Fosili",
  "Oliver Dragojević", "Gibonni", "Petar Grašo", "Tony Cetinski", "Nina Badrić", "Doris Dragović",
  "Danijela Martinović", "Lana Jurčević", "Sergej Ćetković", "Bojan Marović", "Željko Vasić", "Tropico Band",
  "Amadeus Band", "Miligram", "Tap 011", "Ksenija Pajčin", "Leontina", "Nikola Rokvić", "Dženan Lončarević",
  "Lena Kovačević", "Kaliopi", "Karolina Gočeva", "Kemal Monteno", "Arsen Dedić", "Mišo Kovač",
  "Tereza Kesovija", "Miki Jevremović", "Đorđe Marjanović", "Milan Stanković", "Luke Black", "Angellina",
  "Edita Aradinović", "Anastasija Ražnatović", "Zorja", "Princ od Vranje", "Bane Opačić", "Nevena Božović",
  "Mirna Radulović", "Ivana Peters", "Bebi Dol", "Zdravko Čolić", "Boris Novković", "Jura Stublić",
  "Vanna", "Jelena Rozga", "Lepa Brena", "Maja Šuput", "Franka Batelić", "Nikola Vranjković",
  // rok
  "Bijelo Dugme", "Parni Valjak", "Prljavo Kazalište", "Azra", "Haustor", "Disciplina Kičme",
  "Atomsko Sklonište", "Divlje Jagode", "Indexi", "Leb i Sol", "Zabranjeno Pušenje", "Đavoli", "Psihomodo Pop",
  "Hladno Pivo", "Let 3", "Block Out", "Kanda, Kodža i Nebojša", "Darkwood Dub", "Eyesburn", "Orthodox Celts",
  "Ritam Nereda", "Atheist Rap", "Zbogom Brus Li", "Prljavi Inspektor Blaža i Kljunovi", "Vampiri", "Ruž",
  "Oktobar 1864", "Bjesovi", "Deca Loših Muzičara", "Dado Topić", "Vlatko Stefanovski", "Daleka Obala",
  "Željko Bebek", "Goran Bregović", "Alen Islamović", "Mladen Vojičić Tifa", "Dejan Petrović Big Band",
  "Zemlja Gruva", "Lutajuća Srca", "Tonny Montano", "Slađana Milošević", "Viktorija", "Rokeri s Moravu",
  "Laboratorija Zvuka", "Bulevar", "Suncokret", "Korni Grupa", "Pop Mašina", "Film", "Buldožer", "Pankrti",
  "Lačni Franz", "Prljavi Inspektor Blaža", "Tajči", "Dino Dvornik", "Elvis J. Kurtović",
  // trep i hip-hop
  "Rimski", "Breskvica", "Nucci", "Devito", "THCF", "Sajsi MC", "Crni Cerak", "Lacku", "Gazda Paja",
  "Ajs Nigrutin", "Wikluh Sky", "Struka", "Cvija", "MC Stojan", "Desingerica", "Zli Toni", "Mahrina",
  "Corona", "Henny", "Inas", "Vuk Mob", "Tanja Savić", "Edo Maajka", "Frenkie", "Who See", "Sky Wikluh",
  "Bvana iz Lagune", "Marlon Brutal", "Smoke Mardeljano", "Fox", "Mili", "Kendi", "Albino", "Biba",
  "Pablo Kenedi", "Vojko V", "Crni Cerak", "Dj Shone", "Mc Yankoo", "Klinac", "Seksi", "Kukus",
];

// ───── preuzimanje sa Deezera ─────

const cekaj = (ms) => new Promise((r) => setTimeout(r, ms));

/** Deezer dozvoljava 50 poziva u 5 sekundi; ide se sporije od toga i ponavlja se kad kaže „previše”. */
async function deezer(putanja) {
  for (let pokusaj = 1; pokusaj <= 6; pokusaj++) {
    await cekaj(130);
    try {
      const odgovor = await fetch(`https://api.deezer.com/${putanja}`);
      const json = await odgovor.json();
      if (json?.error?.code === 4) {
        await cekaj(2500 * pokusaj);
        continue;
      }
      if (json?.error) return { greska: json.error.message ?? String(json.error.code) };
      return json;
    } catch (e) {
      if (pokusaj === 6) return { greska: String(e) };
      await cekaj(1500 * pokusaj);
    }
  }
  return { greska: "previše poziva" };
}

const prosto = (s) =>
  s
    .toLowerCase()
    .replace(/đ/g, "dj")
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/[^a-z0-9]+/g, " ")
    .trim();

async function preuzmi() {
  const pesme = JSON.parse(readFileSync(join(KOREN, "data", "songs.json"), "utf8")).pesme;
  /** id izvođača → { ime sa Deezera, ime kako ga piše kviz (ako pesma ima jednog izvođača) } */
  const izvodjaci = new Map();
  const dnevnik = [];

  // 1) Izvođači pesama koje se puštaju: iz same pesme, pa nema zabune oko imenjaka.
  let n = 0;
  for (const p of pesme) {
    n++;
    if (n % 20 === 0) console.log(`pesme ${n}/${pesme.length}`);
    const t = await deezer(`track/${p.deezer_id}`);
    if (t.greska || !t.artist) {
      dnevnik.push(`pesma ${p.izvodjac} – ${p.naslov}: ${t.greska ?? "nema izvođača"}`);
      continue;
    }
    const svi = Array.isArray(t.contributors) && t.contributors.length ? t.contributors : [t.artist];
    for (const a of svi) {
      const z = izvodjaci.get(a.id) ?? { id: a.id, ime: a.name, uKvizu: true, prikaz: null };
      z.uKvizu = true;
      if (svi.length === 1) z.prikaz = p.izvodjac;
      izvodjaci.set(a.id, z);
    }
  }

  // 2) Dodatni izvođači: traži se po imenu i uzima samo onaj čije se ime poklapa (najviše pratilaca).
  const dodatni = [...new Set(DODATNI_IZVODJACI)];
  n = 0;
  for (const ime of dodatni) {
    n++;
    if (n % 20 === 0) console.log(`dodatni izvođači ${n}/${dodatni.length}`);
    const r = await deezer(`search/artist?q=${encodeURIComponent(ime)}&limit=10`);
    if (r.greska) {
      dnevnik.push(`izvođač ${ime}: ${r.greska}`);
      continue;
    }
    const isti = (r.data ?? []).filter((a) => prosto(a.name) === prosto(ime)).sort((x, y) => (y.nb_fan ?? 0) - (x.nb_fan ?? 0));
    if (!isti.length) {
      dnevnik.push(`izvođač ${ime}: nije nađen (prvi rezultat: ${r.data?.[0]?.name ?? "ništa"})`);
      continue;
    }
    const a = isti[0];
    if (!izvodjaci.has(a.id)) izvodjaci.set(a.id, { id: a.id, ime: a.name, uKvizu: false, prikaz: null, fanova: a.nb_fan ?? 0 });
  }

  // 3) Najslušanije pesme svakog izvođača.
  const izlaz = [];
  n = 0;
  for (const z of izvodjaci.values()) {
    n++;
    if (n % 20 === 0) console.log(`spiskovi pesama ${n}/${izvodjaci.size}`);
    const r = await deezer(`artist/${z.id}/top?limit=${TRAZI_PO_IZVODJACU}`);
    if (r.greska) {
      dnevnik.push(`spisak za ${z.ime}: ${r.greska}`);
      continue;
    }
    izlaz.push({
      ...z,
      pesme: (r.data ?? []).map((t) => ({
        naslov: t.title_short ?? t.title,
        pun: t.title,
        verzija: t.title_version ?? "",
        glavni: t.artist ? [t.artist.id, t.artist.name] : null,
        svi: (t.contributors ?? []).map((c) => [c.id, c.name]),
      })),
    });
  }

  mkdirSync(dirname(SIROVO), { recursive: true });
  writeFileSync(SIROVO, JSON.stringify({ preuzeto: new Date().toISOString().slice(0, 10), izvodjaci: izlaz, dnevnik }));
  console.log(`Gotovo: ${izlaz.length} izvođača, ${izlaz.reduce((s, z) => s + z.pesme.length, 0)} pesama. Napomena: ${dnevnik.length}.`);
}

const radnja = process.argv[2];
if (radnja === "preuzmi") await preuzmi();
else if (radnja === "napravi") await (await import("./katalog-napravi.mjs")).napravi({ KOREN, SIROVO, IZLAZ, NAJVISE_PO_IZVODJACU, DODATNI_IZVODJACI });
else console.log("Upotreba: node scripts/katalog-pesama.mjs preuzmi | napravi");
