-- Segment 5 je sada „Joker pitanje”: jedno pitanje dnevno za bonus, igrač kuca odgovor.
-- Posle odgovora se prikažu fotografija i veliki broj (npr. „92”). Tabela rebuses ostaje, ali se ne koristi.

create table if not exists public.joker_questions (
  id bigint generated always as identity primary key,
  question text not null unique,
  answer text not null,
  aliases text[] not null default '{}',
  image_url text,
  reveal_number text,
  reveal_label text,
  created_at timestamptz not null default now()
);
-- Bez polisa: pitanja i odgovore čita samo server.
alter table public.joker_questions enable row level security;

alter table public.daily_quiz_items add column if not exists joker_id bigint references public.joker_questions (id);
alter table public.daily_quiz_items drop constraint if exists stavka_odgovara_segmentu;
alter table public.daily_quiz_items add constraint stavka_odgovara_segmentu check (
  num_nonnulls(song_id, product_id, trend_pair_id, film_clip_id, film_still_id, rebus_id, joker_id) = 1
  and (
    (segment = 1 and song_id is not null)
    or (segment = 2 and product_id is not null)
    or (segment = 3 and trend_pair_id is not null)
    or (segment = 4 and (film_clip_id is not null or film_still_id is not null))
    or (segment = 5 and (rebus_id is not null or joker_id is not null))
  )
);
