import Link from "next/link";

export function Footer() {
  return (
    <footer className="footer">
      <p>
        Cene: zvanični cenovnici lanaca, data.gov.rs · Slike: Open Food Facts · Muzika: Deezer · Pretrage: Google
        Trends
      </p>
      <nav aria-label="Pravne strane">
        <Link href="/pravila-privatnosti">Pravila privatnosti</Link>
        <Link href="/uslovi-koriscenja">Uslovi korišćenja</Link>
      </nav>
    </footer>
  );
}
