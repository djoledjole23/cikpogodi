import type { MetadataRoute } from "next";

/** PWA: omogućava „Dodaj na početni ekran”. */
export default function manifest(): MetadataRoute.Manifest {
  return {
    name: "Čik Pogodi!",
    short_name: "Čik Pogodi!",
    description: "Dnevni kviz: pet mini igara, jedan pokušaj dnevno.",
    lang: "sr-Latn",
    start_url: "/",
    scope: "/",
    display: "standalone",
    orientation: "portrait",
    background_color: "#1b1311",
    theme_color: "#1b1311",
    icons: [
      { src: "/icons/icon-192.png", sizes: "192x192", type: "image/png" },
      { src: "/icons/icon-512.png", sizes: "512x512", type: "image/png" },
      { src: "/icons/icon-maskable-512.png", sizes: "512x512", type: "image/png", purpose: "maskable" },
    ],
  };
}
