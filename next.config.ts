import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  cacheComponents: true,
  partialPrefetching: true,
  // PGlite (lokalna baza za razvoj) nosi WASM fajl: ne pakuj ga, učitaj iz node_modules.
  serverExternalPackages: ["@electric-sql/pglite"],
  // Dnevni posao koji dopunjava pitanja čita data/ i gleda koje slike postoje u public/,
  // pa ti fajlovi moraju da uđu u paket te funkcije.
  outputFileTracingIncludes: {
    "/api/cron/dopuni": ["./data/**", "./public/artikli/**", "./public/kadrovi/**", "./public/joker/**"],
  },
};

export default nextConfig;
