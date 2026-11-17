/**
 * Botovi na dnevnoj rang listi: izmišljeni „kućni” igrači, jasno obeleženi kao botovi.
 * Ne postoje u bazi i ne ulaze u brojač „Danas je igralo N ljudi”. Imaju niske poene da ih pravi igrači lako preteknu.
 */

const OSNOVNA_IMENA = [
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


const PRVI = ["brzi", "ludi", "mali", "veliki", "tihi", "ljuti", "srecni", "pametni", "zeleni", "plavi", "crveni", "stari", "mladi", "hrabri", "lenji", "gladni", "snalazljivi", "veseli", "kul", "zlatni"];
const DRUGI = ["Mile", "Zoki", "Gile", "Paja", "Steva", "Joca", "Laza", "Bata", "Cane", "Dule", "Raka", "Sima", "Vuk", "Zeka", "Lisac", "Medo", "Soko", "Orao", "Mrgud", "Kum"];

/** 500 imena botova: 100 ručno izmišljenih i 400 složenih (npr. brzi_Mile7). Uvek istim redom. */
export const IMENA_BOTOVA: readonly string[] = (() => {
  const imena: string[] = [...OSNOVNA_IMENA];
  for (let i = 0; imena.length < 500; i++) {
    imena.push(`${PRVI[i % PRVI.length]}_${DRUGI[Math.floor(i / PRVI.length) % DRUGI.length]}${i >= PRVI.length * DRUGI.length ? i : ""}`);
  }
  return imena;
})();

export const BOT_POENI_OD = 50;
export const BOT_POENI_DO = 110;

export type Bot = { ime: string; poeni: number; vremeMs: number };

/** Mali stabilan heš (FNV-1a): isti bot istog dana uvek ima iste poene. */
function hes(tekst: string): number {
  let h = 0x811c9dc5;
  for (let i = 0; i < tekst.length; i++) {
    h ^= tekst.charCodeAt(i);
    h = Math.imul(h, 0x01000193);
  }
  return h >>> 0;
}

/** Svi botovi za jedan dan, od najviše poena naniže. */
export function botoviZaDan(datum: string): Bot[] {
  return IMENA_BOTOVA.map((ime) => {
    const h = hes(`${datum}|${ime}`);
    return {
      ime,
      poeni: BOT_POENI_OD + (h % (BOT_POENI_DO - BOT_POENI_OD + 1)),
      vremeMs: 120_000 + ((h >>> 8) % 150_000),
    };
  }).sort((a, b) => b.poeni - a.poeni || a.vremeMs - b.vremeMs);
}

/** Koliko botova je ispred igrača sa ovim brojem poena (kod istog broja poena pravi igrač ide ispred). */
export function botovaIspred(botovi: Bot[], poeni: number): number {
  return botovi.filter((b) => b.poeni > poeni).length;
}

export type RedSaBotom<T> = { bot: false; mesto: number; red: T } | { bot: true; mesto: number; red: Bot };

/**
 * Spaja prave igrače i botove u jednu listu sa mestima. `pravi` dolaze iz baze sa svojim mestom među ljudima.
 * Vraća prvih `najvise` mesta, plus „moj” red ako je ispod toga.
 */
export function listaSaBotovima<T extends { mesto: number; poeni: number; ja: boolean }>(
  pravi: T[],
  botovi: Bot[],
  najvise: number,
): { vrh: RedSaBotom<T>[]; ja: RedSaBotom<T> | null } {
  const ljudi = pravi.map((red) => ({ bot: false as const, mesto: red.mesto + botovaIspred(botovi, red.poeni), red }));
  // botovi su već poređani (poeni, pa brže vreme), pa je redni broj bota broj botova ispred njega
  const masine: RedSaBotom<T>[] = botovi.map((red, i) => ({
    bot: true,
    mesto: 1 + i + pravi.filter((p) => p.poeni >= red.poeni).length,
    red,
  }));
  const sve: RedSaBotom<T>[] = [...ljudi, ...masine].sort((a, b) => a.mesto - b.mesto || Number(a.bot) - Number(b.bot));
  const vrh = sve.filter((r) => r.mesto <= najvise).slice(0, najvise + 10);
  const moj = ljudi.find((r) => r.red.ja) ?? null;
  return { vrh, ja: moj && !vrh.includes(moj) ? moj : null };
}
