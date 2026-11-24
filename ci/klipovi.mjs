import fs from "fs";
const p = JSON.parse(fs.readFileSync("data/songs.json","utf8")).pesme;
const out = [];
const j = async (u) => { for (let i=0;i<3;i++){ try { const r = await fetch(u); if (r.ok) return await r.json(); } catch {} await new Promise(r=>setTimeout(r,800)); } return null; };
for (const s of p) {
  const d = await j(`https://api.deezer.com/track/${s.deezerId ?? s.deezer_id}`);
  const dz = typeof d?.preview === "string" && d.preview.startsWith("https://") ? d.preview : null;
  let dzOk = false;
  if (dz) { try { const r = await fetch(dz, { method: "GET", headers: { Range: "bytes=0-1000" } }); dzOk = r.status < 300 || r.status === 206; } catch {} }
  let it = null;
  const iid = s.itunesId ?? s.itunes_id;
  if (iid) { const x = await j(`https://itunes.apple.com/lookup?id=${iid}&country=rs`); it = x?.results?.[0]?.previewUrl ?? null; }
  let predlog = null;
  if (!dzOk && !it) {
    const q = encodeURIComponent(`${s.izvodjac ?? s.artist} ${s.naslov ?? s.title}`);
    const x = await j(`https://itunes.apple.com/search?term=${q}&entity=song&limit=5`);
    predlog = (x?.results ?? []).map(r => ({ id: r.trackId, a: r.artistName, t: r.trackName, prev: !!r.previewUrl }));
    const y = await j(`https://api.deezer.com/search?q=${q}&limit=5`);
    predlog = { itunes: predlog, deezer: (y?.data ?? []).map(r => ({ id: r.id, a: r.artist?.name, t: r.title, prev: !!r.preview, readable: r.readable })) };
  }
  out.push({ dz: s.deezerId ?? s.deezer_id, a: s.izvodjac ?? s.artist, t: s.naslov ?? s.title, dzOk, deezerPreview: !!dz, itunes: !!it, predlog });
}
fs.writeFileSync("klipovi.json", JSON.stringify(out, null, 1));
console.log("LOSE:", JSON.stringify(out.filter(x => !x.dzOk && !x.itunes), null, 1));
console.log("SAMO_ITUNES:", out.filter(x => !x.dzOk && x.itunes).map(x => x.a + " - " + x.t).join(" | "));
