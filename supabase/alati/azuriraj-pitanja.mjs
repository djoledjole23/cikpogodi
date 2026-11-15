/**
 * Upisuje sveža pitanja u pravu bazu: briše dane od danas nadalje i upisuje nove.
 * Pokreće se duplim klikom na azuriraj-pitanja.bat u glavnom folderu.
 *
 * Podatke za vezu čita iz .env.local (red DATABASE_URL). Ništa ne šalje nikuda drugde.
 */
import { readdirSync, readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import postgres from "postgres";

const koren = join(dirname(fileURLToPath(import.meta.url)), "..", "..");

function adresaBaze() {
  let tekst;
  try {
    tekst = readFileSync(join(koren, ".env.local"), "utf8");
  } catch {
    return "";
  }
  for (const red of tekst.split(/\r?\n/)) {
    const m = /^\s*DATABASE_URL\s*=\s*(.*)$/.exec(red);
    if (m) return m[1].trim().replace(/^["']|["']$/g, "");
  }
  return "";
}

const url = adresaBaze();
if (!url) {
  console.error("\nU .env.local nema popunjen DATABASE_URL, pa ne znam u koju bazu da upišem.");
  console.error("Otvori podesi.bat, popuni taj red, pa pokreni ovo ponovo.\n");
  process.exit(1);
}

const dir = join(koren, "supabase", "alati");
const fajl = readdirSync(dir)
  .filter((f) => /^zameni-dane-.*\.sql$/.test(f))
  .sort()
  .pop();
if (!fajl) {
  console.error("\nNema nijednog fajla zameni-dane-*.sql u supabase\\alati.\n");
  process.exit(1);
}

const sql = postgres(url, { prepare: false, max: 1, connect_timeout: 15, ssl: "require" });
const danas = "(now() at time zone 'Europe/Belgrade')::date";

try {
  console.log(`\nUpisujem: ${fajl}`);
  console.log("Ovo briše pitanja i odigrane igre od danas nadalje, pa upisuje nova. Traje desetak sekundi...\n");
  await sql.unsafe(readFileSync(join(dir, fajl), "utf8")).simple();

  const [{ dana }] = await sql.unsafe(`select count(*)::int as dana from public.daily_quiz where quiz_date >= ${danas}`);
  const redovi = await sql.unsafe(
    `select segment::int as segment, count(*)::int as n from public.daily_quiz_items where quiz_date = ${danas} group by segment order by segment`,
  );
  const [joker] = await sql.unsafe(
    `select snapshot->>'pitanje' as pitanje from public.daily_quiz_items where quiz_date = ${danas} and segment = 5 limit 1`,
  );

  console.log("GOTOVO.\n");
  console.log(`Dana sa pitanjima, od danas: ${dana}`);
  console.log("Današnja igra:");
  const imena = { 1: "pesme", 2: "artikli", 3: "parovi za guglanje", 4: "kadrovi iz filmova", 5: "Joker" };
  for (const r of redovi) console.log(`  segment ${r.segment} (${imena[r.segment] ?? "?"}): ${r.n}`);
  if (joker) console.log(`\nDanašnji Joker: ${joker.pitanje}`);
  console.log("\nOtvori sajt i odigraj da proveriš.");
} catch (e) {
  console.error("\nNIJE USPELO:", e.message);
  console.error("\nPošalji sliku ovog prozora.");
  process.exitCode = 1;
} finally {
  await sql.end({ timeout: 5 });
}
