import Link from "next/link";
import { Page } from "@/components/Page";

export default function NijeNadjeno() {
  return (
    <Page>
      <div className="stack">
        <h1 className="h1">Ovde nema ničega</h1>
        <p className="lead">Ni blizu, ali svaka čast na hrabrosti. Ta strana ne postoji.</p>
      </div>
      <Link href="/" className="btn">
        Na početnu
      </Link>
    </Page>
  );
}
