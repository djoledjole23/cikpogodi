import type { Ocena, PrikazCena, PrikazGugla, SegmentStanje } from "./types";

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
  if (p.unos < p.prava * 0.5) return izaberi(["Te cene su bile pre deset godina.", "E, da je bar toliko."], seme);
  if (p.unos > p.prava * 2) return izaberi(["Polako, nije ovo aerodrom.", "Ti kupuješ na benzinskoj pumpi?"], seme);
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

export function komentarSegmenta(s: SegmentStanje): string {
  const deo = s.max > 0 ? s.poeni / s.max : 0;
  if (deo === 1) return "Sve tačno. Pa ti si opasan.";
  if (deo >= 0.7) return "Odlično. Ovo se zove znanje.";
  if (deo >= 0.4) return "Solidno. Ima tu materijala.";
  if (deo > 0) return "Moglo je i bolje, ali moglo je i gore.";
  return "Nula. Dešava se i najboljima. Navodno.";
}
