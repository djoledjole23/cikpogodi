-- Segment 1 (Pogodi pesmu).
-- Žanr pesme služi za dnevni miks (malo folka, malo roka, malo popa, malo trepa).
alter table public.songs add column if not exists genre text;
-- Od kada pesma trenutno svira (null = pauzirana). Zajedno sa listened_ms daje ukupno preslušano vreme,
-- koje server meri sam i koje preživljava osvežavanje strane.
alter table public.play_answers add column if not exists playing_since timestamptz;
