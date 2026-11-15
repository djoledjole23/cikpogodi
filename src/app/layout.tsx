import type { Metadata, Viewport } from "next";
// Fontovi su u paketu (bez zahteva ka Google-u): Baloo 2 za naslove, Nunito za tekst.
import "@fontsource/baloo-2/800.css";
import "@fontsource/nunito/600.css";
import "@fontsource/nunito/700.css";
import "@fontsource/nunito/800.css";
import "./globals.css";
import { Analytics } from "@vercel/analytics/next";
import { CookieBanner } from "@/components/CookieBanner";

const SAJT = process.env.NEXT_PUBLIC_SITE_URL ?? "https://cikpogodi.online";

export const metadata: Metadata = {
  metadataBase: new URL(SAJT),
  title: {
    default: "Čik Pogodi! – dnevni kviz",
    template: "%s · Čik Pogodi!",
  },
  description:
    "Pet mini igara, jedan pokušaj dnevno. Pogodi pesmu, cenu, šta se više gugla i film, pa vidi gde si na rang listi.",
  applicationName: "Čik Pogodi!",
  openGraph: {
    type: "website",
    locale: "sr_RS",
    siteName: "Čik Pogodi!",
    title: "Čik Pogodi! – dnevni kviz",
    description: "Pet mini igara, jedan pokušaj dnevno. Svi dobijaju ista pitanja.",
  },
  appleWebApp: { capable: true, title: "Čik Pogodi!", statusBarStyle: "black-translucent" },
};

export const viewport: Viewport = {
  themeColor: "#1b1311",
  colorScheme: "dark",
  width: "device-width",
  initialScale: 1,
  viewportFit: "cover",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="sr-Latn">
      <body>
        {children}
        <CookieBanner />
        {/* Brojanje poseta na Vercelu: bez kolačića i bez praćenja pojedinačnog igrača. */}
        <Analytics />
      </body>
    </html>
  );
}
