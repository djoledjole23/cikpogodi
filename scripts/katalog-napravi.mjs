// Drugi korak za scripts/katalog-pesama.mjs: od sirovog spiska sa Deezera pravi data/katalog.json.
// Čisti naslove (verzije, duple, spletove), ujednačava pisanje i izbacuje sve što bi se sudarilo
// sa pesmom koja se pušta u kvizu (isti izvođač + isti ili skoro isti naslov), da tačan odgovor bude samo jedan.

import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

/** Spiskovi koji nisu izvođači nego izdavači ili prateći sastavi, i imenjaci koji nisu ti izvođači. */
const NISU_IZVODJACI = new Set(["futa band", "grand production", "juzni vetar", "rani mraz", "azra", "kukus", "princ od vranje", "zli toni"]);

/** Reči koje Deezer često piše bez kvačica. Samo one koje nemaju drugo značenje (ni na engleskom). */
const KVACICE = Object.fromEntries(
  `zena:žena zene:žene zenu:ženu zeno:ženo zivot:život zivota:života zivote:živote zivim:živim zivi:živi zivela:živela ziveo:živeo
  sreca:sreća srece:sreće srecu:sreću srecan:srećan srecna:srećna nesreca:nesreća nesreco:nesrećo noc:noć noci:noći nocas:noćas
  jos:još sta:šta zasto:zašto nista:ništa nesto:nešto svasta:svašta posto:pošto uopste:uopšte necu:neću neces:nećeš nece:neće hocu:hoću hoces:hoćeš
  mozes:možeš moze:može mozda:možda vec:već dusa:duša duso:dušo dusu:dušu duse:duše dusi:duši zelja:želja zelje:želje zelju:želju zelim:želim
  zelis:želiš zeli:želi zelela:želela zeleo:želeo tuzna:tužna tuzan:tužan tuzno:tužno oci:oči ociju:očiju ocima:očima covek:čovek coveka:čoveka
  covece:čoveče ljubis:ljubiš ides:ideš znas:znaš imas:imaš volis:voliš nemas:nemaš kazi:kaži kazes:kažeš kazu:kažu bices:bićeš bice:biće
  kisa:kiša kise:kiše kisu:kišu pricaj:pričaj prica:priča pricu:priču cekam:čekam cekaj:čekaj cekas:čekaš placi:plači placem:plačem
  placu:plaču placite:plačite places:plačeš lazi:laži lazes:lažeš lazu:lažu lazov:lažov laz:laž lazem:lažem medju:među izmedju:između
  dodji:dođi nadji:nađi djavo:đavo djavole:đavole andjeo:anđeo andjele:anđele andjeli:anđeli rodjen:rođen rodjena:rođena rodjendan:rođendan
  tudja:tuđa tudje:tuđe tudji:tuđi tudjina:tuđina mladja:mlađa sladja:slađa cutim:ćutim veceras:večeras vece:veče zao:žao zalim:žalim
  prosao:prošao prosla:prošla proslo:prošlo dosao:došao dosla:došla otisao:otišao otisla:otišla nasao:našao nasla:našla losa:loša   najlepsa:najlepša lepsa:lepša pijes:piješ pises:pišeš pisi:piši pisem:pišem dises:dišeš disem:dišem trazim:tražim
  trazi:traži trazis:tražiš drzi:drži drzim:držim bezi:beži bezim:bežim vazi:važi tisina:tišina secanje:sećanje secanja:sećanja secas:sećaš
  secam:sećam obecanje:obećanje obecao:obećao obecala:obećala cujes:čuješ cujem:čujem cuvam:čuvam cuvaj:čuvaj ceznja:čežnja cudo:čudo
  cuda:čuda cudna:čudna cudno:čudno zuta:žuta ruza:ruža ruze:ruže ruzu:ružu mesecina:mesečina tacno:tačno tacka:tačka macka:mačka
  decko:dečko devojcica:devojčica decak:dečak gresnica:grešnica gresna:grešna gresim:grešim greska:greška sampanjac:šampanjac sesir:šešir
  skola:škola cao:ćao cale:ćale cerka:ćerka majcina:majčina kuci:kući zurka:žurka zurke:žurke veciti:večiti vecno:večno
  vecna:večna vecnost:večnost proslost:prošlost buducnost:budućnost zalost:žalost zedna:žedna zedan:žedan kosulja:košulja flasa:flaša
  flasu:flašu pustam:puštam sanjas:sanjaš spavas:spavaš dusmani:dušmani dusman:dušman braco:braćo braca:braća sljiva:šljiva visnja:višnja
  masina:mašina srpkinja:Srpkinja sumadija:Šumadija sumadijo:Šumadijo cacak:Čačak uzice:Užice nis:Niš sabac:Šabac milos:Miloš dusan:Dušan
  nocu:noću cesto:često cija:čija ciji:čiji cije:čije hocemo:hoćemo necemo:nećemo mozemo:možemo zivimo:živimo zurim:žurim   ljubicica:ljubičica nedostajes:nedostaješ ostavljas:ostavljaš varas:varaš gledas:gledaš cutis:ćutiš
  smejes:smeješ mislis:misliš dolazis:dolaziš odlazis:odlaziš pitas:pitaš dajes:daješ uzimas:uzimaš radis:radiš zoves:zoveš`
    .split(/\s+/)
    .filter(Boolean)
    .map((par) => par.split(":")),
);

