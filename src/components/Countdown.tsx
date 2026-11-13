"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { formatOdbrojavanje, msDoPonoci } from "@/lib/time";

/** Odbrojavanje do sledeće igre (ponoć po Beogradu). Kad istekne, osveži stranu. */
export function Countdown() {
  const router = useRouter();
  const [ms, setMs] = useState<number | null>(null);

  useEffect(() => {
    const otkucaj = () => {
      const ostalo = msDoPonoci();
      setMs(ostalo);
      if (ostalo <= 1000) setTimeout(() => router.refresh(), 1500);
    };
    otkucaj();
    const id = setInterval(otkucaj, 1000);
    return () => clearInterval(id);
  }, [router]);

  return (
    <span className="countdown" role="timer" aria-label="Vreme do sledeće igre">
      {ms === null ? "--:--:--" : formatOdbrojavanje(ms)}
    </span>
  );
}
