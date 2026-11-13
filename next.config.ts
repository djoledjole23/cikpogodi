import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  cacheComponents: true,
  partialPrefetching: true,
  // PGlite (lokalna baza za razvoj) nosi WASM fajl: ne pakuj ga, učitaj iz node_modules.
  serverExternalPackages: ["@electric-sql/pglite"],
};

export default nextConfig;
