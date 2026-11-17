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


/** Mali deterministički generator slučajnih brojeva (mulberry32): imena su ista pri svakom pokretanju. */
function prng(seme: number): () => number {
  let a = seme >>> 0;
  return () => {
    a = (a + 0x6d2b79f5) >>> 0;
    let t = a;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

const IMENA = ["marko", "nikola", "stefan", "luka", "milos", "nemanja", "aleksa", "uros", "filip", "vuk", "djordje", "petar", "lazar", "ognjen", "dusan", "jovan", "bogdan", "andrija", "mihajlo", "strahinja", "dragan", "zoran", "goran", "branko", "milan", "sasa", "dejan", "ivan", "ana", "jelena", "milica", "jovana", "teodora", "sara", "marija", "katarina", "ivana", "tamara", "nina", "kristina", "dragana", "snezana", "vesna", "maja", "tijana", "andjela", "sofija", "nevena", "ljilja", "gordana", "bojana", "sanja", "danica", "mina", "iva", "lena", "zoki", "gile", "cone", "bane", "boki", "peca", "sone", "mile", "raka", "dule", "joca", "zare", "kole", "mica", "beba", "seka", "goca", "ceca", "jeca", "buba", "caca", "lela"];
const PREZIMENA = ["petrovic", "jovanovic", "nikolic", "markovic", "djordjevic", "stojanovic", "ilic", "pavlovic", "milosevic", "stankovic", "todorovic", "kostic", "popovic", "zivkovic", "mitic", "ristic", "savic", "lazic", "simic", "jankovic"];
const RECI = ["burek", "kafa", "rakija", "sarma", "ajvar", "kajmak", "gibanica", "cevap", "pljeska", "mekika", "krofna", "kifla", "pekmez", "paprika", "sljiva", "dunja", "jabuka", "lubenica", "trotinet", "fica", "yugo", "zastava", "kombi", "traktor", "bicikla", "gitara", "harmonika", "truba", "frula", "lopta", "kocka", "sah", "remi", "tabla", "kviz", "slagalica", "mozak", "znalac", "pogadjac", "lisica", "vuk", "medved", "soko", "orao", "maca", "kuca", "jez", "zeka", "kornjaca", "puz", "pile", "patak", "gusan", "magarac", "konj", "sova", "svraka", "vrabac"];
const PRIDEVI = ["ludi", "brzi", "mali", "veliki", "tihi", "ljuti", "srecni", "pametni", "stari", "mladi", "hrabri", "lenji", "gladni", "veseli", "zlatni", "crni", "beli", "divlji", "pospani", "nervozni", "ponosni", "tajni", "slatki", "zli", "dobri"];
const GRADOVI = ["bg", "ns", "nis", "kg", "zajecar", "cacak", "uzice", "valjevo", "pirot", "vranje", "sabac", "smederevo", "kraljevo", "krusevac", "subotica", "zrenjanin", "pancevo", "leskovac", "bor", "negotin", "sombor", "loznica", "jagodina", "paracin", "novipazar", "prokuplje", "pozarevac", "kikinda", "vrsac", "obrenovac"];

const velikoPrvo = (x: string) => x.charAt(0).toUpperCase() + x.slice(1);

/** 400 imena u raznim stilovima, kao što ih ljudi stvarno smišljaju. */
function slozenaImena(koliko: number, zauzeto: Set<string>): string[] {
  const r = prng(20261117);
  const iz = <T,>(niz: readonly T[]) => niz[Math.floor(r() * niz.length)];
  const broj = () => {
    const v = r();
    if (v < 0.35) return String(1960 + Math.floor(r() * 50));
    if (v < 0.6) return String(Math.floor(r() * 100)).padStart(2, "0");
    if (v < 0.75) return String(Math.floor(r() * 1000));
    return String(1 + Math.floor(r() * 9));
  };
  const obrasci: Array<() => string> = [
    () => iz(IMENA) + broj(),
    () => `${iz(IMENA)}_${broj()}`,
    () => velikoPrvo(iz(IMENA)) + velikoPrvo(iz(PREZIMENA)).slice(0, 1 + Math.floor(r() * 5)),
    () => `${iz(IMENA)}_${iz(PREZIMENA)}`,
    () => `${iz(IMENA)}_${iz(GRADOVI)}`,
    () => iz(IMENA) + iz(GRADOVI),
    () => velikoPrvo(iz(PRIDEVI)) + velikoPrvo(iz(RECI)),
    () => `${iz(PRIDEVI)}_${iz(RECI)}`,
    () => iz(RECI) + broj(),
    () => `${iz(RECI)}_${iz(GRADOVI)}`,
    () => iz(RECI) + velikoPrvo(iz(RECI)),
    () => `${iz(IMENA)}${iz(IMENA).slice(-1).repeat(2 + Math.floor(r() * 3))}`,
    () => `${iz(["the", "mr", "gospodin", "kralj", "car", "sef", "doktor", "majstor", "baja"])}_${iz(IMENA)}`,
    () => `${iz(IMENA)}${iz(["xd", "lol", "kg", "pro", "car", "brt", "bg", "fan", "jr"])}`,
    () => iz(PREZIMENA) + broj(),
    () => velikoPrvo(iz(IMENA)) + broj(),
    () => `${iz(RECI)}${iz(["majstor", "lover", "king", "fan", "dzija", "car", "boss"])}`,
  ];
  const izlaz: string[] = [];
  while (izlaz.length < koliko) {
    const ime = iz(obrasci)().slice(0, 20);
    const kljuc = ime.toLowerCase();
    if (ime.length < 3 || zauzeto.has(kljuc)) continue;
    zauzeto.add(kljuc);
    izlaz.push(ime);
  }
  return izlaz;
}

/** 500 imena botova: 100 ručno izmišljenih i 400 složenih u raznim stilovima. Uvek ista. */
export const IMENA_BOTOVA: readonly string[] = (() => {
  const zauzeto = new Set(OSNOVNA_IMENA.map((x) => x.toLowerCase()));
  return [...OSNOVNA_IMENA, ...slozenaImena(500 - OSNOVNA_IMENA.length, zauzeto)];
})();

export const BOT_POENI_OD = 20;
export const BOT_POENI_DO = 220;

export type Bot = { ime: string; poeni: number; vremeMs: number };

/** Mali stabilan heš (FNV-1a): isti dan uvek daje isti raspored. */
function hes(tekst: string): number {
  let h = 0x811c9dc5;
  for (let i = 0; i < tekst.length; i++) {
    h ^= tekst.charCodeAt(i);
    h = Math.imul(h, 0x01000193);
  }
  return h >>> 0;
}

/**
 * Svi botovi za jedan dan, od najviše poena naniže. Poeni su ravnomerno raspoređeni od 220 do 20
 * (svaki broj poena ima najviše dva-tri bota), a ko dobija koje mesto menja se svaki dan.
 */
export function botoviZaDan(datum: string): Bot[] {
  const r = prng(hes(datum));
  const izmesano = IMENA_BOTOVA.map((ime) => ({ ime, k: r() })).sort((a, b) => a.k - b.k);
  const n = izmesano.length;
  return izmesano
    .map(({ ime }, i) => ({
      ime,
      poeni: Math.round(BOT_POENI_DO - (i * (BOT_POENI_DO - BOT_POENI_OD)) / (n - 1)),
      vremeMs: 70_000 + Math.floor(r() * 200_000),
    }))
    .sort((a, b) => b.poeni - a.poeni || a.vremeMs - b.vremeMs);
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
  const vrh = sve.filter((r) => r.mesto <= najvise).slice(0, najvise);
  const moj = ljudi.find((r) => r.red.ja) ?? null;
  return { vrh, ja: moj && !vrh.includes(moj) ? moj : null };
}
