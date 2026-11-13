"use client";

import { useEffect, useSyncExternalStore } from "react";
import { postaviZvuk, pratiZvuk, sfx, zvukUkljucen } from "@/lib/sound";
import { IconBezZvuka, IconZvuk } from "./icons";

/** Dugme za zvuk. Uvek je u zaglavlju i pamti izbor. */
export function SoundToggle() {
  const ukljucen = useSyncExternalStore(pratiZvuk, zvukUkljucen, () => true);

  // Klik-zvuk za svu dugmad na sajtu, na jednom mestu.
  useEffect(() => {
    const naKlik = (e: MouseEvent) => {
      const meta = e.target instanceof Element ? e.target.closest("button, a.btn, [data-klik]") : null;
      if (meta && !meta.hasAttribute("data-bez-klika")) sfx.klik();
    };
    document.addEventListener("click", naKlik);
    return () => document.removeEventListener("click", naKlik);
  }, []);

  return (
    <button
      type="button"
      className="icon-btn"
      data-bez-klika
      aria-pressed={ukljucen}
      aria-label={ukljucen ? "Zvuk je uključen. Isključi zvuk" : "Zvuk je isključen. Uključi zvuk"}
      onClick={() => {
        postaviZvuk(!ukljucen);
        if (!ukljucen) sfx.ding(1);
      }}
    >
      {ukljucen ? <IconZvuk /> : <IconBezZvuka />}
    </button>
  );
}
