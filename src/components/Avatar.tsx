/**
 * Avatar igrača: mali crtani lik koji se uvek isto nacrta za isti nalog (iz oznake naloga),
 * pa niko ne mora da ga bira ni da šalje sliku. Boja, oči, usta i dodatak (šajkača, brkovi, naočare, šubara…)
 * daju nekoliko stotina kombinacija. Čist SVG, bez spoljnih slika.
 */

const POZADINE = ["#ff4b33", "#ffb000", "#2fb67a", "#3aa0ff", "#b06cff", "#ff7bb0", "#00b3a4", "#ff8a3d"];
const LICA = ["#ffe2bd", "#f6c99a", "#e2a877", "#c98a5b", "#ffefd6"];
const MASTILO = "#1b1210";

/** Mali, stabilan heš teksta (FNV-1a), da isti nalog uvek dobije isti lik. */
function hes(tekst: string): number {
  let h = 0x811c9dc5;
  for (let i = 0; i < tekst.length; i++) {
    h ^= tekst.charCodeAt(i);
    h = Math.imul(h, 0x01000193);
  }
  return h >>> 0;
}

export function Avatar({ seme, size = 40, title }: { seme: string; size?: number; title?: string }) {
  const h = hes(seme);
  const deo = (pomak: number, n: number) => (h >>> pomak) % n;
  const pozadina = POZADINE[deo(0, POZADINE.length)];
  const lice = LICA[deo(3, LICA.length)];
  const oci = deo(6, 4);
  const usta = deo(9, 4);
  const dodatak = deo(12, 7);
  const kapa = POZADINE[(deo(0, POZADINE.length) + 3) % POZADINE.length];

  return (
    <svg
      className="avatar"
      width={size}
      height={size}
      viewBox="0 0 48 48"
      role={title ? "img" : undefined}
      aria-label={title}
      aria-hidden={title ? undefined : true}
      focusable="false"
    >
      <circle cx="24" cy="24" r="23" fill={pozadina} stroke={MASTILO} strokeWidth="2" />
      {/* glava */}
      <path d="M11 27c0-9 5.5-15 13-15s13 6 13 15-5.5 14-13 14-13-5-13-14z" fill={lice} stroke={MASTILO} strokeWidth="2" strokeLinejoin="round" />

      {/* oči */}
      {oci === 0 && (
        <>
          <circle cx="19" cy="26" r="1.9" fill={MASTILO} />
          <circle cx="29" cy="26" r="1.9" fill={MASTILO} />
        </>
      )}
      {oci === 1 && <path d="M16.5 26.5q2.5-3 5 0M26.5 26.5q2.5-3 5 0" fill="none" stroke={MASTILO} strokeWidth="2" strokeLinecap="round" />}
      {oci === 2 && (
        <>
          <circle cx="19" cy="26" r="1.9" fill={MASTILO} />
          <path d="M26.5 26h5" stroke={MASTILO} strokeWidth="2" strokeLinecap="round" />
        </>
      )}
      {oci === 3 && (
        <>
          <ellipse cx="19" cy="26" rx="2.6" ry="3" fill="#fff" stroke={MASTILO} strokeWidth="1.5" />
          <ellipse cx="29" cy="26" rx="2.6" ry="3" fill="#fff" stroke={MASTILO} strokeWidth="1.5" />
          <circle cx="19.6" cy="26.5" r="1.2" fill={MASTILO} />
          <circle cx="29.6" cy="26.5" r="1.2" fill={MASTILO} />
        </>
      )}

      {/* usta */}
      {usta === 0 && <path d="M19 33q5 4 10 0" fill="none" stroke={MASTILO} strokeWidth="2" strokeLinecap="round" />}
      {usta === 1 && <path d="M19 32.5q5 6 10 0z" fill="#fff" stroke={MASTILO} strokeWidth="2" strokeLinejoin="round" />}
      {usta === 2 && <path d="M20 34h8" stroke={MASTILO} strokeWidth="2" strokeLinecap="round" />}
      {usta === 3 && <path d="M20 34q3.5-2.5 8 .5" fill="none" stroke={MASTILO} strokeWidth="2" strokeLinecap="round" />}

      {/* dodatak */}
      {dodatak === 0 && (
        // šajkača
        <path d="M10.5 19.5l13.5-9 13.5 9-3 1.5-10.5-4.5-10.5 4.5z" fill="#6b7a4f" stroke={MASTILO} strokeWidth="2" strokeLinejoin="round" />
      )}
      {dodatak === 1 && (
        // brkovi
        <path d="M24 30.5c-2.5-2-6-1.5-8 1.5 3 .5 6 .5 8-1.5zm0 0c2.5-2 6-1.5 8 1.5-3 .5-6 .5-8-1.5z" fill={MASTILO} />
      )}
      {dodatak === 2 && (
        // naočare
        <path d="M14 26a5 5 0 1010 0 5 5 0 10-10 0zm10 0a5 5 0 1010 0 5 5 0 10-10 0z" fill="none" stroke={MASTILO} strokeWidth="2" />
      )}
      {dodatak === 3 && (
        // kapa sa šiltom
        <>
          <path d="M11.5 20c1-6 6-9.5 12.5-9.5s11.5 3.5 12.5 9.5z" fill={kapa} stroke={MASTILO} strokeWidth="2" strokeLinejoin="round" />
          <path d="M30 20h10" stroke={MASTILO} strokeWidth="3" strokeLinecap="round" />
        </>
      )}
      {dodatak === 4 && (
        // šubara
        <path d="M10.5 21c-1-7 5-11.5 13.5-11.5s14.5 4.5 13.5 11.5q-13.5-4.5-27 0z" fill="#4a3a33" stroke={MASTILO} strokeWidth="2" strokeLinejoin="round" />
      )}
      {dodatak === 5 && (
        // frizura
        <path d="M11.5 22c0-8 5-12 12.5-12s12.5 4 12.5 12c-3-4-6-5.5-9-5.5s-4 2-7 2-6 1-9 3.5z" fill={MASTILO} />
      )}
      {/* dodatak 6: bez ičega */}
    </svg>
  );
}
