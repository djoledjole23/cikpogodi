import type { Db } from "@/lib/db/types";
import type { Identitet, NizDana } from "./types";

/**
 * Niz dana: koliko je dana zaredom igrač odigrao kviz do kraja, zaključno sa današnjim.
 * Prijavljen igrač: igre njegovog naloga + gostujuće igre sa ovog uređaja (pre registracije).
 * Gost: gostujuće igre sa ovog uređaja. Propušten dan prekida niz.
 */
export async function nizDana(db: Db, ident: Identitet, datum: string): Promise<NizDana> {
  const [red] = await db.query<{ niz: number; ukupno: number }>(
    `with dani as (
       select distinct quiz_date as d from public.plays
       where status = 'finished' and quiz_date <= $1::date
         and (user_id = $2::uuid or (user_id is null and device_id = $3::uuid))
     ), redom as (
       select d, (row_number() over (order by d desc) - 1)::int as rn from dani
     )
     select coalesce(sum(case when ($1::date - d) = rn then 1 else 0 end), 0)::int as niz,
            count(*)::int as ukupno
     from redom`,
    [datum, ident.userId, ident.deviceId],
  );
  const dana = red?.niz ?? 0;
  return { dana, vracanje: dana === 1 && (red?.ukupno ?? 0) > 1 };
}

/** „1 dan”, „2 dana”, „5 dana”, „21 dan”, „112 dana”. */
export function danaRec(n: number): string {
  const d = n % 10;
  const s = n % 100;
  return d === 1 && s !== 11 ? "dan" : "dana";
}

/** Poruke za prve dane niza, redom: indeks 0 je prvi dan. */
const PO_DANIMA = [
  "Dobro došao/la u Čik Pogodi tim. Ako znaš milion nebitnih stvari koje te niko nikada neće pitati, na prvom si mestu.",
  "Dobro došao/la nazad! Novi dan, nove pobede, srećno!",
  "Ne osvaja kviz lep, nego uporan. Samo nastavi!",
  "Četiri dana zaredom. Kod nas se to već zove tradicija.",
  "Pet dana! Komšiluk počinje da te pita za savet.",
  "Šest dana zaredom. Ni penzioneri ne čitaju čitulje ovako redovno.",
  "Cela nedelja! Da je ovo teretana, već bi slikao/la mišiće u ogledalu.",
  "Osmi dan. Mozak ti je zagrejan kao rerna pred nedeljni ručak.",
  "Devet dana. Polako, ostavi i drugima nešto da pogode.",
  "Deset dana zaredom! Dvocifreno, kao kafa u centru grada.",
  "Jedanaest. Ti si onaj/ona koji/a na slavi zna ko je pevao koju pesmu.",
  "Dvanaest dana. U kafani bi te već častili.",
  "Trinaesti dan. Kažu da je baksuzan, ali ti si došao/la, znači nije.",
  "Dve nedelje bez pauze. Ovo je ozbiljnije od većine novogodišnjih odluka.",
  "Petnaest dana! Pola meseca znanja koje ti niko nije tražio.",
  "Šesnaest. Rakija se peče duže, ali ne mnogo.",
  "Sedamnaest dana. Ovaj niz ima više kondicije od reprezentacije.",
  "Osamnaest! Punoletan niz, sme sam da izlazi.",
  "Devetnaest dana. Tvoja baba bi rekla: „E, to je moje dete.”",
  "Dvadeset! Kad te pitaju čime se baviš, slobodno reci: pogađam.",
  "Tri nedelje zaredom. Kažu da je toliko potrebno da nešto postane navika. Čestitamo, navukao/la si se.",
  "Dvadeset dva. Ti više ne igraš kviz, kviz igra tebe.",
  "Dvadeset tri dana. I Gugl ponekad tebe pita.",
  "Dvadeset četiri. Ceo dan ima toliko sati, a ti toliko dana. Slučajnost? Ne bih rekao.",
  "Dvadeset pet dana! Četvrt stoleća u kviz godinama.",
  "Dvadeset šest. Prodavačica u marketu te pita za cene, a ne obrnuto.",
  "Dvadeset sedam dana. Uporan/na si kao komšija sa bušilicom u nedelju ujutru.",
  "Dvadeset osam. Ceo februar bez greške.",
  "Dvadeset devet dana. Sutra je veliki dan, ne zezaj!",
  "Mesec dana zaredom! Ovo zaslužuje torte, prase i trubače.",
];

/** Okrugli brojevi posle prvog meseca. */
const JUBILEJI: Record<number, string> = {
  40: "Četrdeset dana! Toliko traje i zimnica kad je dobro sakriješ.",
  50: "Pedeset dana! Zlatni jubilej. Neko bi ti dao plaketu, mi ti dajemo ovu poruku.",
  77: "Sedamdeset sedam dana. Sedmica dupla, sreća trostruka.",
  100: "STO DANA ZAREDOM! Ovo nije niz, ovo je životni stil.",
  150: "Sto pedeset dana. Pola godine smo zajedno, red je da upoznaš roditelje.",
  200: "Dvesta dana! Ako ovo pročita neko na poslu, reci da istražuješ tržište.",
  250: "Dvesta pedeset dana. Imaš više kontinuiteta od gradskog prevoza.",
  300: "Trista dana! Spartanci su bili manje uporni.",
  365: "Cela godina, dan za danom. Svaka čast, stvarno. Ovo se ne pravi, ovo se zaslužuje.",
  500: "Petsto dana. Mi smo kviz napravili, ali ti si ga osvojio/la.",
  1000: "Hiljadu dana! Pevali bi ti na Guči da znaju.",
};

/** Za dane posle prvog meseca koji nisu jubilej: vrte se redom, uz broj dana. */
const POSLE_MESECA = [
  "{n} dana zaredom. Ovo više nije sreća, ovo je karakter.",
  "{n} dana! Ni sunce ne izlazi ovako pouzdano preko zime.",
  "{n} dana zaredom. Kad bi znanje bilo struja, ti bi grejao/la ceo blok.",
  "{n} dana. Tvoj niz ima duži staž od nekih brakova.",
  "{n} dana zaredom. Neko skuplja salvete, ti skupljaš dane.",
  "{n} dana. Ako nekad zatreba neko ko zna cenu kajmaka i ko je pevao „Plači zemljo”, eto tebe.",
  "{n} dana! Slobodno upiši u CV: profesionalni pogađač.",
  "{n} dana zaredom. Ne staj sad, tek si se zagrejao/la.",
];

/** Kad se igrač vrati posle prekinutog niza. */
const POVRATAK = "Niz je pukao, ali ti nisi. Ajmo iz početka, dan prvi, pa polako ka rekordu!";

export function porukaZaNiz(niz: NizDana): string {
  const n = niz.dana;
  if (n <= 0) return "";
  if (niz.vracanje) return POVRATAK;
  if (n <= PO_DANIMA.length) return PO_DANIMA[n - 1];
  if (JUBILEJI[n]) return JUBILEJI[n];
  return POSLE_MESECA[(n - PO_DANIMA.length - 1) % POSLE_MESECA.length].replace("{n}", String(n));
}
