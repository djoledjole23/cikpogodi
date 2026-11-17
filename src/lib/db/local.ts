import { existsSync, readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { ucitajProizvode } from "@/lib/content/products";
import { seedSql } from "@/lib/content/seed";
import { ucitajFilmove } from "@/lib/content/films";
import { ucitajJokere } from "@/lib/content/joker";
import { postojeceSlikeJokera, postojeciKadrovi, sopstveneSlike } from "@/lib/content/slike";
import { ucitajPesme } from "@/lib/content/songs";
import { ucitajTrendove } from "@/lib/content/trends";
import { beogradskiDatum } from "@/lib/time";
import { omotajPglite, SUPABASE_ZAMENA } from "./pglite";
import type { Db } from "./types";

/**
 * Lokalna baza za razvoj: Postgres u memoriji sa pravom migracijom i seed-om od danas.
 * Briše se kad se server ugasi. Nalozi ovde ne postoje (to je Supabase Auth), pa se igra kao gost.
 */
export async function napraviLokalnuBazu(): Promise<Db> {
  const { PGlite } = await import("@electric-sql/pglite");
  const pg = new PGlite();
  await pg.exec(SUPABASE_ZAMENA);

  const dir = join(process.cwd(), "supabase", "migrations");
  for (const fajl of readdirSync(dir).filter((f) => f.endsWith(".sql")).sort()) {
    await pg.exec(readFileSync(join(dir, fajl), "utf8"));
  }

  // Isti fajlovi koji idu u pravu bazu (supabase/seed/*.sql): ono što se testira ovde je baš ono što igrači dobijaju.
  const seedDir = join(process.cwd(), "supabase", "seed");
  const seedFajlovi = existsSync(seedDir) ? readdirSync(seedDir).filter((f) => f.endsWith(".sql")).sort() : [];
  for (const fajl of seedFajlovi) await pg.exec(readFileSync(join(seedDir, fajl), "utf8"));

  const danas = beogradskiDatum();
  const imaDanas = (await pg.query<{ ima: boolean }>(`select exists (select 1 from public.daily_quiz where quiz_date = $1::date) as ima`, [danas])).rows[0]?.ima;
  if (imaDanas) {
    if (process.env.CP_PROBNA_LISTA === "1") await probnaLista(pg, danas);
    console.log(`[lokalna baza] spremna: pitanja iz ${seedFajlovi.join(", ")} (ista kao u pravoj bazi)`);
    return omotajPglite(pg);
  }

  // Za današnji dan nema gotovog seed fajla: pitanja se prave iz data/ na licu mesta (samo za probu).
  const podaci = (ime: string) => JSON.parse(readFileSync(join(process.cwd(), "data", ime), "utf8"));
  const proizvodi = ucitajProizvode(podaci("products.json"), sopstveneSlike());
  const trendovi = ucitajTrendove(podaci("trends.json"));
  const { pesme } = ucitajPesme(podaci("songs.json"));
  const { filmovi } = ucitajFilmove(podaci("films.json"), postojeciKadrovi());
  const jokeri = ucitajJokere(podaci("joker.json"), postojeceSlikeJokera()).pitanja;
  await pg.exec(
    seedSql({
      proizvodi: proizvodi.proizvodi,
      datumCenovnika: proizvodi.datumCenovnika,
      pesme,
      filmovi,
      jokeri,
      trendovi,
      pocetak: danas,
      dana: 14,
    }),
  );

  console.log(
    `[lokalna baza] spremna (bez seed fajla za danas, pitanja napravljena iz data/): ${proizvodi.proizvodi.length} artikala, ${pesme.length} pesama, ${filmovi.length} kadrova, ${jokeri.length} Joker pitanja, ${trendovi.pojmovi.length} pojmova za guglanje, kviz za 14 dana od ${danas}`,
  );
  return omotajPglite(pg);
}

/**
 * Samo za pregled izgleda rang liste na svom računaru (CP_PROBNA_LISTA=1): 100 izmišljenih naloga
 * sa niskim današnjim rezultatima, da se vidi kako lista i brojač izgledaju kad igra mnogo ljudi.
 * Nikad se ne pali na pravom sajtu: prava baza ne prolazi kroz ovaj fajl.
 */
export const PROBNA_IMENA = [
  "partizanšampion", "tastaturaratnik", "Mile_iz_trafike", "komsinica_Rada", "DzoniBravo", "baba_Zorka", "Lepi_Cane", "SlagalicaKing",
  "tetka_iz_Nisa", "Burek_sa_sirom", "ZvezdaSever", "Grobar1945", "mali_Perica", "Sojka", "kum_Laza", "Teta_Vida",
  "cevapdzija", "rakijaMajstor", "kafana_Boem", "sarmaLover", "ajvarKralj", "pljeskavica99", "gibanicaFan", "kajmakZaDvoje",
  "NikolaTesla2", "PupinFan", "zajecarac", "timocki_vuk", "nisvilJazz", "beogradskiFrajer", "novosadjanin", "kragujevcanin",
  "subotica_Mica", "cacak_Zoki", "uzicki_Mrgud", "valjevac_Pera", "Smederevac", "leskovacki_rostilj", "vranje_Kole", "pirotski_cilim",
  "Daca_DJ", "Ceca_fan", "TurboFolkKralj", "rokenrolBata", "Ekv_Fan", "Riblja_Corba", "Bajaga_i_ja", "Bregovicev",
  "kvizomanija", "pametnica_Ana", "znalac123", "PogadjacPro", "SveZnam", "mozakNaDugme", "bistriPetar", "lisica_Lela",
  "Sale_Mutavi", "Gile_Brzi", "Joca_Kec", "Bole_Lajavi", "Mika_Alas", "Laza_K", "Steva_Sef", "Zika_Spica",
  "MileKitic_fan", "pevacica_Sneza", "harmonikasJova", "trubacGuca", "kolo_Igrac", "frulica", "tamburasBane", "violinaVeca",
  "fudbalerMarko", "kosarkasIvan", "vaterpoloVuk", "tenisNovak", "odbojkasica", "rukometasDule", "golmanZeka", "sudijaPera",
  "baba_Smilja", "deda_Rade", "ujak_Miki", "strina_Goca", "brat_od_strica", "svekrva_Dara", "zet_Bane", "snaha_Jeca",
  "nocnaPtica", "jutarnjaKafa", "ponedeljakMrzim", "petakVece", "vikendica", "letovanjeGrcka", "zimaKopaonik", "proleceBrzo",
  "pekar_Sima", "mesar_Djura", "frizerka_Bilja", "taksista_Coka",
] as const;

async function probnaLista(pg: { exec(sql: string): Promise<unknown> }, danas: string) {
  const redovi = PROBNA_IMENA.map((ime, i) => {
    const id = `aaaaaaaa-0000-4000-8000-${String(i + 1).padStart(12, "0")}`;
    // Svi blizu dna: 30–64 poena, svaki dan isto, da ih pravi igrači lako preteknu.
    const poeni = 30 + ((i * 37) % 35);
    return `
      insert into auth.users (id, email, email_confirmed_at) values ('${id}', 'proba${i}@example.com', now());
      update public.profiles set username = '${ime}' where id = '${id}';
      insert into public.plays (quiz_date, user_id, device_id, status, score, total_answer_ms, leaderboard_status, finished_at)
        values ('${danas}', '${id}', '${id}', 'finished', ${poeni}, ${90000 + i * 1300}, 'counted', now());`;
  });
  await pg.exec(redovi.join("\n"));
}
