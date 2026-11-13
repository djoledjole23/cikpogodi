/** „1.104” – cele dinare sa tačkom za hiljade. */
export function broj(n: number): string {
  return Math.round(n)
    .toString()
    .replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

/** „1.104 din” */
export const din = (n: number) => `${broj(n)} din`;
