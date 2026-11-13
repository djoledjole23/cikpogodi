-- Par pojmova za isti period postoji samo jednom, da seed može da se pusti više puta bez duplikata.
create unique index if not exists trend_pairs_par_idx on public.trend_pairs (term_a, term_b, period);
