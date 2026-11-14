import type { Ocena, PrikazCena, PrikazFilm, PrikazGugla, PrikazJoker, PrikazPesma, SegmentStanje } from "./types";

/**
 * Rečenica koja ide uz rezultat pitanja. Bira se po tome koliko je igrač bio blizu,
 * a među više varijanti po rednom broju pitanja, da isto pitanje uvek dobije isti komentar.
 */
const izaberi = (lista: string[], seme: number) => lista[Math.abs(seme) % lista.length];

export function komentarCena(ocena: Ocena, p: PrikazCena, seme: number): string {
  if (p.unos === null) return izaberi(["Vreme! Kasa ne čeka.", "Dok si ti računao, red je otišao.", "Isteklo. Sledeći put brže."], seme);
  if (p.unos === p.prava) return izaberi(["U dinar! Ti radiš na kasi?", "U dinar. Svaka čast, majstore."], seme);
  if (ocena.poeni === ocena.maxPoena) {
    return izaberi(["Ajde bre, pa ti znaš cene!", "Pogodak. Tebe na pijaci ne mogu da prevare.", "To se zove redovan kupac."], seme);
  }
  if (ocena.poeni > 0) return izaberi(["Blizu, blizu. Pola poena za trud.", "Za dlaku. Nije loše.", "Toplo, ali nije vruće."], seme);
  // Veliki promašaj (manje od pola ili više od duplo): uvek ista rečenica, po želji vlasnika sajta.
  if (p.unos < p.prava * 0.5 || p.unos > p.prava * 2) return "Poznaješ cene isto koliko i Bogoljub.";
  return izaberi(["Ni blizu, ali svaka čast na hrabrosti.", "Kad si ti poslednji put bio u prodavnici?", "Ovo nije prošlo. Idemo dalje."], seme);
}

export function komentarGugla(ocena: Ocena, p: PrikazGugla, seme: number): string {
  if (p.izbor === null) return izaberi(["Vreme! Sledeći put tapni odmah.", "Predugo si se dvoumio."], seme);
  const tesno = Math.min(p.indeksA, p.indeksB) >= 70;
  if (ocena.tacno) {
    if (tesno) return izaberi(["Bilo je tesno, a ti pogodi!", "Za dlaku, ali tvoja je."], seme);
    return izaberi(["Tako je. Znaš ti šta narod kuca.", "Ajde bre, pa to se zna!", "Pogodak! Kao da čitaš tuđe pretrage."], seme);
  }
  if (tesno) return izaberi(["Bilo je tesno, ali ne.", "Za dlaku. Narod je presudio."], seme);
  if (p.puta >= 3) return izaberi(["Uh. Nije bilo ni blizu.", "Narod se ne slaže. Nimalo."], seme);
  return izaberi(["A ne. Narod misli drugačije.", "Ni blizu, ali svaka čast na hrabrosti.", "Ovaj put ne."], seme);
}

export function komentarPesma(ocena: Ocena, p: PrikazPesma, seme: number): string {
  if (ocena.istek) return izaberi(["Klip je gotov, a pesma ostade nepogođena.", "Odsvirala je cela. Sledeća ide brže."], seme);
  if (p.neZnam) return izaberi(["Nema veze. Sad znaš.", "Pošteno. Sledeća je tvoja."], seme);
  if (!p.tacno) return izaberi(["A ne. Nije ta.", "Ni blizu, ali svaka čast na hrabrosti.", "Promašaj. Uši na pranje."], seme);
  if (ocena.poeni === ocena.maxPoena) return izaberi(["Po prvom taktu! Ti ovo imaš u krvi.", "Dve sekunde i gotovo. Ajde bre!"], seme);
  if (p.slusanoMs <= 6000) return izaberi(["Brzo si to skapirao.", "Tako je. Uvo ti radi."], seme);
  return izaberi(["Tako je. Malo si se premišljao, al' dobro.", "Pogodak, i to posle lepog slušanja."], seme);
}

export function komentarFilm(ocena: Ocena, p: PrikazFilm, seme: number): string {
  if (ocena.istek) return izaberi(["Vreme! Film je otišao u arhivu.", "Isteklo. Kraj projekcije."], seme);
  if (p.neZnam) return izaberi(["Nema veze. Stavi ga na spisak za gledanje.", "Pošteno. Sad znaš šta da pustiš večeras."], seme);
  if (!p.tacno) return izaberi(["A ne. Drugi film.", "Ni blizu, ali svaka čast na hrabrosti.", "Promašaj. Repriza je obavezna."], seme);
  return izaberi(["Tako je! Ti si ovo gledao sto puta.", "Ajde bre, pa to se zna!", "Pogodak. Pravi filmofil."], seme);
}

export function komentarJoker(ocena: Ocena, p: PrikazJoker, seme: number): string {
  if (ocena.istek) return izaberi(["Vreme! Joker je ostao u špilu.", "Isteklo. Bonus ode niz vodu."], seme);
  if (p.neZnam) return izaberi(["Ništa od bonusa. Sutra je novi Joker.", "Pošteno. Joker čeka sutra."], seme);
  if (!p.tacno) return izaberi(["Nije. Joker ti je pobegao.", "Promašaj. Bonus ostaje u kasi."], seme);
  return izaberi(["Joker pada! Pedeset preko svega.", "To! Bonus je tvoj.", "Ajde bre, pa ti pratiš sve!"], seme);
}

export function komentarSegmenta(s: SegmentStanje): string {
  if (s.bonus) return s.poeni > 0 ? "Joker pokupljen. Bonus je tvoj." : "Joker je ostao u špilu. Sutra je novi.";
  const deo = s.max > 0 ? s.poeni / s.max : 0;
  if (deo === 1) return "Sve tačno. Pa ti si opasan.";
  if (deo >= 0.7) return "Odlično. Ovo se zove znanje.";
  if (deo >= 0.4) return "Solidno. Ima tu materijala.";
  if (deo > 0) return "Moglo je i bolje, ali moglo je i gore.";
  return "Nula. Dešava se i najboljima. Navodno.";
}
