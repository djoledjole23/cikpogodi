-- Čik Pogodi! – početna šema
-- Pravilo: tabele sa tačnim odgovorima NEMAJU nijednu RLS polisu za čitanje.
-- Do njih dolazi samo server (secret/service_role ključ), nikad browser.

-- ───────────────────────── Nalozi ─────────────────────────

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  username text,
  created_at timestamptz not null default now(),
  constraint username_format check (username is null or username ~ '^[A-Za-z0-9_ČĆŠŽĐčćšžđ]{3,20}$')
);
-- Jedinstveno bez obzira na velika/mala slova („Cecko” = „cecko”).
create unique index profiles_username_lower_idx on public.profiles (lower(username));

create table public.admins (
  user_id uuid primary key references auth.users (id) on delete cascade,
  created_at timestamptz not null default now()
);

-- ───────────────────────── Sadržaj ─────────────────────────

create table public.songs (
  id bigint generated always as identity primary key,
  artist text not null,
  title text not null,
  aliases text[] not null default '{}',
  deezer_id bigint unique,
  itunes_id bigint,
  cover_url text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table public.films (
  id bigint generated always as identity primary key,
  title text not null,
  year smallint,
  aliases text[] not null default '{}',
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table public.film_clips (
  id bigint generated always as identity primary key,
  film_id bigint not null references public.films (id) on delete cascade,
  youtube_id text not null,
  start_s integer not null check (start_s >= 0),
  end_s integer not null,
  channel_name text not null,
  channel_url text,
  note text,
  created_at timestamptz not null default now(),
  constraint clip_trajanje check (end_s - start_s between 5 and 15)
);

create table public.products (
  id bigint generated always as identity primary key,
  barcode text unique,
  name text not null,
  size text,
  image_url text not null,
  price_avg numeric(10, 2) not null check (price_avg > 0),
  price_min numeric(10, 2),
  price_max numeric(10, 2),
  cheapest_chain text,
  price_date date not null,
  active boolean not null default true,
  updated_at timestamptz not null default now()
);

create table public.trend_pairs (
  id bigint generated always as identity primary key,
  term_a text not null,
  term_b text not null,
  index_a smallint not null check (index_a between 0 and 100),
  index_b smallint not null check (index_b between 0 and 100),
  period text not null,
  fetched_on date not null,
  created_at timestamptz not null default now(),
  constraint par_nije_nereseno check (index_a <> index_b)
);

create table public.rebuses (
  id bigint generated always as identity primary key,
  image_path text,
  svg text,
  answer text not null,
  aliases text[] not null default '{}',
  created_at timestamptz not null default now(),
  constraint rebus_ima_sliku check (image_path is not null or svg is not null)
);

create table public.daily_quiz (
  quiz_date date primary key,
  status text not null default 'draft' check (status in ('draft', 'published')),
  created_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default now(),
  published_at timestamptz
);

create table public.daily_quiz_items (
  id bigint generated always as identity primary key,
  quiz_date date not null references public.daily_quiz (quiz_date) on delete cascade,
  segment smallint not null check (segment between 1 and 5),
  position smallint not null check (position >= 1),
  song_id bigint references public.songs (id),
  product_id bigint references public.products (id),
  trend_pair_id bigint references public.trend_pairs (id),
  film_clip_id bigint references public.film_clips (id),
  rebus_id bigint references public.rebuses (id),
  -- Zamrznut tačan odgovor za taj dan (npr. cena na dan kviza), da kasnije izmene ne menjaju stare rezultate.
  snapshot jsonb not null default '{}',
  unique (quiz_date, segment, position),
  constraint stavka_odgovara_segmentu check (
    num_nonnulls(song_id, product_id, trend_pair_id, film_clip_id, rebus_id) = 1
    and (
      (segment = 1 and song_id is not null)
      or (segment = 2 and product_id is not null)
      or (segment = 3 and trend_pair_id is not null)
      or (segment = 4 and film_clip_id is not null)
      or (segment = 5 and rebus_id is not null)
    )
  )
);

-- ───────────────────────── Igre ─────────────────────────

create table public.plays (
  id uuid primary key default gen_random_uuid(),
  quiz_date date not null references public.daily_quiz (quiz_date),
  user_id uuid references auth.users (id) on delete cascade,
  device_id uuid not null,
  status text not null default 'in_progress' check (status in ('in_progress', 'finished')),
  current_segment smallint not null default 1,
  current_position smallint not null default 1,
  score integer not null default 0,
  total_answer_ms integer not null default 0,
  -- none: ne ide na listu (gost / preskočio) · pending: čeka potvrdu mejla · counted: na listi
  leaderboard_status text not null default 'none' check (leaderboard_status in ('none', 'pending', 'counted')),
  started_at timestamptz not null default now(),
  finished_at timestamptz
);
-- Ulogovani: jedna igra dnevno po nalogu. Gosti: jedna igra dnevno po uređaju.
create unique index plays_user_day_idx on public.plays (quiz_date, user_id) where user_id is not null;
create unique index plays_guest_device_day_idx on public.plays (quiz_date, device_id) where user_id is null;
create index plays_device_day_idx on public.plays (quiz_date, device_id);
create index plays_leaderboard_idx on public.plays (quiz_date, score desc, total_answer_ms)
  where status = 'finished' and leaderboard_status = 'counted';

create table public.play_answers (
  id bigint generated always as identity primary key,
  play_id uuid not null references public.plays (id) on delete cascade,
  item_id bigint not null references public.daily_quiz_items (id),
  served_at timestamptz not null default now(),
  answered_at timestamptz,
  answer jsonb,
  is_correct boolean,
  points integer not null default 0,
  listened_ms integer,
  answer_ms integer,
  unique (play_id, item_id)
);

-- ───────────────────────── RLS ─────────────────────────

alter table public.profiles enable row level security;
alter table public.admins enable row level security;
alter table public.songs enable row level security;
alter table public.films enable row level security;
alter table public.film_clips enable row level security;
alter table public.products enable row level security;
alter table public.trend_pairs enable row level security;
alter table public.rebuses enable row level security;
alter table public.daily_quiz enable row level security;
alter table public.daily_quiz_items enable row level security;
alter table public.plays enable row level security;
alter table public.play_answers enable row level security;

-- Javno čitljivo: korisnička imena (rang lista) i katalozi za autocomplete.
-- Katalog je ceo spisak pesama/filmova, pa ne odaje šta je u današnjem kvizu.
create policy "profili su javni" on public.profiles for select using (true);
create policy "katalog pesama je javan" on public.songs for select using (active);
create policy "katalog filmova je javan" on public.films for select using (active);
-- Sve ostalo (cene, parovi, inserti, rebusi, dnevni kviz, igre, odgovori): bez polisa = samo server.
-- Upis u bilo koju tabelu: samo server.

-- ───────────────────────── Funkcije ─────────────────────────

create function public.is_admin()
returns boolean
language sql stable security definer set search_path = ''
as $$
  select exists (select 1 from public.admins where user_id = (select auth.uid()));
$$;

create function public.username_available(p_username text)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select not exists (select 1 from public.profiles where lower(username) = lower(p_username));
$$;

-- Novi nalog dobija prazan profil. Korisničko ime upisuje server posle provere (filter psovki),
-- nikad direktno iz metapodataka koje šalje browser.
create function public.handle_new_user()
returns trigger
language plpgsql security definer set search_path = ''
as $$
begin
  insert into public.profiles (id) values (new.id) on conflict (id) do nothing;
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Kad se mejl potvrdi, rezultati „na čekanju” ulaze na rang listu.
create function public.handle_user_confirmed()
returns trigger
language plpgsql security definer set search_path = ''
as $$
begin
  if new.email_confirmed_at is not null and old.email_confirmed_at is null then
    update public.plays
      set leaderboard_status = 'counted'
      where user_id = new.id and leaderboard_status = 'pending';
  end if;
  return new;
end;
$$;

create trigger on_auth_user_confirmed
  after update of email_confirmed_at on auth.users
  for each row execute function public.handle_user_confirmed();

-- Rang lista za period [p_from, p_to] (null = bez granice). Jedan dan: p_from = p_to.
-- Vraća prvih p_limit mesta i, ako je zadat, red igrača p_user čak i kad nije u vrhu.
-- Kod istog broja poena bolji je onaj ko je ukupno brže odgovarao.
create function public.leaderboard(
  p_from date default null,
  p_to date default null,
  p_limit integer default 50,
  p_user uuid default null
)
returns table (
  rank bigint,
  user_id uuid,
  username text,
  score bigint,
  total_answer_ms bigint,
  games bigint
)
language sql stable security definer set search_path = ''
as $$
  with zbir as (
    select p.user_id,
           sum(p.score)::bigint as score,
           sum(p.total_answer_ms)::bigint as total_answer_ms,
           count(*)::bigint as games
    from public.plays p
    where p.status = 'finished'
      and p.leaderboard_status = 'counted'
      and p.user_id is not null
      and (p_from is null or p.quiz_date >= p_from)
      and (p_to is null or p.quiz_date <= p_to)
    group by p.user_id
  ),
  rangirano as (
    select rank() over (order by z.score desc, z.total_answer_ms asc) as rank,
           z.user_id, pr.username, z.score, z.total_answer_ms, z.games
    from zbir z
    join public.profiles pr on pr.id = z.user_id
    where pr.username is not null
  )
  select r.rank, r.user_id, r.username, r.score, r.total_answer_ms, r.games
  from rangirano r
  where r.rank <= least(greatest(coalesce(p_limit, 50), 1), 200)
     or r.user_id = p_user
  order by r.rank, r.username;
$$;

-- ───────────────────────── Prava ─────────────────────────

revoke all on function public.handle_new_user() from public, anon, authenticated;
revoke all on function public.handle_user_confirmed() from public, anon, authenticated;
revoke all on function public.is_admin() from public, anon;
grant execute on function public.is_admin() to authenticated;
grant execute on function public.username_available(text) to anon, authenticated;
grant execute on function public.leaderboard(date, date, integer, uuid) to anon, authenticated;
