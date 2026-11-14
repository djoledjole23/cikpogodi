-- Segment 4 je sada „Pogodi domaći film/seriju”: igrač vidi kadar (fotografiju) i kuca naslov, bez ponuđenih odgovora.

-- Kadar je fotografija vezana za film. Adresa slike ne odaje naslov.
create table if not exists public.film_stills (
  id bigint generated always as identity primary key,
  film_id bigint not null references public.films (id) on delete cascade,
  image_url text not null unique,
  note text,
  created_at timestamptz not null default now()
);
alter table public.film_stills enable row level security;

create unique index if not exists films_title_idx on public.films (title);

-- Odgovori se više ne nude iz spiska, pa spisak filmova ne sme da bude javan (bio bi puškica).
drop policy if exists "katalog filmova je javan" on public.films;

alter table public.daily_quiz_items add column if not exists film_still_id bigint references public.film_stills (id);
alter table public.daily_quiz_items drop constraint if exists stavka_odgovara_segmentu;
alter table public.daily_quiz_items add constraint stavka_odgovara_segmentu check (
  num_nonnulls(song_id, product_id, trend_pair_id, film_clip_id, film_still_id, rebus_id) = 1
  and (
    (segment = 1 and song_id is not null)
    or (segment = 2 and product_id is not null)
    or (segment = 3 and trend_pair_id is not null)
    or (segment = 4 and (film_clip_id is not null or film_still_id is not null))
    or (segment = 5 and rebus_id is not null)
  )
);
