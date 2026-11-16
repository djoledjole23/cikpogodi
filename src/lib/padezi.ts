/** „Danas je igralo 12 ljudi” sa pravim padežom i glagolom za svaki broj. */
export function kolikoIgralo(n: number): string {
  const d = n % 10;
  const s = n % 100;
  if (d === 1 && s !== 11) return `Danas je igrao ${n} čovek.`;
  if (d >= 2 && d <= 4 && (s < 12 || s > 14)) return `Danas su igrala ${n} čoveka.`;
  return `Danas je igralo ${n} ljudi.`;
}