const VLASTITA = /^(vojvodin|sombor|petrovaradin|bačk|banat|srem|zlatibor|kopaonik|kragujev|čačk|užic|valjev|subotic|podgoric|budv|kotor|split|dubrovnik|rijek|zadr|osijek|tuzl|zenic|skopj|ohrid|ljubljan|hercegovin|crnogor|srbin|srpkinj|bosan|hrvat|slovenij|japan|meksik|brazil|argentin|afrik|njujork|vegas|holivud|madrid|barcelon|milano|venecij|monak|monte$|karlo$|kingston|toronto|trinidad|tobago|kapone|marij|milen|jovan|nataš|tanj|vesn|zoric|dragan|goran|zoran|marko$|nikol|stefan|lazar|miloš|dušan|petar|pavle|đorđe|aleksand|katarin|teodor|suzan|jasmin|snežan|svetlan|mirjan|gordan|biljan|emin[aeou]$|lejl|selm|esm[aeou]$|ines|bovi$|dejvid|srbij|srpsk|bosn|sarajev|zagreb|balkan|jugoslav|pariz|amerik|evrop|dunav|drin|morav|kosov|makedon|hrvatsk|dalmacij|mostar|vranj|šumadij|sumadij|bog$|boga$|bože$|boze$|novi$|sad$|niš|crn[ae]$|gor[aeiou]$|rusij|moskv|london|berlin|beč|italij|grčk|španij|kub|havan|ibic|ibiz|dubai|miami|tokio|rim$|rima$|bulevar)/;

const prosto = (s) =>
  s
    .toLowerCase()
    .replace(/đ/g, "dj")
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/['’`´]/g, "")
    .replace(/[^a-z0-9]+/g, " ")
    .trim();

function razdaljina(a, b) {
  const m = a.length;
  const n = b.length;
  if (!m) return n;
  if (!n) return m;
  let pretprosli = [];
  let prosli = Array.from({ length: n + 1 }, (_, j) => j);
  for (let i = 1; i <= m; i++) {
    const red = [i];
    for (let j = 1; j <= n; j++) {
      const cena = a[i - 1] === b[j - 1] ? 0 : 1;
      let v = Math.min(prosli[j] + 1, red[j - 1] + 1, prosli[j - 1] + cena);
      if (i > 1 && j > 1 && a[i - 1] === b[j - 2] && a[i - 2] === b[j - 1]) v = Math.min(v, pretprosli[j - 2] + 1);
      red.push(v);
    }
    pretprosli = prosli;
    prosli = red;
  }
  return prosli[n];
}

/** Isto što i `slicno` u src/lib/match.ts: toliko slični da bi ukucan jedan prošao kao drugi. */
function skoroIsto(a, b) {
  const x = prosto(a).replace(/ /g, "");
  const y = prosto(b).replace(/ /g, "");
  if (!x || !y) return false;
  if (Math.abs(x.length - y.length) > 2) return false;
  return razdaljina(x, y) <= (y.length < 5 ? 0 : y.length < 10 ? 1 : 2);
}

const jeSlovo = (z) => z.toLowerCase() !== z.toUpperCase();
const pocinjeVelikim = (r) => jeSlovo(r[0]) && r[0] === r[0].toUpperCase();

/** Naslov bez verzija i gostiju; null ako to nije pesma za spisak (splet, matrica, uvod...). */
function ocistiNaslov(t) {
  const sve = `${t.pun ?? ""} ${t.verzija ?? ""}`;
  if (/instrumental|karaoke|matrica|medley|splet|potpuri|\bintro\b|\boutro\b|\bskit\b|megamix|mashup/i.test(sve)) return null;
  let n = String(t.naslov ?? "");
  n = n.replace(/\s*[([][^)\]]*[)\]]/g, " ");
  n = n.replace(/\s+(feat\.?|ft\.?|featuring)\s.*$/i, "");
  n = n.replace(/\s+(unplugged|live|uživo|uzivo|remaster(ed)?|remix)\b.*$/i, "");
  n = n.replace(/\s+-\s+(live|uživo|uzivo|remix|remaster(ed)?|radio edit|single|version|verzija|akusti[čc]n[ao]|acoustic|bonus).*$/i, "");
  n = n.replace(/\s+/g, " ").replace(/^[\s\-–.,]+|[\s\-–,]+$/g, "");
  if (n.length < 2 || n.length > 42) return null;
  if (/ \/ |\\/.test(n)) return null;
  if (!/[a-zA-Zčćšžđ]/i.test(n)) return null;
  return n;
}

const ENGLESKI = /\b(the|you|love|of|and|my|is|your|for|with|it|we|be|this|that|all|are|was|what|when|from|one|night|girl|boy|baby|world|time|life|heart|like|don't|out|off|feat)\b/i;
/** Reči koje bez kvačica znače nešto drugo, pa se ne diraju. */
const NE_DIRAJ = new Set(["kuca", "sto", "nas", "vas", "reci", "sala", "suma", "pusta", "luka", "duga", "kosa", "lose", "case", "price", "pile", "sisa", "masa", "basta", "pas", "zar", "sam", "sad", "cari", "zito", "bas", "cas", "muz", "ruza", "kasa", "pisi", "seta"]);

/** „Crno Na Belo” i „STA TI JE U VODI” → „Crno na belo”, „Šta ti je u vodi”. Naslov koji je već pisan kao rečenica ostaje. */
function ujednaci(naslov, vlastite, izKorpusa) {
  const reci = naslov.split(" ");
  const slovne = reci.filter((r) => r.length > 1 && jeSlovo(r[0]));
  const sveVeliko = naslov === naslov.toUpperCase() && naslov !== naslov.toLowerCase();
  const duze = reci.slice(1).filter((r) => r.length > 3 && jeSlovo(r[0]));
  const velikih = duze.filter(pocinjeVelikim).length;
  // Sve reči velikim slovom, ili bar dve duže reči (i više od pola njih): naslov je pisan „Kao Engleski Naslov”.
  const svakaVelikim = (slovne.length >= 2 && slovne.every(pocinjeVelikim)) || (velikih >= 2 && velikih * 2 > duze.length);
  const engleski = ENGLESKI.test(naslov);
  let izlaz = reci;
  if ((sveVeliko || svakaVelikim) && !engleski) {
    izlaz = reci.map((r, i) => {
      const mala = r.toLowerCase();
      if (i === 0) return mala;
      const gola = mala.replace(/[^a-zčćšžđ]/g, "");
      if (vlastite.has(gola) || VLASTITA.test(gola)) return mala[0].toUpperCase() + mala.slice(1);
      return mala;
    });
  }
  if (!engleski) {
    const bezKvacica = !/[čćšžđ]/i.test(naslov);
    izlaz = izlaz.map((r) => {
      const m = r.match(/^([^a-zA-ZčćšžđČĆŠŽĐ]*)([a-zA-ZčćšžđČĆŠŽĐ]+)(.*)$/);
      if (!m) return r;
      let rec = m[2];
      // „AKo” → „Ako”
      if (rec.length > 2 && rec !== rec.toUpperCase() && rec[1] !== rec[1].toLowerCase()) rec = rec[0] + rec.slice(1).toLowerCase();
      const mala = rec.toLowerCase();
      let zamena = KVACICE[mala] ?? (bezKvacica ? izKorpusa.get(mala) : undefined);
      if (!zamena && !/[čćšžđ]/.test(mala) && !NE_DIRAJ.has(mala)) {
        let z = mala;
        // „ponudjen” → „ponuđen” (ali ne „odjednom”, „podjednako”, „dj”)
        if (z.length > 3 && !/^(od|nad|pod|pred|iz|raz|ob)j/.test(z.replace("dj", "j"))) z = z.replace(/dj/g, "đ");
        // „ostacu”, „plakacu” → „ostaću”, „plakaću”
        if (z.length > 4 && /acu$/.test(z)) z = z.replace(/acu$/, "aću");
        if (z !== mala) zamena = z;
      }
      if (!zamena) return m[1] + rec + m[3];
      const velika = rec[0] !== rec[0].toLowerCase();
      return m[1] + (velika ? zamena[0].toUpperCase() + zamena.slice(1) : zamena) + m[3];
    });
  }
  const s = izlaz.join(" ");
  return s[0].toUpperCase() + s.slice(1);
}

const lepoIme = (ime) => {
  const s = ime.trim().replace(/\s+/g, " ");
  if (s.length > 3 && s === s.toUpperCase()) return s.toLowerCase().replace(/(^|[\s.\-])([a-zčćšžđ])/g, (_, a, b) => a + b.toUpperCase());
  return s;
};

export async function napravi({ KOREN, SIROVO, IZLAZ, NAJVISE_PO_IZVODJACU, DODATNI_IZVODJACI = [] }) {
  const sirovo = JSON.parse(readFileSync(SIROVO, "utf8"));
  const pesme = JSON.parse(readFileSync(join(KOREN, "data", "songs.json"), "utf8")).pesme;

  // Kako se koji izvođač piše: prvo kako ga piše kviz, pa kako je napisan u spisku dodatnih, pa Deezer.
  const pisanje = new Map();
  for (const z of sirovo.izvodjaci) if (z.prikaz) pisanje.set(z.id, z.prikaz);
  const poImenu = new Map(DODATNI_IZVODJACI.map((ime) => [prosto(ime), ime]));
  for (const p of pesme) for (const ime of p.izvodjaci ?? [p.izvodjac]) poImenu.set(prosto(ime), ime);
  const imeIzvodjaca = ([id, ime]) => pisanje.get(id) ?? poImenu.get(prosto(ime)) ?? lepoIme(ime);

  // Šta se može naučiti iz samih naslova (preko 13.000 komada):
  //  - koje se reči i usred naslova pišu velikim slovom (imena, gradovi);
  //  - kako se reč piše sa kvačicama, za naslove koje je neko ukucao bez njih.
  const sviNaslovi = [...pesme.map((p) => p.naslov), ...sirovo.izvodjaci.flatMap((z) => z.pesme.map((t) => t.naslov ?? ""))];
  const velikim = new Map();
  const malim = new Map();
  const saKvacicom = new Map();
  const golaURednom = new Map();
  for (const n of sviNaslovi) {
    const reci = n.replace(/\s*[([][^)\]]*[)\]]/g, " ").split(/\s+/).filter(Boolean);
    const imaKvacicu = /[čćšžđ]/i.test(n);
    for (const r of reci) {
      const mala = r.toLowerCase().replace(/[^a-zčćšžđ]/g, "");
      if (mala.length < 3) continue;
      if (/[čćšžđ]/.test(mala)) {
        const oblici = saKvacicom.get(prosto(mala)) ?? new Map();
        oblici.set(mala, (oblici.get(mala) ?? 0) + 1);
        saKvacicom.set(prosto(mala), oblici);
      } else if (imaKvacicu) golaURednom.set(mala, (golaURednom.get(mala) ?? 0) + 1);
    }
    const ostale = reci.slice(1).filter((r) => r.length > 3 && jeSlovo(r[0]));
    if (ostale.length < 2 || !ostale.some((r) => !pocinjeVelikim(r))) continue;
    for (const r of ostale) {
      if (r === r.toUpperCase()) continue;
      const gola = r.toLowerCase().replace(/[^a-zčćšžđ]/g, "");
      const gde = pocinjeVelikim(r) ? velikim : malim;
      gde.set(gola, (gde.get(gola) ?? 0) + 1);
    }
  }
  const vlastite = new Set([...velikim].filter(([r, n]) => n >= 2 && !malim.has(r)).map(([r]) => r));
  /** Reč bez kvačica → jedini oblik sa kvačicama koji se sreće (i to bar dvaput, a gola reč skoro nikad u urednim naslovima). */
  const izKorpusa = new Map();
  for (const [gola, oblici] of saKvacicom) {
    if (oblici.size !== 1) continue;
    const [[oblik, broj]] = [...oblici];
    const uRednom = golaURednom.get(gola) ?? 0;
    const dovoljno = broj >= 2 ? uRednom * 4 < broj : gola.length >= 5 && uRednom === 0;
    if (dovoljno && !NE_DIRAJ.has(gola)) izKorpusa.set(gola, oblik);
  }

  /** „izvođač|naslov” koji je već zauzet (za svakog izvođača pesme posebno). */
  const zauzeto = new Set();
  /** Naslovi pesama iz kviza po izvođaču, za proveru „skoro isto”. */
  const uKvizu = new Map();
  for (const p of pesme) {
    for (const ime of p.izvodjaci ?? [p.izvodjac]) {
      const k = prosto(ime);
      for (const n of [p.naslov, ...(p.alias ?? [])]) {
        zauzeto.add(`${k}|${prosto(n)}`);
        uKvizu.set(k, [...(uKvizu.get(k) ?? []), n]);
      }
    }
  }

  const vecUzeto = new Map();
  const grupe = new Map();
  const dodaj = (izvodjac, naslov) => {
    const k = prosto(izvodjac);
    const g = grupe.get(k) ?? { izvodjac, naslovi: [] };
    g.naslovi.push(naslov);
    grupe.set(k, g);
  };

  let ukupno = 0;
  const preskoceniSpiskovi = [];
  for (const z of sirovo.izvodjaci) {
    if (NISU_IZVODJACI.has(prosto(z.ime))) {
      preskoceniSpiskovi.push(z.ime);
      continue;
    }
    let uzeto = 0;
    for (const t of z.pesme) {
      if (uzeto >= (z.uKvizu ? NAJVISE_PO_IZVODJACU.uKvizu : NAJVISE_PO_IZVODJACU.ostali)) break;
      const cist = ocistiNaslov(t);
      if (!cist) continue;
      let ljudi = (t.svi?.length ? t.svi : t.glavni ? [t.glavni] : [[z.id, z.ime]]).filter(([, ime]) => !NISU_IZVODJACI.has(prosto(ime)));
      if (!ljudi.length || ljudi.length > 3) ljudi = t.glavni && !NISU_IZVODJACI.has(prosto(t.glavni[1])) ? [t.glavni] : [[z.id, z.ime]];
      const imena = [...new Set(ljudi.map(imeIzvodjaca))];
      const naslov = ujednaci(cist, vlastite, izKorpusa);
      const kljucNaslova = prosto(naslov);
      if (!kljucNaslova) continue;

      const kljucevi = imena.map((ime) => `${prosto(ime)}|${kljucNaslova}`);
      if (kljucevi.some((k) => zauzeto.has(k))) continue;
      if (imena.some((ime) => (uKvizu.get(prosto(ime)) ?? []).some((n) => skoroIsto(naslov, n) || skoroIsto(n, naslov)))) continue;
      // Dva zapisa iste pesme kod istog izvođača („Dodi da ostarimo” i „Dođi da ostarimo”) ostaju kao jedan.
      if (imena.some((ime) => (vecUzeto.get(prosto(ime)) ?? []).some((n) => skoroIsto(naslov, n)))) continue;
      for (const ime of imena) vecUzeto.set(prosto(ime), [...(vecUzeto.get(prosto(ime)) ?? []), naslov]);
      for (const k of kljucevi) zauzeto.add(k);

      const prikaz = imena.length === 1 ? imena[0] : `${imena.slice(0, -1).join(", ")} & ${imena[imena.length - 1]}`;
      dodaj(prikaz, naslov);
      uzeto++;
      ukupno++;
    }
  }

  const izvodjaci = [...grupe.values()]
    .map((g) => [g.izvodjac, g.naslovi.sort((a, b) => a.localeCompare(b, "sr"))])
    .sort((a, b) => a[0].localeCompare(b[0], "sr"));

  writeFileSync(
    IZLAZ,
    JSON.stringify(
      {
        izvor: "Deezer (najslušanije pesme izvođača)",
        preuzeto: sirovo.preuzeto,
        napomena: "Samo za biranje odgovora u „Pogodi pesmu”. Ove pesme se ne puštaju; puštaju se one iz songs.json.",
        broj_pesama: ukupno,
        izvodjaci,
      },
      null,
      0,
    ).replace(/\],\[/g, "],\n["),
  );
  console.log(`data/katalog.json: ${ukupno} pesama, ${izvodjaci.length} izvođača ili sastava. Preskočeni spiskovi: ${preskoceniSpiskovi.join(", ")}`);
}
