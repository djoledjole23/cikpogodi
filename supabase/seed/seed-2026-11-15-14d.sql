-- Čik Pogodi! seed: 14 dana od 2026-11-15. Cenovnik od 2026-11-20.
-- Napravljeno komandom: npm run seed -- 2026-11-15 14

-- Isto što i migracije 0004 i 0005: ponovljeno ovde da seed radi i ako one nisu puštene.
create table if not exists public.film_stills (
  id bigint generated always as identity primary key,
  film_id bigint not null references public.films (id) on delete cascade,
  image_url text not null unique,
  note text,
  created_at timestamptz not null default now()
);
alter table public.film_stills enable row level security;
create unique index if not exists films_title_idx on public.films (title);
drop policy if exists "katalog filmova je javan" on public.films;
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
alter table public.joker_questions enable row level security;
alter table public.joker_questions add column if not exists question_image_url text;
alter table public.daily_quiz_items add column if not exists film_still_id bigint references public.film_stills (id);
alter table public.daily_quiz_items add column if not exists joker_id bigint references public.joker_questions (id);
alter table public.daily_quiz_items drop constraint if exists stavka_odgovara_segmentu;
alter table public.daily_quiz_items add constraint stavka_odgovara_segmentu check (
  num_nonnulls(song_id, product_id, trend_pair_id, film_clip_id, film_still_id, rebus_id, joker_id) = 1
  and ((segment = 1 and song_id is not null) or (segment = 2 and product_id is not null) or (segment = 3 and trend_pair_id is not null)
    or (segment = 4 and (film_clip_id is not null or film_still_id is not null)) or (segment = 5 and (rebus_id is not null or joker_id is not null)))
);

-- Isto što i migracija 0003: ponovljeno ovde da seed radi i ako ona nije puštena.
alter table public.songs add column if not exists genre text;
alter table public.play_answers add column if not exists playing_since timestamptz;

-- Katalog pesama (songs.json). Postojeće se osvežavaju po Deezer ID-u.
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Ceca', 'Kukavica', '{}'::text[], 4100565851, 6781846676, 'https://cdn-images.dzcdn.net/images/cover/f2759717a185d0d126ec4ddcca8fbe89/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Tanja Savić', 'Tako mlada', '{}'::text[], 3577739411, 1578130745, 'https://cdn-images.dzcdn.net/images/cover/7f737d4d72ee6e7eca098fc04879a06a/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Ceca', 'Beograd', '{}'::text[], 3918486731, 897490637, 'https://cdn-images.dzcdn.net/images/cover/7a4bbba6ddbc251eb2e4fec99da317db/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Aca Lukas', 'Kuda idu ljudi kao ja', '{}'::text[], 898922622, 1794183990, 'https://cdn-images.dzcdn.net/images/cover/1586b6461b881d4fdbb6f159414f2926/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Indira Radić', 'Zmaj', '{}'::text[], 1530384162, 1578094304, 'https://cdn-images.dzcdn.net/images/cover/56ac6941cc780e278c465c7eb0c3afef/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Ana Nikolić', 'Romale, romali', '{}'::text[], 529454551, 1863649027, 'https://cdn-images.dzcdn.net/images/cover/fbf4b170d50755cf14a9962c907c550b/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Milica Pavlović', 'Tango', '{}'::text[], 3577739961, 1578109034, 'https://cdn-images.dzcdn.net/images/cover/7f737d4d72ee6e7eca098fc04879a06a/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Tea Tairović', 'Hajde', '{}'::text[], 3769786922, 1868457590, 'https://cdn-images.dzcdn.net/images/cover/996740b19e3858696a09c2476d5b273e/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Van Gogh', 'Neko te ima', '{}'::text[], 416407382, 1295901266, 'https://cdn-images.dzcdn.net/images/cover/d3d29c706cb790d1d8d012a70cc7e88d/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Van Gogh', 'Za godine tvoje', '{}'::text[], 416410952, 1296178804, 'https://cdn-images.dzcdn.net/images/cover/66b0517f8a4e19b9ce7d99b49243700a/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Riblja Čorba', 'Ostani đubre do kraja', '{}'::text[], 3112807371, 1708114196, 'https://cdn-images.dzcdn.net/images/cover/4f01059cab768911ce47ec33dc0f9e82/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Bajaga i Instruktori', 'Godine prolaze', '{}'::text[], 2619831532, null, 'https://cdn-images.dzcdn.net/images/cover/876f6e3b5a47da8258356260596a69ab/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Neverne Bebe', 'Dvoje', '{}'::text[], 1246526562, 1553971637, 'https://cdn-images.dzcdn.net/images/cover/7efd9db31e140595b23ee660d7f90dbf/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Negative', 'Ja bih te sanjala', '{}'::text[], 1097617292, 342452460, 'https://cdn-images.dzcdn.net/images/cover/6a24c1d12b8ad6b3b2a1d0f61d9f99f5/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Osvajači', 'Možda nebo zna', '{}'::text[], 91190723, 1361362425, 'https://cdn-images.dzcdn.net/images/cover/3405b159010872ae2842ace1ca1a03b4/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Đorđe Balašević', 'Ringišpil', '{}'::text[], 775360092, 1483596245, 'https://cdn-images.dzcdn.net/images/cover/ff2ba6e22337997fd05523f46015b15e/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Željko Joksimović', 'Lane moje', '{}'::text[], 543692512, 1534307934, 'https://cdn-images.dzcdn.net/images/cover/256eae96a498483a488a87f6aceb2339/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Marija Šerifović', 'Molitva', '{}'::text[], 1841884507, 1578027079, 'https://cdn-images.dzcdn.net/images/cover/e095600104ae7adc6560384c44e74e7a/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Toše Proeski', 'Igra bez granica', '{}'::text[], 529457751, 1578045026, 'https://cdn-images.dzcdn.net/images/cover/14e51589c6a8b335d1eb35a8ce48855d/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Vlado Georgiev', 'Anđele', '{}'::text[], 3735395272, 1863655384, 'https://cdn-images.dzcdn.net/images/cover/86e118efbbf40f163867d2899a62f09e/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Flamingosi', 'Ludi letnji ples', '{}'::text[], 529456911, 1578005436, 'https://cdn-images.dzcdn.net/images/cover/0c19f0a49425d3c1b48a3a9a2144b966/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Severina', 'Gas, gas', '{}'::text[], 66239087, null, 'https://cdn-images.dzcdn.net/images/cover/b05932fbca6d5492ec27197ed2b84c38/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Colonia', 'Za tvoje snene oči', array['Za tvoje snene oci']::text[], 3524461661, 380344238, 'https://cdn-images.dzcdn.net/images/cover/03e11f678a397ae09f824831141f31ec/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Knez', 'Dal'' si ikada mene voljela', array['Da li si ikada mene voljela', 'Dal si ikada mene volela']::text[], 569467032, 1779524665, 'https://cdn-images.dzcdn.net/images/cover/d2e8819830c005d290436ff45cd3e100/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Nataša Bekvalac', 'Nikotin', '{}'::text[], 572082382, 1578038327, 'https://cdn-images.dzcdn.net/images/cover/133979e36499dff7b58ad7a2cb7c4fec/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jelena Rozga', 'Bižuterija', '{}'::text[], 719863962, 488074409, 'https://cdn-images.dzcdn.net/images/cover/4c05862d7a15651ad52d513ddf6689c7/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Senidah', 'Slađana', '{}'::text[], 1448120402, 1358425136, 'https://cdn-images.dzcdn.net/images/cover/5ef77d9cff1c57cd4e78b7f05889d9e3/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Elitni Odredi', 'Ne koči', '{}'::text[], 367409741, 1578161233, 'https://cdn-images.dzcdn.net/images/cover/803813f492547a845a0e773fe5a18f87/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jala Brat & Buba Corelli', 'Ona''e', array['Ona e']::text[], 2826274332, 1869454361, 'https://cdn-images.dzcdn.net/images/cover/30b661dc562993894dbfbb5ce318fd4c/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jala Brat, Buba Corelli & Devito', 'Roze', '{}'::text[], 2826469112, 1869458408, 'https://cdn-images.dzcdn.net/images/cover/72997513f3c5926f05168759909990f4/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jala Brat, Buba Corelli & Rasta', 'Benga po snijegu', array['Benga po snegu']::text[], 2826274312, 1869456476, 'https://cdn-images.dzcdn.net/images/cover/30b661dc562993894dbfbb5ce318fd4c/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Rasta', 'Hotel', '{}'::text[], 2874735722, 1755400371, 'https://cdn-images.dzcdn.net/images/cover/9909b68e9509fb11a3e9ab7fc7e61ebe/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Voyage', 'Euforija', '{}'::text[], 1524834902, 1590822353, 'https://cdn-images.dzcdn.net/images/cover/3e2caab42106c745671878d679678914/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jala Brat', 'Mlada i luda', '{}'::text[], 2826870432, 1869456199, 'https://cdn-images.dzcdn.net/images/cover/7f75828e945cf7d96394cc16b5d8c33e/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Partibrejkers', 'Hoću da znam', '{}'::text[], 584345352, 1057660792, 'https://cdn-images.dzcdn.net/images/cover/0e25a548d7ed6531a0b1b943c1b9102a/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Električni Orgazam', 'Igra rok''en''rol cela Jugoslavija', array['Igra rokenrol cela Jugoslavija', 'Igra rock and roll cela Jugoslavija', 'Igra rock''n''roll cela Jugoslavija', 'Igra rok end rol cela Jugoslavija']::text[], 2997909791, 381727354, 'https://cdn-images.dzcdn.net/images/cover/a1daef37893c7371a79c1d084a8aed13/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Ekatarina Velika', 'Par godina za nas', '{}'::text[], 2178288577, 1676062744, 'https://cdn-images.dzcdn.net/images/cover/c9f573b1c326b7612b65ba29b18b9830/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('YU Grupa', 'Crni leptir', '{}'::text[], 93131256, 1768883648, 'https://cdn-images.dzcdn.net/images/cover/da08dde9b45fcf2e04473f0329dd68a9/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Galija', 'Dodirni me', '{}'::text[], 1029768162, 1524533589, 'https://cdn-images.dzcdn.net/images/cover/90332e72f902bd26deb0a195ea735fd6/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Piloti', 'Kao ptica na mom dlanu', '{}'::text[], 2136800977, 1670154957, 'https://cdn-images.dzcdn.net/images/cover/07892c80eee21cb133e03743ea56da54/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Smak', 'Crna dama', '{}'::text[], 1189113242, 1673511045, 'https://cdn-images.dzcdn.net/images/cover/d551c7f7f3e9738741cafa9dd69e695f/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Generacija 5', 'Dolazim za pet minuta', array['Dolazim za 5 minuta']::text[], 3194092551, 1665669373, 'https://cdn-images.dzcdn.net/images/cover/54c6ff4a139c08aa9f1f44df9ef0911e/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Idoli', 'Maljčiki', '{}'::text[], 23797711, 385266437, 'https://cdn-images.dzcdn.net/images/cover/2081e7a65262a095d8c3296e572b4bb6/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Riblja Čorba', 'Lutka sa naslovne strane', '{}'::text[], 2464031485, 1708115106, 'https://cdn-images.dzcdn.net/images/cover/a75eb24f5925b3374a9e44f3236ba53f/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Bajaga i Instruktori', 'Moji drugovi', '{}'::text[], 2619832862, null, 'https://cdn-images.dzcdn.net/images/cover/97755b9dade374e5265ec215db465e81/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Ekatarina Velika', 'Krug', '{}'::text[], 2178288537, 1676062737, 'https://cdn-images.dzcdn.net/images/cover/c9f573b1c326b7612b65ba29b18b9830/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Električni Orgazam', 'Bejbe, ti nisi tu', '{}'::text[], 2997909771, 505135793, 'https://cdn-images.dzcdn.net/images/cover/a1daef37893c7371a79c1d084a8aed13/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Partibrejkers', 'Kreni prema meni', '{}'::text[], 3059311951, 593942049, 'https://cdn-images.dzcdn.net/images/cover/f435aa3327ce69c3eef695aff519dd7f/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Kerber', 'Seobe', '{}'::text[], 1523410982, 1590828710, 'https://cdn-images.dzcdn.net/images/cover/8f5c589408e426f6b63cd14ca4a8f292/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Galija', 'Još uvek sanjam', '{}'::text[], 1029767952, 1524533481, 'https://cdn-images.dzcdn.net/images/cover/90332e72f902bd26deb0a195ea735fd6/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Piloti', 'Ne veruj u idole', '{}'::text[], 3020679851, null, 'https://cdn-images.dzcdn.net/images/cover/580fc7b2b1ba75ed6afd50b21390245b/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Riblja Čorba', 'Dva dinara, druže', array['2 dinara druže']::text[], 3030816441, 1772667606, 'https://cdn-images.dzcdn.net/images/cover/fa409f8b415268365a412f2758797489/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Bajaga i Instruktori', 'Tišina', '{}'::text[], 3265454081, null, 'https://cdn-images.dzcdn.net/images/cover/773908c4ad7bd859a9fd036880c16a28/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Đorđe Balašević', 'Ne lomite mi bagrenje', '{}'::text[], 3933464011, 1885963818, 'https://cdn-images.dzcdn.net/images/cover/9fed900e0042c875191498d5383ec431/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Đorđe Balašević', 'Priča o Vasi Ladačkom', '{}'::text[], 3933438781, 1885825448, 'https://cdn-images.dzcdn.net/images/cover/e79b6ef15974e508aab915a4716cbb5a/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('S.A.R.S.', 'Buđav lebac', '{}'::text[], 448254092, 1479062927, 'https://cdn-images.dzcdn.net/images/cover/0522fedf82e39c9c56644c5c1c35c403/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('S.A.R.S.', 'Perspektiva', '{}'::text[], 448247912, 1479062918, 'https://cdn-images.dzcdn.net/images/cover/b5c7bf612232dd7a5d0165fc4c2abc58/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Laki Pingvini', 'Šizika', '{}'::text[], 2534294791, 1730957841, 'https://cdn-images.dzcdn.net/images/cover/56504dc3f81ed06b9b272eaab5fdfbb1/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('U Škripcu', 'Siđi do reke', '{}'::text[], 93538110, 555295020, 'https://cdn-images.dzcdn.net/images/cover/da3456422c95889d66d3ad006091172e/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Poslednja Igra Leptira', 'Nataša', '{}'::text[], 70302746, 694066456, 'https://cdn-images.dzcdn.net/images/cover/2f30ddb6cdf8a3839ed062a834608244/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Zana', 'Dodirni mi kolena', '{}'::text[], 67370135, 537208928, 'https://cdn-images.dzcdn.net/images/cover/0ea70a53d6cc08c156d3fea88e09299d/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Babe', 'Noć bez sna', '{}'::text[], 1097594332, 676766334, 'https://cdn-images.dzcdn.net/images/cover/95ab8f39e8cf7c9d010c9e247df02893/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Dejan Cukić', 'Ruža ispod pepela', '{}'::text[], 3314918891, 1812622351, 'https://cdn-images.dzcdn.net/images/cover/fd85e9d6799380a9d7f69973d1e46dcd/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Goblini', 'Daleki put', '{}'::text[], 591698172, 1276248247, 'https://cdn-images.dzcdn.net/images/cover/fb53e64a3602ced0726e63517463852a/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Rambo Amadeus', 'Balkan boj', '{}'::text[], 3200983881, 1792096613, 'https://cdn-images.dzcdn.net/images/cover/692a2d9d46134a262bfd5f049480499d/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('YU Grupa', 'Čudna šuma', '{}'::text[], 93131246, 507745455, 'https://cdn-images.dzcdn.net/images/cover/da08dde9b45fcf2e04473f0329dd68a9/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Smak', 'Daire', '{}'::text[], 1189113232, 1673511043, 'https://cdn-images.dzcdn.net/images/cover/d551c7f7f3e9738741cafa9dd69e695f/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Van Gogh', 'Klatno', '{}'::text[], 416410242, 1295930977, 'https://cdn-images.dzcdn.net/images/cover/61d3ba6e2992d5d906b999483ef4d241/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Neverne Bebe', 'Tužna pesma', '{}'::text[], 1246517092, 1553970758, 'https://cdn-images.dzcdn.net/images/cover/a6d5e2d1f411726c802b77481f5570ef/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Bajaga i Instruktori', 'Verujem, ne verujem', '{}'::text[], 2619831592, null, 'https://cdn-images.dzcdn.net/images/cover/876f6e3b5a47da8258356260596a69ab/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Riblja Čorba', 'Kad hodaš', '{}'::text[], 93808806, 555300330, 'https://cdn-images.dzcdn.net/images/cover/a57f6bccd03536f95bcf75fc1bd4bd84/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Zana', 'Vejte snegovi', '{}'::text[], 3084062441, 1778693977, 'https://cdn-images.dzcdn.net/images/cover/3d8ddab6e5bdf73d549723a9e43ee125/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Lepa Brena', 'Jugoslovenka', '{}'::text[], 995385502, 1573972496, 'https://cdn-images.dzcdn.net/images/cover/556f4f80e7caffdda0164e3f06ccff3e/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Lepa Brena', 'Luda za tobom', '{}'::text[], 1056591462, 1578099903, 'https://cdn-images.dzcdn.net/images/cover/760738cd4fe6b8693c7ad03772a8db96/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Dragana Mirković', 'Pitaju me u mom kraju', '{}'::text[], 77542252, 1589525198, 'https://cdn-images.dzcdn.net/images/cover/78c492ee9ab9e928e71f9c908df05d4e/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Dragana Mirković', 'Umirem majko', '{}'::text[], 68549735, 1589525197, 'https://cdn-images.dzcdn.net/images/cover/f8dee63048c6a4c1f3f2af406bb5ae18/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Dragana Mirković', 'Plači zemljo', '{}'::text[], 4262262541, 1530131660, 'https://cdn-images.dzcdn.net/images/cover/3b3a2d12b24a8be40862b8799614e1d1/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Šaban Šaulić', 'Dajte mi utjehu', array['Dajte mi utehu']::text[], 2160334507, 291506273, 'https://cdn-images.dzcdn.net/images/cover/fa61c937eca4bb4360b237e4f071b7d9/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Šaban Šaulić', 'Sneg je opet, Snežana', '{}'::text[], 3293842061, 1833465638, 'https://cdn-images.dzcdn.net/images/cover/5cf4e70b4164ea2a5890e28234dec13a/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Miroslav Ilić', 'Pozdravi je, pozdravi', '{}'::text[], 91192189, 288032561, 'https://cdn-images.dzcdn.net/images/cover/34c97f6f22dcb8417d9ed1b13856887d/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Toma Zdravković', 'Dotak''o sam dno života', array['Dotakao sam dno života']::text[], 4365851661, 6825577391, 'https://cdn-images.dzcdn.net/images/cover/7b454ec0c776dab98843ea8bd2cb84ab/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Toma Zdravković', 'Prokleta nedelja', '{}'::text[], 3018160881, 394761867, 'https://cdn-images.dzcdn.net/images/cover/ca521a03603fba6017d7d1f21ff5bb6b/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Džej Ramadanovski', 'Nedelja', '{}'::text[], 75897511, 814036745, 'https://cdn-images.dzcdn.net/images/cover/66c50084acefb4789eb7e05595bfb910/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Džej Ramadanovski', 'Upalite za mnom sveće', array['Upalite za mnom svijeće']::text[], 3538539621, 1787133566, 'https://cdn-images.dzcdn.net/images/cover/6eaadab518195ebd3b64a865049cbbbe/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Sinan Sakić', 'Ej, od kad sam se rodio', '{}'::text[], 1302228482, 1738171628, 'https://cdn-images.dzcdn.net/images/cover/21ae99ba2b4baeb63160ca7203c78457/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Sinan Sakić', 'Lepa do bola', '{}'::text[], 1148816532, 1541356044, 'https://cdn-images.dzcdn.net/images/cover/d18891c57626dc413055ba40cde08701/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Mile Kitić', 'Kilo dole, kilo gore', '{}'::text[], 1820167077, 1633892109, 'https://cdn-images.dzcdn.net/images/cover/adee76b22456817d1863183121472e70/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Mile Kitić', 'Šampanjac', '{}'::text[], 458533222, 1578107934, 'https://cdn-images.dzcdn.net/images/cover/082ecbf653a76b56346640f914ab5d20/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Vesna Zmijanac', 'Idem preko zemlje Srbije', '{}'::text[], 1070199542, 1530116401, 'https://cdn-images.dzcdn.net/images/cover/e3e1493645800a176ebb64ce25626611/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Seka Aleksić', 'Aspirin', '{}'::text[], 458482352, 1578124263, 'https://cdn-images.dzcdn.net/images/cover/e689a5661c96ae9c94a004955ef1e142/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Seka Aleksić', 'Crno i zlatno', '{}'::text[], 457443222, 1578124264, 'https://cdn-images.dzcdn.net/images/cover/6ba4ec894e23d258d4ffceba74aa6135/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Stoja', 'Evropa', '{}'::text[], 3515146491, 1834143575, 'https://cdn-images.dzcdn.net/images/cover/4d6ab6c1df27a2b5f700554549ecb360/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Dara Bubamara', 'Kraj i tačka', '{}'::text[], 76953700, 853807117, 'https://cdn-images.dzcdn.net/images/cover/39969f9ae6ee3e7e45b3504aaa96e5dc/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Aco Pejović', 'Jelena', '{}'::text[], 1070202102, 1578077479, 'https://cdn-images.dzcdn.net/images/cover/baa426af2590acf757d71dbaf70e931d/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Darko Lazić', 'Godinu dana 300 kafana', array['Godinu dana trista kafana']::text[], 3364966471, 1578085998, 'https://cdn-images.dzcdn.net/images/cover/c60e8d6d629589dd4127f975dec3ea9b/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Aca Lukas', 'Lična karta', '{}'::text[], 898922532, 893132307, 'https://cdn-images.dzcdn.net/images/cover/1586b6461b881d4fdbb6f159414f2926/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Saša Matić', 'Kralj izgubljenih stvari', '{}'::text[], 458531552, 1578121642, 'https://cdn-images.dzcdn.net/images/cover/05f89d971445de93c26a2ab7981c0864/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Boban Rajović', 'Usne boje vina', '{}'::text[], 1097490802, 1577984193, 'https://cdn-images.dzcdn.net/images/cover/3d2467e404000ce8672df185747ce77e/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Aleksandra Prijović', 'Dam dam dam', '{}'::text[], 2342297565, 1694278577, 'https://cdn-images.dzcdn.net/images/cover/9c3baeb9c3252c493bea73402bc8ba9b/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Aleksandra Prijović', 'Za nas kasno je', '{}'::text[], 2727125451, 1741510715, 'https://cdn-images.dzcdn.net/images/cover/3da89f7f3ae4fd006211f84edfa9ff1e/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Milica Todorović', 'Tri čaše', '{}'::text[], 464556372, 1578147923, 'https://cdn-images.dzcdn.net/images/cover/70f9546a52fbbe77edd2a85c8727f13a/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Lexington', 'Dobro da nije veće zlo', '{}'::text[], 583784202, 1578010629, 'https://cdn-images.dzcdn.net/images/cover/1e9ef340a9b56b96d2d3b4b7d21e84f7/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Predrag Živković Tozovac', 'Ti si me čekala', '{}'::text[], 464301082, 1578117640, 'https://cdn-images.dzcdn.net/images/cover/d9d487933ca0a65e897d22661c291fd6/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Mitar Mirić', 'Ne može nam niko ništa', '{}'::text[], 15620002, 1877161517, 'https://cdn-images.dzcdn.net/images/cover/d72ac926caf3ca020cd716b445803900/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Ana Bekuta', 'Kralj ponoći', '{}'::text[], 473686002, 1618909883, 'https://cdn-images.dzcdn.net/images/cover/1197780efc4c44c6729adace6872d7eb/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Zorica Brunclik', 'A tebe nema', '{}'::text[], 1267209572, 1785561136, 'https://cdn-images.dzcdn.net/images/cover/dd714c76af7b5a1a51369b0b5ec826ba/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Rada Manojlović', 'Deset ispod nule', '{}'::text[], 3577739451, 1578117495, 'https://cdn-images.dzcdn.net/images/cover/7f737d4d72ee6e7eca098fc04879a06a/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Lepa Lukić', 'Srce je moje violina', '{}'::text[], 1578104222, 1598866554, 'https://cdn-images.dzcdn.net/images/cover/d57da09e8c6bc94c2ee0e825a77b4b4d/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Ceca', 'Pile', '{}'::text[], 1556613902, 1596088430, 'https://cdn-images.dzcdn.net/images/cover/1213cb13846dfb0e563b1c60ee4c9e72/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jana', 'Barabar', '{}'::text[], 464318182, 1578095472, 'https://cdn-images.dzcdn.net/images/cover/04c0112ae74703f7b22a47a7947ed328/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Marinko Rokvić', 'Skitnica', '{}'::text[], 457472742, 1578103918, 'https://cdn-images.dzcdn.net/images/cover/c15764ffa29dac54fd413a6aa45cbf6d/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Tanja Savić', 'Zlatnik', '{}'::text[], 458499192, 1578131360, 'https://cdn-images.dzcdn.net/images/cover/f0833cd7fc029ab13b6553b9069dceaf/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Indira Radić', 'Lopov', '{}'::text[], 1530383982, 1591493897, 'https://cdn-images.dzcdn.net/images/cover/50604a8c23db2078d29ecc7cb8a99b6c/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Ana Nikolić', 'Januar', '{}'::text[], 1343464422, 1577973781, 'https://cdn-images.dzcdn.net/images/cover/f9e7a4a974257a417b5827536cdc3238/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Zdravko Čolić', 'Ti si mi u krvi', '{}'::text[], 2617677792, 1768453720, 'https://cdn-images.dzcdn.net/images/cover/bf26d15f675db78c90d435621f94d88b/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Zdravko Čolić', 'Pusti, pusti modu', '{}'::text[], 3873062881, 1768453459, 'https://cdn-images.dzcdn.net/images/cover/d583b7a39e792bee9e271a46ee4be9aa/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Zdravko Čolić', 'Jedina', '{}'::text[], 2995450631, 1768453462, 'https://cdn-images.dzcdn.net/images/cover/6ea8f083fd4774d807baf0eb2eb30db2/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Željko Joksimović', 'Ljubavi', '{}'::text[], 543692302, 1578062227, 'https://cdn-images.dzcdn.net/images/cover/256eae96a498483a488a87f6aceb2339/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Aleksandra Radović', 'Čuvam te', '{}'::text[], 724771892, 1577968457, 'https://cdn-images.dzcdn.net/images/cover/c5fc18b55056ab0e7eaf24497bff3520/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jelena Tomašević', 'Oro', '{}'::text[], 548422182, 1578004843, 'https://cdn-images.dzcdn.net/images/cover/cef8b42cbd09b82220ea7aa687ff3d10/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Oliver Mandić', 'Poludeću', '{}'::text[], 669667832, 1578033120, 'https://cdn-images.dzcdn.net/images/cover/98507abe8cc3f9c8128a23af891a1790/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Goca Tržan', 'Gluve usne', '{}'::text[], 900803272, 1502376359, 'https://cdn-images.dzcdn.net/images/cover/2c37b562f9464b831107a70c611cb69e/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Tijana Dapčević', 'Sve je isto, samo njega nema', array['Sve je isto samo njega nema']::text[], 669816782, 1578048136, 'https://cdn-images.dzcdn.net/images/cover/0f63522949f5600757c9685fae420efd/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Saša Kovačević', 'Slučajno', '{}'::text[], 3265960921, 1800492251, 'https://cdn-images.dzcdn.net/images/cover/4c260d27762770c4c6b020f7baea355a/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Sara Jo', 'Mili, mili', '{}'::text[], 1458276022, 1485997194, 'https://cdn-images.dzcdn.net/images/cover/5c32fe082b74da88e2f70874158a7434/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Konstrakta', 'In corpore sano', '{}'::text[], 1655110372, 1610103739, 'https://cdn-images.dzcdn.net/images/cover/fee2ed6185e41649eaa2382f0c076bf7/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Teya Dora', 'Džanum', '{}'::text[], 2393291385, 1700644621, 'https://cdn-images.dzcdn.net/images/cover/87aa5284a23bc8622f2fd44364454975/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Đogani', 'Idemo na Mars', '{}'::text[], 1524827632, 1578052439, 'https://cdn-images.dzcdn.net/images/cover/319281deac498cf8a51f7b5aae08f326/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Funky G', 'Robinja', '{}'::text[], 3251372211, 1798518554, 'https://cdn-images.dzcdn.net/images/cover/350b80d5b91c0d49b05d7c52ce3ef666/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Moby Dick', 'Kralj kokaina', '{}'::text[], 548427902, 1578023151, 'https://cdn-images.dzcdn.net/images/cover/645cd417def96b94009c112cc520cc26/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Nataša Bekvalac', 'Dobro moje', '{}'::text[], 543688932, 1578025575, 'https://cdn-images.dzcdn.net/images/cover/953fbf662c9e1503c278933273640980/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Ministarke', 'Moje jedino', '{}'::text[], 136282042, 1177057642, 'https://cdn-images.dzcdn.net/images/cover/5aeea2ec7785de8477ddd10c2a4bd86c/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Emina Jahović', 'Da l'' ona zna', array['Da li ona zna']::text[], 529455441, 1578000002, 'https://cdn-images.dzcdn.net/images/cover/9b8f2e85f1699b9c3f2bb6400be9322f/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Željko Samardžić', 'Grlica', '{}'::text[], 730630702, 1690799736, 'https://cdn-images.dzcdn.net/images/cover/5710206419be4921023ac329d20c707b/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Željko Samardžić', '9000 metara', array['Devet hiljada metara']::text[], 458468242, 1578134286, 'https://cdn-images.dzcdn.net/images/cover/bd90f01cb0edb6a944408d7ab9361916/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Hurricane', 'Hasta la vista', '{}'::text[], 1403811522, 1572121158, 'https://cdn-images.dzcdn.net/images/cover/e91792489b4e003791b884abf6c3c185/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Daniel Popović', 'Džuli', '{}'::text[], 994777892, 381023337, 'https://cdn-images.dzcdn.net/images/cover/daaefcbea471f512871fe4f85e3b2531/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jelena Rozga', 'Nirvana', '{}'::text[], 2998009921, 632120047, 'https://cdn-images.dzcdn.net/images/cover/4b108ec75e2bd830d4f5552c36d17ded/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Severina', 'Italiana', '{}'::text[], 71437750, null, 'https://cdn-images.dzcdn.net/images/cover/31e88f73ba6d1ac2c29c8d7842cba3a3/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Colonia', 'Plamen od ljubavi', '{}'::text[], 3524465801, 380344263, 'https://cdn-images.dzcdn.net/images/cover/b4ccb8ec7fa8f2febc8ef4e1b1793065/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Toše Proeski', 'Pratim te', '{}'::text[], 543699482, 1578045655, 'https://cdn-images.dzcdn.net/images/cover/84330e650a3a382fec6bd5ab1936ac5e/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Coby', '4 strane sveta', array['Četiri strane sveta', '4 strane svijeta']::text[], 1458266602, 1435760145, 'https://cdn-images.dzcdn.net/images/cover/5cfa9258bbc81832dce1aa8f594725d7/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Relja Popović', 'Beograd još živi', '{}'::text[], 98406320, 1578173181, 'https://cdn-images.dzcdn.net/images/cover/278bbf48fa085c240589163f55ba0ae8/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Nikolija', 'Ćao zdravo', '{}'::text[], 3585357191, 1843876410, 'https://cdn-images.dzcdn.net/images/cover/f157da565f7decc3d4a773857aef0061/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Nikolija', 'Opasna igra', '{}'::text[], 3585357171, 1578171020, 'https://cdn-images.dzcdn.net/images/cover/f157da565f7decc3d4a773857aef0061/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Elitni Odredi', 'Kao kokain', '{}'::text[], 1151090292, 1578161009, 'https://cdn-images.dzcdn.net/images/cover/dd0ca35fe681011e1f9884404d488ac3/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Voyage & Breskvica', 'Budi tu', '{}'::text[], 3026502121, 1770864844, 'https://cdn-images.dzcdn.net/images/cover/e26a759066d37ce15e40bade657a5020/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Maya Berović', 'Harem', '{}'::text[], 548432642, 1578019371, 'https://cdn-images.dzcdn.net/images/cover/2a04ba540fe6348ce1e56b0eb81ab139/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Maya Berović', 'Alkohol', '{}'::text[], 589360692, 1590557416, 'https://cdn-images.dzcdn.net/images/cover/a979017e7973f894c16e3b2b9c612fae/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Gru', 'Biću tu', array['Bicu tu']::text[], 541941912, 1577997709, 'https://cdn-images.dzcdn.net/images/cover/1956dc7fb50cd5a835ff2f7be41ccebd/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Bad Copy', 'Uno due tre', '{}'::text[], 3259803621, null, 'https://cdn-images.dzcdn.net/images/cover/d016ccf63f7b59d5085da70e19936678/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Beogradski Sindikat', 'Balada disidenta', '{}'::text[], 1621917272, null, 'https://cdn-images.dzcdn.net/images/cover/60e3ad80c9381a32abecf019afb0f07b/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Marčelo', 'Pegla', '{}'::text[], 126398043, 1122634973, 'https://cdn-images.dzcdn.net/images/cover/aec32e8015c2b22615ba2d97a2c6ac3b/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Sunshine', 'Kokane', '{}'::text[], 74220640, 1591697553, 'https://cdn-images.dzcdn.net/images/cover/addfca3b309c6ea81ad769b448f00cca/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Rasta', 'Kavasaki', '{}'::text[], 2874736532, null, 'https://cdn-images.dzcdn.net/images/cover/7c21ac45103f62c74a981e9860f0a2f3/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Rasta', 'Indigo', '{}'::text[], 2892599012, 1757705036, 'https://cdn-images.dzcdn.net/images/cover/aa81fefaa79bae1dd7d9648d9d62363d/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Senidah', 'Mišići', '{}'::text[], 3746732432, 1865193687, 'https://cdn-images.dzcdn.net/images/cover/fdfe462880f608273af5d73eb8fdbd92/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Senidah', 'Behute', '{}'::text[], 1638064402, 1607524195, 'https://cdn-images.dzcdn.net/images/cover/93b6ff1e82ee0b56b201d4ad2ef0927c/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Zera', 'Do zore', '{}'::text[], 3026486831, 1770861279, 'https://cdn-images.dzcdn.net/images/cover/05dfbd23035df9e4e29b751e2444618e/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Teodora', 'Voli me, voli me', '{}'::text[], 1337899422, 1578179364, 'https://cdn-images.dzcdn.net/images/cover/53e871ea0321a0b3806556170a0b3209/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Mimi Mercedez', 'Kleopatra', '{}'::text[], 3304073171, null, 'https://cdn-images.dzcdn.net/images/cover/7baea02c4635231c7e7abdf66bd1be9f/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Buba Corelli', 'Balenciaga', '{}'::text[], 2826423592, 1869456343, 'https://cdn-images.dzcdn.net/images/cover/755122dbe831587019a0ff9596c38b31/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jala Brat & Buba Corelli', 'Mafia', '{}'::text[], 2826823872, 1869456254, 'https://cdn-images.dzcdn.net/images/cover/8f8ead150449d7d5584b476495cecfd9/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jala Brat & Buba Corelli', 'Bebi', '{}'::text[], 2826174002, 1869456289, 'https://cdn-images.dzcdn.net/images/cover/d14e310fd4bb091763d1b31f2cddc4c7/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Elena', 'Geto princeza', '{}'::text[], 2874736332, null, 'https://cdn-images.dzcdn.net/images/cover/68eef0cddd4de7acc5fdfee9a3c2f959/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Breskvica', 'Gnezdo orlovo', '{}'::text[], 2633403092, 1727602018, 'https://cdn-images.dzcdn.net/images/cover/4906bdcdd71f3d9ba01b45bd06a5101e/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Devito', 'Koketa', '{}'::text[], 2726833681, 1738427786, 'https://cdn-images.dzcdn.net/images/cover/c1c980c19dfa3b5ec31e3e5d17547fa2/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Vojko V', 'Cilit beng', '{}'::text[], 3014936831, 1770357348, 'https://cdn-images.dzcdn.net/images/cover/292d45122560e4b10bc93afbecacdaa3/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Vojko V', 'Ceca u Parizu', '{}'::text[], 3014936821, 1756902379, 'https://cdn-images.dzcdn.net/images/cover/292d45122560e4b10bc93afbecacdaa3/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Senidah', 'Lanci ljubavi', '{}'::text[], 3247527591, 1798182832, 'https://cdn-images.dzcdn.net/images/cover/66d7789a8e8cd17460edc261d335108c/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Buba Corelli', 'Irina shayk', '{}'::text[], 2826320292, 1869458438, 'https://cdn-images.dzcdn.net/images/cover/4761914e79b106659915fb3cdfa44860/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Coby', 'Mami', '{}'::text[], 529249221, 1578156912, 'https://cdn-images.dzcdn.net/images/cover/e7abcf6f71690ed5cf5356617f695f1e/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Voyage', 'Tango', '{}'::text[], 1785220827, 1628769460, 'https://cdn-images.dzcdn.net/images/cover/f378a23191c6debe79936209fb386c19/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Nikolija', 'Afera', '{}'::text[], 3295650701, 1804573103, 'https://cdn-images.dzcdn.net/images/cover/a622900d163f3e82ad4740af8f1f7941/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Zera', 'Iz subote u petak', '{}'::text[], 3026514961, 1770863637, 'https://cdn-images.dzcdn.net/images/cover/5f54d16fe53c8624a0aed2b93587a4e3/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Desingerica', 'Ccokolada', '{}'::text[], 2537395271, null, 'https://cdn-images.dzcdn.net/images/cover/0364cb84dd6c297a070c2ff4a1666885/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Sajsi MC', 'Meni se ne udaje', '{}'::text[], 733177412, 1578174378, 'https://cdn-images.dzcdn.net/images/cover/0fd5d2899f5868ed3912e7b7d87827e9/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Fox', 'Med i mleko', '{}'::text[], 1831254437, 1635394397, 'https://cdn-images.dzcdn.net/images/cover/4487b1d0eee64f72f820274400985d53/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Teodora', 'Karma', '{}'::text[], 2894937281, 1757907832, 'https://cdn-images.dzcdn.net/images/cover/82ce379f18e5ecbdfe4958c8dacc36c9/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Mimi Mercedez', 'Jača nego ikad', '{}'::text[], 1287219072, null, 'https://cdn-images.dzcdn.net/images/cover/3c702d106351cf27ff6896079424386e/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Maya Berović', 'Djevojačko prezime', '{}'::text[], 1524440122, 1590557465, 'https://cdn-images.dzcdn.net/images/cover/ac4b1783edfcbb3f1bf58eddff17e49e/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Tea Tairović', 'Bonita', '{}'::text[], 4016727801, 6768663057, 'https://cdn-images.dzcdn.net/images/cover/014f3ada4c9c543175a0ff1d51c2f609/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Henny', 'Neka neka', '{}'::text[], 4170273902, 6793555937, 'https://cdn-images.dzcdn.net/images/cover/0d3914c4246d6463943b8588d801d900/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jelena Karleuša', 'Casino', '{}'::text[], 529458471, 1578003439, 'https://cdn-images.dzcdn.net/images/cover/af89681374eb5c26655685501498c266/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jelena Karleuša', 'Gili gili', '{}'::text[], 548426692, 1578030416, 'https://cdn-images.dzcdn.net/images/cover/e700192c2c74a291b44fb7151a94cb4d/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Tony Cetinski', 'Ako to se zove ljubav', '{}'::text[], 66429248, 509534403, 'https://cdn-images.dzcdn.net/images/cover/0b959c90add736fc2cc0c9117fc7b2f5/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Nina Badrić', 'Moja ljubav', '{}'::text[], 65655353, 1422700975, 'https://cdn-images.dzcdn.net/images/cover/3c546353d7894c760714779d4d5ac761/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Doris Dragović', 'Marija magdalena', '{}'::text[], 1014394102, 1770595050, 'https://cdn-images.dzcdn.net/images/cover/7c18db702f482e6b382ef82f6638a789/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Hari Mata Hari', 'Lejla', '{}'::text[], 2155165937, 1663291933, 'https://cdn-images.dzcdn.net/images/cover/11d42f75864e2ff32856e7361194f928/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Dino Merlin', 'Kad si rekla da me voliš', '{}'::text[], 23638701, 1354468333, 'https://cdn-images.dzcdn.net/images/cover/94a89a05b683fa85f3eefc09e9a5b155/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Sergej Ćetković', 'Moje si sve', '{}'::text[], 730632182, 1578050207, 'https://cdn-images.dzcdn.net/images/cover/29538440bec932a65ae1bf6ad8ea67b7/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Magazin', 'Minus i plus', '{}'::text[], 1006925662, 488074453, 'https://cdn-images.dzcdn.net/images/cover/9382f18da0cc7fbbcbcb9ce5c80ea7b1/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Novi Fosili', 'Milena', '{}'::text[], 714874232, 382774596, 'https://cdn-images.dzcdn.net/images/cover/b4952ad09b711675c61ee10cbe4b66d4/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Vlado Georgiev', 'Bolesni od ljubavi', '{}'::text[], 3735395362, 1863655702, 'https://cdn-images.dzcdn.net/images/cover/308fdfe7a27a4ca7ab4e2785f4c8ac5c/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Marija Šerifović', 'Bol do ludila', '{}'::text[], 543705752, 1578021817, 'https://cdn-images.dzcdn.net/images/cover/a4ba12f349f6e58537ac9b90adc75ebc/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Konstrakta', 'Mekano', '{}'::text[], 3283924601, 1804422689, 'https://cdn-images.dzcdn.net/images/cover/7d79c4d331a81930390d8149681850f9/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Oliver Dragojević', 'Cesarica', '{}'::text[], 913359072, 1860043542, 'https://cdn-images.dzcdn.net/images/cover/b647ab5afc0abba741a8514db92096c1/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Tijana Dapčević', 'Ljubi mi se', '{}'::text[], 2311433625, 1578063047, 'https://cdn-images.dzcdn.net/images/cover/e5527d9e0912b335ac1e06928c56aac1/250x250-000000-80-0-0.jpg', 'pop')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Halid Bešlić', 'Miljacka', '{}'::text[], 1251889, 1745064686, 'https://cdn-images.dzcdn.net/images/cover/d290176d38d7f6fe336a43ea6d36c8d4/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Viki Miljković', 'Mariš li', '{}'::text[], 1458112122, 1578151710, 'https://cdn-images.dzcdn.net/images/cover/fae5d2666bdba41f52c2180cf71613b0/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Halid Muslimović', 'Mama ne da da te diram', '{}'::text[], 458784522, 1345323094, 'https://cdn-images.dzcdn.net/images/cover/6e0a5d3fb127ce0a0f2a20f09f63ca32/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Dženan Lončarević', 'Kosa do ramena', '{}'::text[], 548433942, 1577987690, 'https://cdn-images.dzcdn.net/images/cover/6a42211803bbb67e4ef1bbe446c62aea/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Bijelo Dugme', 'Lipe cvatu, sve je isto ko i lani', '{}'::text[], 69403518, 1534027712, 'https://cdn-images.dzcdn.net/images/cover/f757bf3ecc5d3f8472581002746cdba4/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Bijelo Dugme', 'Hajdemo u planine', '{}'::text[], 2944232721, 1534030335, 'https://cdn-images.dzcdn.net/images/cover/e3fd54413b08a6a79a54d20d5332d008/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Parni Valjak', 'Jesen u meni', '{}'::text[], 3020609441, 1805023586, 'https://cdn-images.dzcdn.net/images/cover/07cb8373f4064a1517f69937dd4b4217/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Prljavo Kazalište', 'Mi plešemo', '{}'::text[], 928567582, 1524440040, 'https://cdn-images.dzcdn.net/images/cover/99065d103e923d88404b441efbf85de6/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Plavi Orkestar', 'Bolje biti pijan nego star', '{}'::text[], 2995426691, 380612350, 'https://cdn-images.dzcdn.net/images/cover/3ace58415594894c1dc27d86bf2ef59f/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Kerber', 'Hajde da se volimo', '{}'::text[], 1523410942, 1590828706, 'https://cdn-images.dzcdn.net/images/cover/8f5c589408e426f6b63cd14ca4a8f292/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Električni Orgazam', 'Kako bubanj kaže', '{}'::text[], 23648731, 505135797, 'https://cdn-images.dzcdn.net/images/cover/1bc71d46e2635206baf4f0f648c5e4d5/250x250-000000-80-0-0.jpg', 'rok')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Jala Brat', 'Ajkula', '{}'::text[], 3991260501, 6764452931, 'https://cdn-images.dzcdn.net/images/cover/acb4e11962d9ecee31354dfb648c1124/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Elena', 'Laži', '{}'::text[], 1496970082, 1586334843, 'https://cdn-images.dzcdn.net/images/cover/f66fd83df21e9904febe66c49914546e/250x250-000000-80-0-0.jpg', 'trep')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;
insert into public.songs (artist, title, aliases, deezer_id, itunes_id, cover_url, genre)
  values ('Aca Lukas', 'Daleko si', '{}'::text[], 572081772, 1577967053, 'https://cdn-images.dzcdn.net/images/cover/3b5428512253cd36786be74b73657a25/250x250-000000-80-0-0.jpg', 'folk')
  on conflict (deezer_id) do update set artist = excluded.artist, title = excluded.title, aliases = excluded.aliases,
    itunes_id = excluded.itunes_id, cover_url = excluded.cover_url, genre = excluded.genre, active = true;

-- Dnevni kviz: segment 1 (Pogodi pesmu). Dan koji već ima stavke se ne dira.
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-15', 1, 1, id, '{"izvodjac":"Saša Matić","naslov":"Kralj izgubljenih stvari","alias":[],"deezerId":458531552,"itunesId":1578121642,"omot":"https://cdn-images.dzcdn.net/images/cover/05f89d971445de93c26a2ab7981c0864/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 458531552
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-15', 1, 2, id, '{"izvodjac":"Konstrakta","naslov":"In corpore sano","alias":[],"deezerId":1655110372,"itunesId":1610103739,"omot":"https://cdn-images.dzcdn.net/images/cover/fee2ed6185e41649eaa2382f0c076bf7/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1655110372
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-15', 1, 3, id, '{"izvodjac":"S.A.R.S.","naslov":"Perspektiva","alias":[],"deezerId":448247912,"itunesId":1479062918,"omot":"https://cdn-images.dzcdn.net/images/cover/b5c7bf612232dd7a5d0165fc4c2abc58/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 448247912
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-15', 1, 4, id, '{"izvodjac":"Teya Dora","naslov":"Džanum","alias":[],"deezerId":2393291385,"itunesId":1700644621,"omot":"https://cdn-images.dzcdn.net/images/cover/87aa5284a23bc8622f2fd44364454975/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2393291385
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-15', 1, 5, id, '{"izvodjac":"Jala Brat","naslov":"Ajkula","alias":[],"deezerId":3991260501,"itunesId":6764452931,"omot":"https://cdn-images.dzcdn.net/images/cover/acb4e11962d9ecee31354dfb648c1124/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3991260501
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-16', 1, 1, id, '{"izvodjac":"Indira Radić","naslov":"Lopov","alias":[],"deezerId":1530383982,"itunesId":1591493897,"omot":"https://cdn-images.dzcdn.net/images/cover/50604a8c23db2078d29ecc7cb8a99b6c/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1530383982
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-16', 1, 2, id, '{"izvodjac":"Marčelo","naslov":"Pegla","alias":[],"deezerId":126398043,"itunesId":1122634973,"omot":"https://cdn-images.dzcdn.net/images/cover/aec32e8015c2b22615ba2d97a2c6ac3b/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 126398043
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-16', 1, 3, id, '{"izvodjac":"Mile Kitić","naslov":"Kilo dole, kilo gore","alias":[],"deezerId":1820167077,"itunesId":1633892109,"omot":"https://cdn-images.dzcdn.net/images/cover/adee76b22456817d1863183121472e70/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1820167077
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-16', 1, 4, id, '{"izvodjac":"Nataša Bekvalac","naslov":"Dobro moje","alias":[],"deezerId":543688932,"itunesId":1578025575,"omot":"https://cdn-images.dzcdn.net/images/cover/953fbf662c9e1503c278933273640980/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 543688932
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-16', 1, 5, id, '{"izvodjac":"YU Grupa","naslov":"Čudna šuma","alias":[],"deezerId":93131246,"itunesId":507745455,"omot":"https://cdn-images.dzcdn.net/images/cover/da08dde9b45fcf2e04473f0329dd68a9/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 93131246
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-17', 1, 1, id, '{"izvodjac":"Smak","naslov":"Daire","alias":[],"deezerId":1189113232,"itunesId":1673511043,"omot":"https://cdn-images.dzcdn.net/images/cover/d551c7f7f3e9738741cafa9dd69e695f/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1189113232
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-17', 1, 2, id, '{"izvodjac":"Aca Lukas","naslov":"Daleko si","alias":[],"deezerId":572081772,"itunesId":1577967053,"omot":"https://cdn-images.dzcdn.net/images/cover/3b5428512253cd36786be74b73657a25/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 572081772
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-17', 1, 3, id, '{"izvodjac":"Buba Corelli","naslov":"Irina shayk","alias":[],"deezerId":2826320292,"itunesId":1869458438,"omot":"https://cdn-images.dzcdn.net/images/cover/4761914e79b106659915fb3cdfa44860/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2826320292
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-17', 1, 4, id, '{"izvodjac":"Emina Jahović","naslov":"Da l'' ona zna","alias":["Da li ona zna"],"deezerId":529455441,"itunesId":1578000002,"omot":"https://cdn-images.dzcdn.net/images/cover/9b8f2e85f1699b9c3f2bb6400be9322f/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 529455441
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-17', 1, 5, id, '{"izvodjac":"Bajaga i Instruktori","naslov":"Moji drugovi","alias":[],"deezerId":2619832862,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/97755b9dade374e5265ec215db465e81/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2619832862
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-18', 1, 1, id, '{"izvodjac":"Viki Miljković","naslov":"Mariš li","alias":[],"deezerId":1458112122,"itunesId":1578151710,"omot":"https://cdn-images.dzcdn.net/images/cover/fae5d2666bdba41f52c2180cf71613b0/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1458112122
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-18', 1, 2, id, '{"izvodjac":"Aleksandra Radović","naslov":"Čuvam te","alias":[],"deezerId":724771892,"itunesId":1577968457,"omot":"https://cdn-images.dzcdn.net/images/cover/c5fc18b55056ab0e7eaf24497bff3520/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 724771892
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-18', 1, 3, id, '{"izvodjac":"Riblja Čorba","naslov":"Dva dinara, druže","alias":["2 dinara druže"],"deezerId":3030816441,"itunesId":1772667606,"omot":"https://cdn-images.dzcdn.net/images/cover/fa409f8b415268365a412f2758797489/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3030816441
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-18', 1, 4, id, '{"izvodjac":"Tony Cetinski","naslov":"Ako to se zove ljubav","alias":[],"deezerId":66429248,"itunesId":509534403,"omot":"https://cdn-images.dzcdn.net/images/cover/0b959c90add736fc2cc0c9117fc7b2f5/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 66429248
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-18', 1, 5, id, '{"izvodjac":"Bad Copy","naslov":"Uno due tre","alias":[],"deezerId":3259803621,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/d016ccf63f7b59d5085da70e19936678/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3259803621
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-19', 1, 1, id, '{"izvodjac":"Električni Orgazam","naslov":"Bejbe, ti nisi tu","alias":[],"deezerId":2997909771,"itunesId":505135793,"omot":"https://cdn-images.dzcdn.net/images/cover/a1daef37893c7371a79c1d084a8aed13/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2997909771
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-19', 1, 2, id, '{"izvodjac":"Zera","naslov":"Iz subote u petak","alias":[],"deezerId":3026514961,"itunesId":1770863637,"omot":"https://cdn-images.dzcdn.net/images/cover/5f54d16fe53c8624a0aed2b93587a4e3/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3026514961
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-19', 1, 3, id, '{"izvodjac":"Halid Muslimović","naslov":"Mama ne da da te diram","alias":[],"deezerId":458784522,"itunesId":1345323094,"omot":"https://cdn-images.dzcdn.net/images/cover/6e0a5d3fb127ce0a0f2a20f09f63ca32/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 458784522
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-19', 1, 4, id, '{"izvodjac":"Mitar Mirić","naslov":"Ne može nam niko ništa","alias":[],"deezerId":15620002,"itunesId":1877161517,"omot":"https://cdn-images.dzcdn.net/images/cover/d72ac926caf3ca020cd716b445803900/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 15620002
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-19', 1, 5, id, '{"izvodjac":"Jelena Rozga","naslov":"Nirvana","alias":[],"deezerId":2998009921,"itunesId":632120047,"omot":"https://cdn-images.dzcdn.net/images/cover/4b108ec75e2bd830d4f5552c36d17ded/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2998009921
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-20', 1, 1, id, '{"izvodjac":"Magazin","naslov":"Minus i plus","alias":[],"deezerId":1006925662,"itunesId":488074453,"omot":"https://cdn-images.dzcdn.net/images/cover/9382f18da0cc7fbbcbcb9ce5c80ea7b1/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1006925662
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-20', 1, 2, id, '{"izvodjac":"Voyage & Breskvica","naslov":"Budi tu","alias":[],"deezerId":3026502121,"itunesId":1770864844,"omot":"https://cdn-images.dzcdn.net/images/cover/e26a759066d37ce15e40bade657a5020/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3026502121
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-20', 1, 3, id, '{"izvodjac":"Lepa Brena","naslov":"Luda za tobom","alias":[],"deezerId":1056591462,"itunesId":1578099903,"omot":"https://cdn-images.dzcdn.net/images/cover/760738cd4fe6b8693c7ad03772a8db96/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1056591462
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-20', 1, 4, id, '{"izvodjac":"Piloti","naslov":"Ne veruj u idole","alias":[],"deezerId":3020679851,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/580fc7b2b1ba75ed6afd50b21390245b/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3020679851
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-20', 1, 5, id, '{"izvodjac":"Rambo Amadeus","naslov":"Balkan boj","alias":[],"deezerId":3200983881,"itunesId":1792096613,"omot":"https://cdn-images.dzcdn.net/images/cover/692a2d9d46134a262bfd5f049480499d/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3200983881
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-21', 1, 1, id, '{"izvodjac":"Milica Todorović","naslov":"Tri čaše","alias":[],"deezerId":464556372,"itunesId":1578147923,"omot":"https://cdn-images.dzcdn.net/images/cover/70f9546a52fbbe77edd2a85c8727f13a/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 464556372
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-21', 1, 2, id, '{"izvodjac":"Saša Kovačević","naslov":"Slučajno","alias":[],"deezerId":3265960921,"itunesId":1800492251,"omot":"https://cdn-images.dzcdn.net/images/cover/4c260d27762770c4c6b020f7baea355a/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3265960921
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-21', 1, 3, id, '{"izvodjac":"Beogradski Sindikat","naslov":"Balada disidenta","alias":[],"deezerId":1621917272,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/60e3ad80c9381a32abecf019afb0f07b/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1621917272
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-21', 1, 4, id, '{"izvodjac":"Sara Jo","naslov":"Mili, mili","alias":[],"deezerId":1458276022,"itunesId":1485997194,"omot":"https://cdn-images.dzcdn.net/images/cover/5c32fe082b74da88e2f70874158a7434/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1458276022
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-21', 1, 5, id, '{"izvodjac":"U Škripcu","naslov":"Siđi do reke","alias":[],"deezerId":93538110,"itunesId":555295020,"omot":"https://cdn-images.dzcdn.net/images/cover/da3456422c95889d66d3ad006091172e/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 93538110
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-22', 1, 1, id, '{"izvodjac":"Dejan Cukić","naslov":"Ruža ispod pepela","alias":[],"deezerId":3314918891,"itunesId":1812622351,"omot":"https://cdn-images.dzcdn.net/images/cover/fd85e9d6799380a9d7f69973d1e46dcd/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3314918891
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-22', 1, 2, id, '{"izvodjac":"Buba Corelli","naslov":"Balenciaga","alias":[],"deezerId":2826423592,"itunesId":1869456343,"omot":"https://cdn-images.dzcdn.net/images/cover/755122dbe831587019a0ff9596c38b31/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2826423592
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-22', 1, 3, id, '{"izvodjac":"Vlado Georgiev","naslov":"Bolesni od ljubavi","alias":[],"deezerId":3735395362,"itunesId":1863655702,"omot":"https://cdn-images.dzcdn.net/images/cover/308fdfe7a27a4ca7ab4e2785f4c8ac5c/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3735395362
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-22', 1, 4, id, '{"izvodjac":"Boban Rajović","naslov":"Usne boje vina","alias":[],"deezerId":1097490802,"itunesId":1577984193,"omot":"https://cdn-images.dzcdn.net/images/cover/3d2467e404000ce8672df185747ce77e/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1097490802
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-22', 1, 5, id, '{"izvodjac":"Sinan Sakić","naslov":"Ej, od kad sam se rodio","alias":[],"deezerId":1302228482,"itunesId":1738171628,"omot":"https://cdn-images.dzcdn.net/images/cover/21ae99ba2b4baeb63160ca7203c78457/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1302228482
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-23', 1, 1, id, '{"izvodjac":"Zdravko Čolić","naslov":"Jedina","alias":[],"deezerId":2995450631,"itunesId":1768453462,"omot":"https://cdn-images.dzcdn.net/images/cover/6ea8f083fd4774d807baf0eb2eb30db2/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2995450631
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-23', 1, 2, id, '{"izvodjac":"Vojko V","naslov":"Ceca u Parizu","alias":[],"deezerId":3014936821,"itunesId":1756902379,"omot":"https://cdn-images.dzcdn.net/images/cover/292d45122560e4b10bc93afbecacdaa3/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3014936821
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-23', 1, 3, id, '{"izvodjac":"Sinan Sakić","naslov":"Lepa do bola","alias":[],"deezerId":1148816532,"itunesId":1541356044,"omot":"https://cdn-images.dzcdn.net/images/cover/d18891c57626dc413055ba40cde08701/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1148816532
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-23', 1, 4, id, '{"izvodjac":"Đorđe Balašević","naslov":"Priča o Vasi Ladačkom","alias":[],"deezerId":3933438781,"itunesId":1885825448,"omot":"https://cdn-images.dzcdn.net/images/cover/e79b6ef15974e508aab915a4716cbb5a/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3933438781
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-23', 1, 5, id, '{"izvodjac":"Riblja Čorba","naslov":"Lutka sa naslovne strane","alias":[],"deezerId":2464031485,"itunesId":1708115106,"omot":"https://cdn-images.dzcdn.net/images/cover/a75eb24f5925b3374a9e44f3236ba53f/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2464031485
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-24', 1, 1, id, '{"izvodjac":"Devito","naslov":"Koketa","alias":[],"deezerId":2726833681,"itunesId":1738427786,"omot":"https://cdn-images.dzcdn.net/images/cover/c1c980c19dfa3b5ec31e3e5d17547fa2/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2726833681
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-24', 1, 2, id, '{"izvodjac":"Marija Šerifović","naslov":"Bol do ludila","alias":[],"deezerId":543705752,"itunesId":1578021817,"omot":"https://cdn-images.dzcdn.net/images/cover/a4ba12f349f6e58537ac9b90adc75ebc/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 543705752
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-24', 1, 3, id, '{"izvodjac":"Željko Samardžić","naslov":"Grlica","alias":[],"deezerId":730630702,"itunesId":1690799736,"omot":"https://cdn-images.dzcdn.net/images/cover/5710206419be4921023ac329d20c707b/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 730630702
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-24', 1, 4, id, '{"izvodjac":"Đorđe Balašević","naslov":"Ne lomite mi bagrenje","alias":[],"deezerId":3933464011,"itunesId":1885963818,"omot":"https://cdn-images.dzcdn.net/images/cover/9fed900e0042c875191498d5383ec431/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3933464011
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-24', 1, 5, id, '{"izvodjac":"Halid Bešlić","naslov":"Miljacka","alias":[],"deezerId":1251889,"itunesId":1745064686,"omot":"https://cdn-images.dzcdn.net/images/cover/d290176d38d7f6fe336a43ea6d36c8d4/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1251889
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-25', 1, 1, id, '{"izvodjac":"Dragana Mirković","naslov":"Plači zemljo","alias":[],"deezerId":4262262541,"itunesId":1530131660,"omot":"https://cdn-images.dzcdn.net/images/cover/3b3a2d12b24a8be40862b8799614e1d1/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 4262262541
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-25', 1, 2, id, '{"izvodjac":"Daniel Popović","naslov":"Džuli","alias":[],"deezerId":994777892,"itunesId":381023337,"omot":"https://cdn-images.dzcdn.net/images/cover/daaefcbea471f512871fe4f85e3b2531/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 994777892
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-25', 1, 3, id, '{"izvodjac":"Dara Bubamara","naslov":"Kraj i tačka","alias":[],"deezerId":76953700,"itunesId":853807117,"omot":"https://cdn-images.dzcdn.net/images/cover/39969f9ae6ee3e7e45b3504aaa96e5dc/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 76953700
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-25', 1, 4, id, '{"izvodjac":"Voyage","naslov":"Tango","alias":[],"deezerId":1785220827,"itunesId":1628769460,"omot":"https://cdn-images.dzcdn.net/images/cover/f378a23191c6debe79936209fb386c19/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1785220827
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-25', 1, 5, id, '{"izvodjac":"Parni Valjak","naslov":"Jesen u meni","alias":[],"deezerId":3020609441,"itunesId":1805023586,"omot":"https://cdn-images.dzcdn.net/images/cover/07cb8373f4064a1517f69937dd4b4217/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3020609441
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-26', 1, 1, id, '{"izvodjac":"Prljavo Kazalište","naslov":"Mi plešemo","alias":[],"deezerId":928567582,"itunesId":1524440040,"omot":"https://cdn-images.dzcdn.net/images/cover/99065d103e923d88404b441efbf85de6/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 928567582
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-26', 1, 2, id, '{"izvodjac":"Doris Dragović","naslov":"Marija magdalena","alias":[],"deezerId":1014394102,"itunesId":1770595050,"omot":"https://cdn-images.dzcdn.net/images/cover/7c18db702f482e6b382ef82f6638a789/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1014394102
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-26', 1, 3, id, '{"izvodjac":"Darko Lazić","naslov":"Godinu dana 300 kafana","alias":["Godinu dana trista kafana"],"deezerId":3364966471,"itunesId":1578085998,"omot":"https://cdn-images.dzcdn.net/images/cover/c60e8d6d629589dd4127f975dec3ea9b/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3364966471
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-26', 1, 4, id, '{"izvodjac":"Sunshine","naslov":"Kokane","alias":[],"deezerId":74220640,"itunesId":1591697553,"omot":"https://cdn-images.dzcdn.net/images/cover/addfca3b309c6ea81ad769b448f00cca/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 74220640
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-26', 1, 5, id, '{"izvodjac":"Van Gogh","naslov":"Klatno","alias":[],"deezerId":416410242,"itunesId":1295930977,"omot":"https://cdn-images.dzcdn.net/images/cover/61d3ba6e2992d5d906b999483ef4d241/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 416410242
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-27', 1, 1, id, '{"izvodjac":"Aleksandra Prijović","naslov":"Dam dam dam","alias":[],"deezerId":2342297565,"itunesId":1694278577,"omot":"https://cdn-images.dzcdn.net/images/cover/9c3baeb9c3252c493bea73402bc8ba9b/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2342297565
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-27', 1, 2, id, '{"izvodjac":"Đogani","naslov":"Idemo na Mars","alias":[],"deezerId":1524827632,"itunesId":1578052439,"omot":"https://cdn-images.dzcdn.net/images/cover/319281deac498cf8a51f7b5aae08f326/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1524827632
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-27', 1, 3, id, '{"izvodjac":"Elena","naslov":"Geto princeza","alias":[],"deezerId":2874736332,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/68eef0cddd4de7acc5fdfee9a3c2f959/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2874736332
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-27', 1, 4, id, '{"izvodjac":"Ministarke","naslov":"Moje jedino","alias":[],"deezerId":136282042,"itunesId":1177057642,"omot":"https://cdn-images.dzcdn.net/images/cover/5aeea2ec7785de8477ddd10c2a4bd86c/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 136282042
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-27', 1, 5, id, '{"izvodjac":"Bajaga i Instruktori","naslov":"Tišina","alias":[],"deezerId":3265454081,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/773908c4ad7bd859a9fd036880c16a28/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3265454081
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-28', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-28', 1, 1, id, '{"izvodjac":"Mimi Mercedez","naslov":"Kleopatra","alias":[],"deezerId":3304073171,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/7baea02c4635231c7e7abdf66bd1be9f/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3304073171
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-28', 1, 2, id, '{"izvodjac":"Šaban Šaulić","naslov":"Dajte mi utjehu","alias":["Dajte mi utehu"],"deezerId":2160334507,"itunesId":291506273,"omot":"https://cdn-images.dzcdn.net/images/cover/fa61c937eca4bb4360b237e4f071b7d9/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2160334507
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-28', 1, 3, id, '{"izvodjac":"Ana Bekuta","naslov":"Kralj ponoći","alias":[],"deezerId":473686002,"itunesId":1618909883,"omot":"https://cdn-images.dzcdn.net/images/cover/1197780efc4c44c6729adace6872d7eb/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 473686002
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-28', 1, 4, id, '{"izvodjac":"Električni Orgazam","naslov":"Kako bubanj kaže","alias":[],"deezerId":23648731,"itunesId":505135797,"omot":"https://cdn-images.dzcdn.net/images/cover/1bc71d46e2635206baf4f0f648c5e4d5/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 23648731
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-28', 1, 5, id, '{"izvodjac":"Dino Merlin","naslov":"Kad si rekla da me voliš","alias":[],"deezerId":23638701,"itunesId":1354468333,"omot":"https://cdn-images.dzcdn.net/images/cover/94a89a05b683fa85f3eefc09e9a5b155/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 23638701
  on conflict (quiz_date, segment, position) do nothing;

-- Artikli (products.json). Postojeći se osvežavaju po barkodu.
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043000023', 'Plazma keks', '300 g', '/artikli/8600043000023.webp', 288.56, 279.99, 294.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043000016', 'Plazma keks', '150 g', '/artikli/8600043000016.webp', 158.19, 152.99, 159.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043039788', 'Plazma keks', '400 g', '/artikli/8600043039788.webp', 392.95, 369.99, 433.07, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043001105', 'Plazma mlevena', '300 g', '/artikli/8600043001105.webp', 292.59, 279.99, 299.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043028263', 'Plazma Kocka napolitanke', '135 g', '/artikli/8600043028263.webp', 207, 183.99, 227.36, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043029512', 'Plazma Stiksi', '125 g', '/artikli/8600043029512.webp', 250.19, 217.99, 270.67, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043036794', 'Plazma od srca lešnik', '100 g', '/artikli/8600043036794.webp', 196.53, 184.99, 205.7, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043041484', 'Plazma Rolsi lešnik', '130 g', '/artikli/8600043041484.webp', 185.59, 170.99, 212.49, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114000013', 'Jaffa keks', '150 g', '/artikli/8600114000013.webp', 143.62, 139.99, 146.66, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114000211', 'Jaffa keks', '300 g', '/artikli/8600114000211.webp', 252, 249.69, 258.32, 'Maxi', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114000020', 'Munchmallow', '105 g', '/artikli/8600114000020.webp', 107.98, 102.99, 111.66, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114006626', 'Jaffa napolitanke šlag i čokolada', '187 g', '/artikli/8600114006626.webp', 121.77, 109.99, 139.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939313701', 'Najlepše želje mlečna čokolada', '200 g', '/artikli/8600939313701.webp', 381.76, 364.99, 389.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939313602', 'Najlepše želje mlečna čokolada', '90 g', '/artikli/8600939313602.webp', 192.96, 189.99, 198.32, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939334171', 'Najlepše želje crna sa bananicom', '184 g', '/artikli/8600939334171.webp', 367.08, 349.99, 389.99, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939346082', 'Najlepše želje sa keksom', '170 g', '/artikli/8600939346082.webp', 352.63, 349.99, 363.32, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('86006675', 'Štark Bananica', '25 g', '/artikli/86006675.webp', 27.27, 24.99, 29.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939366424', 'Štark Bananica', '250 g', '/artikli/8600939366424.webp', 257.59, 247.99, 269.99, 'Maxi', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939365472', 'Štark Bananica 5 kom', '125 g', '/artikli/8600939365472.webp', 138.89, 134.99, 141.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939130841', 'Štark Piškote', '105 g', '/artikli/8600939130841.webp', 106.79, 96.99, 122.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939303115', 'Štark Menaž čokolada za kuvanje', '100 g', '/artikli/8600939303115.webp', 201.6, 192.99, 211.66, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939841204', 'Štark Čajni keksići', '800 g', '/artikli/8600939841204.webp', 323.29, 313.99, 349.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939110454', 'Štark napolitanke sa čokoladom', '180 g', '/artikli/8600939110454.webp', 146.77, 128.99, 159.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900502032', 'Eurocrem Euro blok', '50 g', '/artikli/8601900502032.webp', 66.79, 59.99, 74.99, 'Univerexport', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900502100', 'Eurocrem Euro blok', '100 g', '/artikli/8601900502100.webp', 121.33, 99.99, 137.99, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900503411', 'Eurocrem činija', '500 g', '/artikli/8601900503411.webp', 480.46, 399.99, 543.32, 'Univerexport', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600946442111', 'Swisslion Isleri sa Eurocremom', '125 g', '/artikli/8600946442111.webp', 155.19, 129.99, 184.99, 'Univerexport', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300236022', 'Pionir Medeno srce', '150 g', '/artikli/8602300236022.webp', 145.63, 139.99, 153.32, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300200245', 'Pionir zeleni mentol bombone', '100 g', '/artikli/8602300200245.webp', 67.71, 59.99, 74.72, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300207305', 'Pionir karamele lešnik', '100 g', '/artikli/8602300207305.webp', 145.02, 132.99, 154.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300233229', 'Pionir mix Negro i Karamela lešnik', '250 g', '/artikli/8602300233229.webp', 264.47, 252.99, 286.16, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600104004458', 'Medela štrudla', '240 g', '/artikli/8600104004458.webp', 150.42, 139.99, 157.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939506912', 'Smoki', '50 g', '/artikli/8600939506912.webp', 47.66, 45.99, 49.99, 'Maxi', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939508190', 'Smoki', '80 g', '/artikli/8600939508190.webp', 73.8, 69.99, 76.99, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939506936', 'Smoki', '150 g', '/artikli/8600939506936.webp', 129.26, 127.99, 129.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939507025', 'Smoki', '250 g', '/artikli/8600939507025.webp', 184.73, 171.99, 199.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939375563', 'Čoko Smoki', '80 g', '/artikli/8600939375563.webp', 170.95, 149.99, 179.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017378495', 'Chipsy Classic', '140 g', '/artikli/8606017378495.webp', 192.37, 171.49, 214.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606033742416', 'Chipsy Domaćinski kajmak', '145 g', '/artikli/8606033742416.webp', 194.88, 184.99, 199.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606033741495', 'Clipsy Mix flips', '150 g', '/artikli/8606033741495.webp', 149.35, 144.99, 156.66, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017378822', 'Pardon štapići sa kikirikijem', '210 g', '/artikli/8606017378822.webp', 159.22, 137.99, 169.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017370048', 'Pardon perece', '95 g', '/artikli/8606017370048.webp', 81.39, 74.99, 88.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037000312', 'Knjaz Miloš gazirana voda', '0,5 l', '/artikli/8600037000312.webp', 54.48, 49.99, 57, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037005133', 'Knjaz Miloš gazirana voda', '1,75 l', '/artikli/8600037005133.webp', 64.65, 62.99, 65.59, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037008011', 'Knjaz Miloš staklo', '0,25 l', '/artikli/8600037008011.webp', 82.99, 77.99, 89.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600169600022', 'Prolom voda', '1,5 l', '/artikli/8600169600022.webp', 86.24, 82.66, 99.99, 'Idea', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606002170066', 'Aqua Heba gazirana', '1,5 l', '/artikli/8606002170066.webp', 65.35, 61.99, 69.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606030051702', 'Fruvita narandža 100%', '0,8 l', '/artikli/8606030051702.webp', 317.76, 297.99, 349.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600105001463', 'Jelen pivo limenka', '0,5 l', '/artikli/8600105001463.webp', 98.28, 90.99, 109.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('86027618', 'Jelen pivo flaša', '0,5 l', '/artikli/86027618.webp', 91.19, 89.99, 94.99, 'Univerexport', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600102672383', 'Lav pivo limenka', '0,5 l', '/artikli/8600102672383.webp', 88.2, 82.99, 92.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600649000427', 'Zaječarsko pivo limenka', '0,5 l', '/artikli/8600649000427.webp', 96.28, 89.99, 104.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606105157360', 'Zaječarsko pivo PET', '2 l', '/artikli/8606105157360.webp', 305.37, 279.99, 316.66, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600101521439', 'Doncafe Moment kafa', '200 g', '/artikli/8600101521439.webp', 471.34, 449.99, 483.32, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600103056250', 'Grand Gold kafa', '500 g', '/artikli/8600103056250.webp', 1112.05, 999.99, 1159.99, 'Univerexport', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606106464078', 'Bonito tamno pržena kafa', '200 g', '/artikli/8606106464078.webp', 457.04, 429.99, 507.68, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606018312276', 'Grand 3u1 Najlepše želje', '18 g', '/artikli/8606018312276.webp', 32.44, 28.99, 39.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500116011', 'Moja Kravica mleko dugotrajno 2,8%', '1 l', '/artikli/8601500116011.webp', 112.99, 99.99, 139.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500138655', 'Moja Kravica sveže mleko 2,8%', '1,75 l', '/artikli/8601500138655.webp', 226.79, 219.99, 230.62, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500138495', 'Moja Kravica jogurt 2,8%', '1,75 kg', '/artikli/8601500138495.webp', 232.61, 224.99, 240.09, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500115892', 'Moja Kravica jogurt čaša', '180 g', '/artikli/8601500115892.webp', 38.46, 35.99, 39.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500110330', 'Moja Kravica čokoladno mleko', '0,25 l', '/artikli/8601500110330.webp', 67.56, 64.99, 69.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500112419', 'Moja Kravica kisela pavlaka 20%', '400 g', '/artikli/8601500112419.webp', 187.09, 179.99, 189.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500111122', 'Moja Kravica maslac', '125 g', '/artikli/8601500111122.webp', 321.53, 315.99, 329.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500119609', 'Moja Kravica krem sir', '200 g', '/artikli/8601500119609.webp', 194.35, 179.99, 201.49, 'Gomex', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500126492', 'Ella sveži sir', '400 g', '/artikli/8601500126492.webp', 283.01, 262.99, 299.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500133490', 'Imlek protein čoko šejk', '300 ml', '/artikli/8601500133490.webp', 180.06, 169.99, 189.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012700183', 'Carnex mesni narezak', '150 g', '/artikli/8600012700183.webp', 212.99, 174.99, 229.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('86002783', 'Carnex jetrena pašteta', '75 g', '/artikli/86002783.webp', 88.94, 79.99, 99.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012700336', 'Carnex sarma', '400 g', '/artikli/8600012700336.webp', 495.72, 469.99, 521.66, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012700282', 'Carnex pasulj sa slaninom', '400 g', '/artikli/8600012700282.webp', 359.45, 317.49, 403.32, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012502510', 'Carnex delikates viršla', '205 g', '/artikli/8600012502510.webp', 211.07, 196.99, 229.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600084005841', 'Yuhor Alpska kobasica', '350 g', '/artikli/8600084005841.webp', 302.85, 244.99, 339.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600084005612', 'Yuhor Levački štapići', '200 g', '/artikli/8600084005612.webp', 594.16, 557.99, 639.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600763655244', 'Neoplanta Pipi pileća viršla', '205 g', '/artikli/8600763655244.webp', 193.06, 182.99, 209.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600763025559', 'Neoplanta namaz u crevu', '125 g', '/artikli/8600763025559.webp', 97.44, 91.99, 104.99, 'Maxi', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600763036777', 'Neoplanta pizza šunka', '330 g', '/artikli/8600763036777.webp', 355.7, 284.99, 392.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606100145775', 'Zlatiborac kulen slajs', '100 g', '/artikli/8606100145775.webp', 270.52, 207.49, 309.99, 'Maxi', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606100145737', 'Zlatiborac goveđa pršuta slajs', '100 g', '/artikli/8606100145737.webp', 696.31, 617.99, 764.99, 'Maxi', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606106822403', 'Zlatiborac čvarci', '150 g', '/artikli/8606106822403.webp', 472.66, 436.99, 499.99, 'Maxi', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498170029', 'Dijamant suncokretovo ulje', '1 l', '/artikli/8600498170029.webp', 200.77, 195.66, 214.99, 'Univerexport', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498150083', 'Dijamant kečap blagi', '500 g', '/artikli/8600498150083.webp', 160.84, 147.99, 179.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498176359', 'Dijamant majonez', '285 ml', '/artikli/8600498176359.webp', 191.65, 189.99, 199.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498172115', 'Dijamant stoni margarin', '250 g', '/artikli/8600498172115.webp', 114.79, 104.99, 124.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498151479', 'Dijamant ajvar blagi', '680 g', '/artikli/8600498151479.webp', 470.1, 449.55, 514.99, 'Idea', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900201119', 'Takovo koncentrat kokošije supe', '88 g', '/artikli/8601900201119.webp', 194.01, 130.32, 245.99, 'Univerexport', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080064', 'Frikom Macho sladoled', '75 ml', '/artikli/8606006080064.webp', 147.56, 129.99, 153.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080088', 'Frikom Kapri sladoled', '70 ml', '/artikli/8606006080088.webp', 99.14, 89.99, 102.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080040', 'Frikom Sneško', '46 g', '/artikli/8606006080040.webp', 79.39, 75, 80.99, 'Gomex', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080095', 'Frikom Čoko Moko', '52 g', '/artikli/8606006080095.webp', 80.39, 79.99, 81.99, 'Idea', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606029612204', 'Frikom Quattro Plazma', '1,5 l', '/artikli/8606029612204.webp', 651.18, 599.99, 699.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606029610019', 'Frikom grašak', '400 g', '/artikli/8606029610019.webp', 165.76, 149.99, 179.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006081252', 'Frikom pomfrit', '1 kg', '/artikli/8606006081252.webp', 388.66, 382.99, 399.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017433705', 'Frikom pogačice', '800 g', '/artikli/8606017433705.webp', 315.9, 289.99, 374.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('5900951311505', 'Snickers', '50 g', '/artikli/5900951311505.webp', 94.84, 84.99, 99.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('5900951311321', 'Mars', '51 g', '/artikli/5900951311321.webp', 94.84, 84.99, 99.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8000500003787', 'Ferrero Rocher', '200 g', '/artikli/8000500003787.webp', 855.24, 789.49, 899.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('80052760', 'Kinder Bueno', '43 g', '/artikli/80052760.webp', 110.68, 106.99, 114.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8000500023976', 'Raffaello', '150 g', '/artikli/8000500023976.webp', 578.64, 529.49, 623.7, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3850102230044', 'Kraš Bajadera', '200 g', '/artikli/3850102230044.webp', 849.2, 712.99, 916.66, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3850102516704', 'Kraš Ki-Ki Tutti frutti bombone', '100 g', '/artikli/3850102516704.webp', 159.73, 130.49, 179.64, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('7622210765932', 'Oreo keks', '110 g', '/artikli/7622210765932.webp', 142.91, 138.99, 149.99, 'Univerexport', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600462042536', 'Noblice keks', '222 g', '/artikli/8600462042536.webp', 134.88, 127.99, 143.32, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('7613035365414', 'KitKat', '41,5 g', '/artikli/7613035365414.webp', 103.7, 84.99, 110.95, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300219681', 'Pionir Negro bombone', '200 g', '/artikli/8602300219681.webp', 231.47, 216.99, 251.18, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('4014400901191', 'Merci bombonjera', '250 g', '/artikli/4014400901191.webp', 961.76, 899.99, 995.12, 'Gomex', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3850102117215', 'Kraš Dorina sa ledenim punjenjem', '100 g', '/artikli/3850102117215.webp', 167.35, 159.99, 199.99, 'Idea', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('7622201389505', '7 Days kroasan kakao', '110 g', '/artikli/7622201389505.webp', 149.16, 109.99, 169.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3850104267116', 'Lino Lada Duo', '350 g', '/artikli/3850104267116.webp', 473.22, 449.99, 499.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8000500328545', 'Kinder Choco fresh', '41 g', '/artikli/8000500328545.webp', 166.93, 154.99, 174.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('5053990101573', 'Pringles Original', '165 g', '/artikli/5053990101573.webp', 340.99, 299.99, 409.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017379393', 'Doritos Nacho Cheese', '90 g', '/artikli/8606017379393.webp', 146.52, 135.99, 158.66, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606107718699', 'Čačanski čips classic', '90 g', '/artikli/8606107718699.webp', 132.63, 119.99, 141.49, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606107223131', 'Gricko flips', '100 g', '/artikli/8606107223131.webp', 116.92, 109.99, 121.24, 'Gomex', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600462020985', 'Banini Trik štapići', '200 g', '/artikli/8600462020985.webp', 81.32, 74.99, 88.32, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('5410041435702', 'TUC krekeri original', '100 g', '/artikli/5410041435702.webp', 104.9, 94.99, 109.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606015852638', 'Florida kikiriki jumbo', '180 g', '/artikli/8606015852638.webp', 188.42, 169.99, 229.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('5449000000286', 'Coca-Cola', '2 l', '/artikli/5449000000286.webp', 186.94, 174.99, 200.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3838471032537', 'Cockta', '1,5 l', '/artikli/3838471032537.webp', 131.87, 119.99, 135.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037998749', 'Pepsi', '2 l', '/artikli/8600037998749.webp', 157.71, 134.49, 164.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('5449000214805', 'Fanta narandža limenka', '0,33 l', '/artikli/5449000214805.webp', 87.57, 76.99, 99.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('9002490100070', 'Red Bull', '0,25 l', '/artikli/9002490100070.webp', 180.55, 179.99, 181.66, 'Maxi', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037000442', 'Guarana limenka', '0,5 l', '/artikli/8600037000442.webp', 96.21, 94.99, 99.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037003269', 'Knjaz Miloš sa limunom', '1,25 l', '/artikli/8600037003269.webp', 86.95, 79.99, 93.32, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('5449000235985', 'Fuze Tea breskva', '1,5 l', '/artikli/5449000235985.webp', 175.48, 159.99, 193.32, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3850322014882', 'Cedevita narandža', '455 g', '/artikli/3850322014882.webp', 459.49, 435.99, 479.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600102672291', 'Tuborg pivo limenka', '0,5 l', '/artikli/8600102672291.webp', 126.54, 116.99, 134.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600105001678', 'Nikšićko pivo limenka', '0,5 l', '/artikli/8600105001678.webp', 104.77, 96.99, 114.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606105157513', 'Amstel pivo limenka', '0,5 l', '/artikli/8606105157513.webp', 93.18, 87.99, 97.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606106174564', 'Somersby kruška', '0,33 l', '/artikli/8606106174564.webp', 162.23, 151.99, 171.32, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3899003001001', '13. jul Vranac', '0,75 l', '/artikli/3899003001001.webp', 585.94, 544.99, 649.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600102938076', 'Čoka Ždrepčeva krv', '1 l', '/artikli/8600102938076.webp', 442.11, 399.99, 499.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606001830992', 'Gorki list', '1 l', '/artikli/8606001830992.webp', 1503.84, 1364.99, 1599.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600074211924', 'Vinjak Rubin', '1 l', '/artikli/8600074211924.webp', 1405.66, 1388.99, 1426.66, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('5011007003005', 'Jameson viski', '0,7 l', '/artikli/5011007003005.webp', 2730.78, 2499, 2906.5, 'Univerexport', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8002230000302', 'Aperol', '0,7 l', '/artikli/8002230000302.webp', 2204.26, 1999.99, 2292.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606107267593', 'Erdevik Tri roze koze', '0,75 l', '/artikli/8606107267593.webp', 985.03, 859.99, 1149.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8607100564429', 'C kafa mlevena', '200 g', '/artikli/8607100564429.webp', 430.19, 419.99, 439.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('7891000254912', 'Nescafé Classic limenka', '250 g', '/artikli/7891000254912.webp', 1216.94, 979.99, 1349.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8711000892749', 'Jacobs Monarch tradicionalna', '200 g', '/artikli/8711000892749.webp', 661.25, 499.99, 759.99, 'Aman', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3858881085589', 'Franck Jubilarna', '175 g', '/artikli/3858881085589.webp', 439.1, 419.99, 449.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606018311750', 'Grand Strong Gold', '200 g', '/artikli/8606018311750.webp', 521.36, 489.99, 567.76, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606002110536', 'Dukatos grčki jogurt', '150 g', '/artikli/8606002110536.webp', 69.66, 67.99, 71.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500124252', 'Grekos šumsko voće', '150 g', '/artikli/8601500124252.webp', 95.66, 89.99, 101.32, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600742000706', 'Sirko sirni namaz', '200 g', '/artikli/8600742000706.webp', 204.87, 191.49, 214.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600742010361', 'Ala kajmak', '250 g', '/artikli/8600742010361.webp', 277.04, 239.99, 296.66, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3859888858336', 'ABC sveži krem sir', '200 g', '/artikli/3859888858336.webp', 267.78, 229.99, 316.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500135067', 'Moja Kravica milk šejk vanila', '235 ml', '/artikli/8601500135067.webp', 76.42, 67.99, 79.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500136699', 'Moja Kravica puding vanila', '125 g', '/artikli/8601500136699.webp', 70.33, 64.99, 79.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3838975567009', 'Argeta kokošija pašteta', '95 g', '/artikli/3838975567009.webp', 123.1, 109.99, 132.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3838975567061', 'Argeta tuna pašteta', '95 g', '/artikli/3838975567061.webp', 176.14, 169.99, 179.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8008110002107', 'Wudy sa sirom', '150 g', '/artikli/8008110002107.webp', 154.44, 139.99, 167.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606102242212', 'Perutnina Ptuj pileća viršla', '200 g', '/artikli/8606102242212.webp', 171.52, 143.99, 199.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600763038313', 'Neoplanta pileće grudi Mini egal', '330 g', '/artikli/8600763038313.webp', 449.49, 349.99, 499.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606018046416', 'Zlatiborac čajna kobasica', '290 g', '/artikli/8606018046416.webp', 668.32, 529.99, 736.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606018041855', 'Zlatiborac dimljeni vrat slajs', '125 g', '/artikli/8606018041855.webp', 255.88, 149.99, 306.32, 'Gomex', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012503975', 'Carnex domaća kobasica', '310 g', '/artikli/8600012503975.webp', 320.78, 272.49, 359.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606107664941', 'Zlatiborac mortadela slajs', '125 g', '/artikli/8606107664941.webp', 240.53, 199.99, 279.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8076800195057', 'Barilla špagete br. 5', '500 g', '/artikli/8076800195057.webp', 191.08, 159.99, 214.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3850104260872', 'Vegeta', '400 g', '/artikli/3850104260872.webp', 366.41, 299.99, 429.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8607100510433', 'C začin', '500 g', '/artikli/8607100510433.webp', 370.6, 329.99, 384.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606011030344', 'Bakina tajna džem od jagode', '375 g', '/artikli/8606011030344.webp', 546.27, 505.48, 599.99, 'Idea', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('3858890178678', 'Thomy majonez', '280 ml', '/artikli/3858890178678.webp', 279.32, 229.99, 297.66, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606108584132', 'Indomie nudle govedina 5 kom', '350 g', '/artikli/8606108584132.webp', 244.82, 199.99, 279.99, 'Univerexport', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601300046006', 'Danubius brašno T-500', '1 kg', '/artikli/8601300046006.webp', 81.02, 78.65, 88.73, 'Idea', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606018730384', 'Tvojih 5 minuta tost classic', '500 g', '/artikli/8606018730384.webp', 179.2, 168.99, 189.99, 'Super Vero', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006083140', 'Frikom Quattro čokolada', '1,65 l', '/artikli/8606006083140.webp', 650.71, 599.99, 699.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606029610026', 'Frikom ruska salata', '400 g', '/artikli/8606029610026.webp', 185.23, 159.99, 212.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('5054563949936', 'Parodontax pasta za zube', '75 ml', '/artikli/5054563949936.webp', 639.47, 428.99, 701.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('4005808760435', 'Nivea Soft krema', '100 ml', '/artikli/4005808760435.webp', 579.2, 529.99, 636.75, 'Gomex', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8720182264664', 'Dove sapun', '90 g', '/artikli/8720182264664.webp', 145.73, 119.99, 169.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('9000101801989', 'Persil kapsule', '35 kom', '/artikli/9000101801989.webp', 1618.72, 998.99, 1900.32, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8700216550734', 'Fairy limun', '900 ml', '/artikli/8700216550734.webp', 386.41, 324.99, 449.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606015846880', 'Duel omekšivač', '1,6 l', '/artikli/8606015846880.webp', 473.19, 378.99, 519.99, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8718951278486', 'Ajax za podove', '1 l', '/artikli/8718951278486.webp', 333.99, 269.99, 389, 'Lidl', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('4009175111449', 'Erdal krema za obuću crna', '55 ml', '/artikli/4009175111449.webp', 250.5, 205.06, 289.99, 'Gomex', '2026-11-20')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();

-- Dnevni kviz: segment 2 (Pogodi cenu). Dan koji već ima stavke se ne dira.
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 1, id, '{"naziv":"Smoki","kolicina":"250 g","slika":"/artikli/8600939507025.webp","cena":185,"min":171.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600939507025'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 2, id, '{"naziv":"Neoplanta Pipi pileća viršla","kolicina":"205 g","slika":"/artikli/8600763655244.webp","cena":193,"min":182.99,"max":209.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600763655244'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 3, id, '{"naziv":"Štark Piškote","kolicina":"105 g","slika":"/artikli/8600939130841.webp","cena":107,"min":96.99,"max":122.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600939130841'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 4, id, '{"naziv":"Banini Trik štapići","kolicina":"200 g","slika":"/artikli/8600462020985.webp","cena":81,"min":74.99,"max":88.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600462020985'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 5, id, '{"naziv":"Kinder Bueno","kolicina":"43 g","slika":"/artikli/80052760.webp","cena":111,"min":106.99,"max":114.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '80052760'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 1, id, '{"naziv":"Dijamant majonez","kolicina":"285 ml","slika":"/artikli/8600498176359.webp","cena":192,"min":189.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600498176359'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 2, id, '{"naziv":"C kafa mlevena","kolicina":"200 g","slika":"/artikli/8607100564429.webp","cena":430,"min":419.99,"max":439.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8607100564429'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 3, id, '{"naziv":"Frikom Čoko Moko","kolicina":"52 g","slika":"/artikli/8606006080095.webp","cena":80,"min":79.99,"max":81.99,"najjeftinije":"Idea","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606006080095'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 4, id, '{"naziv":"Doritos Nacho Cheese","kolicina":"90 g","slika":"/artikli/8606017379393.webp","cena":147,"min":135.99,"max":158.66,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606017379393'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 5, id, '{"naziv":"Ella sveži sir","kolicina":"400 g","slika":"/artikli/8601500126492.webp","cena":283,"min":262.99,"max":299.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8601500126492'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 1, id, '{"naziv":"Knjaz Miloš staklo","kolicina":"0,25 l","slika":"/artikli/8600037008011.webp","cena":83,"min":77.99,"max":89.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600037008011'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 2, id, '{"naziv":"Persil kapsule","kolicina":"35 kom","slika":"/artikli/9000101801989.webp","cena":1619,"min":998.99,"max":1900.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '9000101801989'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 3, id, '{"naziv":"Kraš Bajadera","kolicina":"200 g","slika":"/artikli/3850102230044.webp","cena":849,"min":712.99,"max":916.66,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '3850102230044'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 4, id, '{"naziv":"Najlepše želje mlečna čokolada","kolicina":"200 g","slika":"/artikli/8600939313701.webp","cena":382,"min":364.99,"max":389.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600939313701'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 5, id, '{"naziv":"Argeta tuna pašteta","kolicina":"95 g","slika":"/artikli/3838975567061.webp","cena":176,"min":169.99,"max":179.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '3838975567061'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 1, id, '{"naziv":"Zlatiborac kulen slajs","kolicina":"100 g","slika":"/artikli/8606100145775.webp","cena":271,"min":207.49,"max":309.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606100145775'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 2, id, '{"naziv":"Jaffa keks","kolicina":"150 g","slika":"/artikli/8600114000013.webp","cena":144,"min":139.99,"max":146.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600114000013'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 3, id, '{"naziv":"Takovo koncentrat kokošije supe","kolicina":"88 g","slika":"/artikli/8601900201119.webp","cena":194,"min":130.32,"max":245.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8601900201119'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 4, id, '{"naziv":"Yuhor Levački štapići","kolicina":"200 g","slika":"/artikli/8600084005612.webp","cena":594,"min":557.99,"max":639.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600084005612'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 5, id, '{"naziv":"Oreo keks","kolicina":"110 g","slika":"/artikli/7622210765932.webp","cena":143,"min":138.99,"max":149.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '7622210765932'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 1, id, '{"naziv":"Red Bull","kolicina":"0,25 l","slika":"/artikli/9002490100070.webp","cena":181,"min":179.99,"max":181.66,"najjeftinije":"Maxi","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '9002490100070'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 2, id, '{"naziv":"Knjaz Miloš gazirana voda","kolicina":"0,5 l","slika":"/artikli/8600037000312.webp","cena":54,"min":49.99,"max":57,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600037000312'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 3, id, '{"naziv":"Dijamant stoni margarin","kolicina":"250 g","slika":"/artikli/8600498172115.webp","cena":115,"min":104.99,"max":124.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600498172115'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 4, id, '{"naziv":"Dijamant suncokretovo ulje","kolicina":"1 l","slika":"/artikli/8600498170029.webp","cena":201,"min":195.66,"max":214.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600498170029'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 5, id, '{"naziv":"Pionir zeleni mentol bombone","kolicina":"100 g","slika":"/artikli/8602300200245.webp","cena":68,"min":59.99,"max":74.72,"najjeftinije":"Aman","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8602300200245'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 1, id, '{"naziv":"Frikom Sneško","kolicina":"46 g","slika":"/artikli/8606006080040.webp","cena":79,"min":75,"max":80.99,"najjeftinije":"Gomex","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606006080040'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 2, id, '{"naziv":"Kraš Dorina sa ledenim punjenjem","kolicina":"100 g","slika":"/artikli/3850102117215.webp","cena":167,"min":159.99,"max":199.99,"najjeftinije":"Idea","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '3850102117215'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 3, id, '{"naziv":"Wudy sa sirom","kolicina":"150 g","slika":"/artikli/8008110002107.webp","cena":154,"min":139.99,"max":167.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8008110002107'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 4, id, '{"naziv":"Zaječarsko pivo PET","kolicina":"2 l","slika":"/artikli/8606105157360.webp","cena":305,"min":279.99,"max":316.66,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606105157360'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 5, id, '{"naziv":"Plazma keks","kolicina":"150 g","slika":"/artikli/8600043000016.webp","cena":158,"min":152.99,"max":159.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600043000016'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 1, id, '{"naziv":"Frikom pomfrit","kolicina":"1 kg","slika":"/artikli/8606006081252.webp","cena":389,"min":382.99,"max":399.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606006081252'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 2, id, '{"naziv":"Carnex domaća kobasica","kolicina":"310 g","slika":"/artikli/8600012503975.webp","cena":321,"min":272.49,"max":359.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600012503975'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 3, id, '{"naziv":"Parodontax pasta za zube","kolicina":"75 ml","slika":"/artikli/5054563949936.webp","cena":639,"min":428.99,"max":701.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '5054563949936'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 4, id, '{"naziv":"Ajax za podove","kolicina":"1 l","slika":"/artikli/8718951278486.webp","cena":334,"min":269.99,"max":389,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8718951278486'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 5, id, '{"naziv":"Plazma Stiksi","kolicina":"125 g","slika":"/artikli/8600043029512.webp","cena":250,"min":217.99,"max":270.67,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600043029512'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 1, id, '{"naziv":"Carnex delikates viršla","kolicina":"205 g","slika":"/artikli/8600012502510.webp","cena":211,"min":196.99,"max":229.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600012502510'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 2, id, '{"naziv":"Frikom Kapri sladoled","kolicina":"70 ml","slika":"/artikli/8606006080088.webp","cena":99,"min":89.99,"max":102.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606006080088'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 3, id, '{"naziv":"Indomie nudle govedina 5 kom","kolicina":"350 g","slika":"/artikli/8606108584132.webp","cena":245,"min":199.99,"max":279.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606108584132'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 4, id, '{"naziv":"Gorki list","kolicina":"1 l","slika":"/artikli/8606001830992.webp","cena":1504,"min":1364.99,"max":1599.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606001830992'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 5, id, '{"naziv":"Plazma od srca lešnik","kolicina":"100 g","slika":"/artikli/8600043036794.webp","cena":197,"min":184.99,"max":205.7,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600043036794'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 1, id, '{"naziv":"Moja Kravica jogurt 2,8%","kolicina":"1,75 kg","slika":"/artikli/8601500138495.webp","cena":233,"min":224.99,"max":240.09,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8601500138495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 2, id, '{"naziv":"Čačanski čips classic","kolicina":"90 g","slika":"/artikli/8606107718699.webp","cena":133,"min":119.99,"max":141.49,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606107718699'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 3, id, '{"naziv":"Štark Čajni keksići","kolicina":"800 g","slika":"/artikli/8600939841204.webp","cena":323,"min":313.99,"max":349.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600939841204'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 4, id, '{"naziv":"Carnex jetrena pašteta","kolicina":"75 g","slika":"/artikli/86002783.webp","cena":89,"min":79.99,"max":99.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '86002783'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 5, id, '{"naziv":"Eurocrem činija","kolicina":"500 g","slika":"/artikli/8601900503411.webp","cena":480,"min":399.99,"max":543.32,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8601900503411'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 1, id, '{"naziv":"Zlatiborac dimljeni vrat slajs","kolicina":"125 g","slika":"/artikli/8606018041855.webp","cena":256,"min":149.99,"max":306.32,"najjeftinije":"Gomex","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606018041855'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 2, id, '{"naziv":"Aperol","kolicina":"0,7 l","slika":"/artikli/8002230000302.webp","cena":2204,"min":1999.99,"max":2292.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8002230000302'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 3, id, '{"naziv":"Moja Kravica krem sir","kolicina":"200 g","slika":"/artikli/8601500119609.webp","cena":194,"min":179.99,"max":201.49,"najjeftinije":"Gomex","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8601500119609'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 4, id, '{"naziv":"Smoki","kolicina":"80 g","slika":"/artikli/8600939508190.webp","cena":74,"min":69.99,"max":76.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600939508190'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 5, id, '{"naziv":"Zaječarsko pivo limenka","kolicina":"0,5 l","slika":"/artikli/8600649000427.webp","cena":96,"min":89.99,"max":104.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600649000427'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 1, id, '{"naziv":"Najlepše želje crna sa bananicom","kolicina":"184 g","slika":"/artikli/8600939334171.webp","cena":367,"min":349.99,"max":389.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600939334171'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 2, id, '{"naziv":"Nikšićko pivo limenka","kolicina":"0,5 l","slika":"/artikli/8600105001678.webp","cena":105,"min":96.99,"max":114.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600105001678'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 3, id, '{"naziv":"Amstel pivo limenka","kolicina":"0,5 l","slika":"/artikli/8606105157513.webp","cena":93,"min":87.99,"max":97.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606105157513'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 4, id, '{"naziv":"Lino Lada Duo","kolicina":"350 g","slika":"/artikli/3850104267116.webp","cena":473,"min":449.99,"max":499.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '3850104267116'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 5, id, '{"naziv":"Guarana limenka","kolicina":"0,5 l","slika":"/artikli/8600037000442.webp","cena":96,"min":94.99,"max":99.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600037000442'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 1, id, '{"naziv":"Frikom Macho sladoled","kolicina":"75 ml","slika":"/artikli/8606006080064.webp","cena":148,"min":129.99,"max":153.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606006080064'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 2, id, '{"naziv":"Kraš Ki-Ki Tutti frutti bombone","kolicina":"100 g","slika":"/artikli/3850102516704.webp","cena":160,"min":130.49,"max":179.64,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '3850102516704'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 3, id, '{"naziv":"Fanta narandža limenka","kolicina":"0,33 l","slika":"/artikli/5449000214805.webp","cena":88,"min":76.99,"max":99.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '5449000214805'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 4, id, '{"naziv":"Plazma keks","kolicina":"300 g","slika":"/artikli/8600043000023.webp","cena":289,"min":279.99,"max":294.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600043000023'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 5, id, '{"naziv":"Danubius brašno T-500","kolicina":"1 kg","slika":"/artikli/8601300046006.webp","cena":81,"min":78.65,"max":88.73,"najjeftinije":"Idea","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8601300046006'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 1, id, '{"naziv":"Medela štrudla","kolicina":"240 g","slika":"/artikli/8600104004458.webp","cena":150,"min":139.99,"max":157.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600104004458'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 2, id, '{"naziv":"Doncafe Moment kafa","kolicina":"200 g","slika":"/artikli/8600101521439.webp","cena":471,"min":449.99,"max":483.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600101521439'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 3, id, '{"naziv":"Jelen pivo flaša","kolicina":"0,5 l","slika":"/artikli/86027618.webp","cena":91,"min":89.99,"max":94.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '86027618'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 4, id, '{"naziv":"Grekos šumsko voće","kolicina":"150 g","slika":"/artikli/8601500124252.webp","cena":96,"min":89.99,"max":101.32,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8601500124252'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 5, id, '{"naziv":"Fairy limun","kolicina":"900 ml","slika":"/artikli/8700216550734.webp","cena":386,"min":324.99,"max":449.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8700216550734'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-28', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-28', 2, 1, id, '{"naziv":"Neoplanta namaz u crevu","kolicina":"125 g","slika":"/artikli/8600763025559.webp","cena":97,"min":91.99,"max":104.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600763025559'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-28', 2, 2, id, '{"naziv":"Snickers","kolicina":"50 g","slika":"/artikli/5900951311505.webp","cena":95,"min":84.99,"max":99.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '5900951311505'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-28', 2, 3, id, '{"naziv":"Frikom grašak","kolicina":"400 g","slika":"/artikli/8606029610019.webp","cena":166,"min":149.99,"max":179.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8606029610019'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-28', 2, 4, id, '{"naziv":"Pionir mix Negro i Karamela lešnik","kolicina":"250 g","slika":"/artikli/8602300233229.webp","cena":264,"min":252.99,"max":286.16,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8602300233229'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-28', 2, 5, id, '{"naziv":"Knjaz Miloš sa limunom","kolicina":"1,25 l","slika":"/artikli/8600037003269.webp","cena":87,"min":79.99,"max":93.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-20"}'::jsonb
  from public.products where barcode = '8600037003269'
  on conflict (quiz_date, segment, position) do nothing;

-- Isto što i migracija 0002: ponovljeno ovde da seed radi i ako ona nije puštena.
create unique index if not exists trend_pairs_par_idx on public.trend_pairs (term_a, term_b, period);

-- Dueli pojmova (trends.json). Postojeći se osvežavaju.
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Srpski jezik', 'Nikola Jokić', 46, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kopaonik', 'Nikola Jokić', 100, 55, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kopaonik', 'BMW', 33, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Paradajz', 'BMW', 29, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Subotica', 'BMW', 100, 67, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Baklava', 'Burek', 77, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Šljiva', 'Burek', 100, 34, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Šljiva', 'WhatsApp', 55, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Čaj', 'WhatsApp', 100, 62, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Čaj', 'Matematika', 100, 26, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Gibanica', 'Ribarska Banja', 100, 77, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Gibanica', 'Orhideja', 69, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Bogdan Bogdanović', 'Orhideja', 70, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Grožđe', 'Orhideja', 100, 55, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Grožđe', 'Halo oglasi', 32, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Stara planina', 'Kupus', 28, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Mercedes', 'Kupus', 100, 34, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Mercedes', 'Rakija', 100, 55, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Mercedes', 'Polovni automobili', 32, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Facebook', 'Polovni automobili', 100, 53, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Punjene paprike', 'Baklava', 53, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Matematika', 'Baklava', 100, 35, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Matematika', 'Usisivač', 38, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Škoda', 'Usisivač', 69, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Xiaomi', 'Usisivač', 100, 68, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Prolom Banja', 'Gulaš', 26, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Dušan Tadić', 'Gulaš', 20, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Ceca', 'Gulaš', 100, 45, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Ceca', 'Paradajz', 59, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Mercedes', 'Paradajz', 100, 49, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vanilice', 'Sarma', 52, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Istorija', 'Sarma', 100, 34, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Istorija', 'Zaječar', 37, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Hrvatska', 'Zaječar', 100, 32, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Hrvatska', 'Instagram', 53, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Ljubičica', 'Geografija', 30, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Palačinke', 'Geografija', 100, 22, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Palačinke', 'Opel', 42, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Košarka', 'Opel', 100, 40, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Košarka', 'Crna Gora', 100, 74, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Podvarak', 'Aleksandar Mitrović', 100, 39, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Podvarak', 'Božur', 75, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Burek', 'Božur', 100, 43, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Burek', 'Huawei', 42, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vaterpolo', 'Huawei', 100, 61, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Viber', 'Nokia', 100, 30, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Viber', 'Klima', 49, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Grčka', 'Klima', 100, 41, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Grčka', 'Polovni automobili', 61, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Tenis', 'Polovni automobili', 36, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Tulumbe', 'Lala', 26, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Lubenica', 'Lala', 100, 61, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Lubenica', 'Krastavac', 76, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Divčibare', 'Krastavac', 100, 46, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Divčibare', 'Pasulj', 100, 44, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Punjene paprike', 'Stara planina', 55, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Limundo', 'Stara planina', 100, 29, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Limundo', 'TikTok', 23, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('iPhone', 'TikTok', 100, 57, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('iPhone', 'Vremenska prognoza', 25, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pivo', 'Sokobanja', 100, 77, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pivo', 'Horoskop', 41, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Halo oglasi', 'Horoskop', 41, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Facebook', 'Horoskop', 100, 24, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Facebook', 'Novi Sad', 50, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Dušan Vlahović', 'Veš mašina', 20, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vrnjačka Banja', 'Veš mašina', 100, 78, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vrnjačka Banja', 'Turska', 66, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Samsung', 'Turska', 100, 66, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Samsung', 'Vino', 100, 43, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;

-- Dnevni kviz: segment 3 (Šta se više gugla). Pobednik duela ostaje i u sledećem.
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 1, id, '{"a":"Srpski jezik","b":"Nikola Jokić","indeksA":46,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Srpski jezik' and term_b = 'Nikola Jokić' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 2, id, '{"a":"Kopaonik","b":"Nikola Jokić","indeksA":100,"indeksB":55,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Kopaonik' and term_b = 'Nikola Jokić' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 3, id, '{"a":"Kopaonik","b":"BMW","indeksA":33,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Kopaonik' and term_b = 'BMW' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 4, id, '{"a":"Paradajz","b":"BMW","indeksA":29,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Paradajz' and term_b = 'BMW' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 5, id, '{"a":"Subotica","b":"BMW","indeksA":100,"indeksB":67,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Subotica' and term_b = 'BMW' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 1, id, '{"a":"Baklava","b":"Burek","indeksA":77,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Baklava' and term_b = 'Burek' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 2, id, '{"a":"Šljiva","b":"Burek","indeksA":100,"indeksB":34,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Šljiva' and term_b = 'Burek' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 3, id, '{"a":"Šljiva","b":"WhatsApp","indeksA":55,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Šljiva' and term_b = 'WhatsApp' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 4, id, '{"a":"Čaj","b":"WhatsApp","indeksA":100,"indeksB":62,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Čaj' and term_b = 'WhatsApp' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 5, id, '{"a":"Čaj","b":"Matematika","indeksA":100,"indeksB":26,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Čaj' and term_b = 'Matematika' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 1, id, '{"a":"Gibanica","b":"Ribarska Banja","indeksA":100,"indeksB":77,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Gibanica' and term_b = 'Ribarska Banja' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 2, id, '{"a":"Gibanica","b":"Orhideja","indeksA":69,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Gibanica' and term_b = 'Orhideja' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 3, id, '{"a":"Bogdan Bogdanović","b":"Orhideja","indeksA":70,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Bogdan Bogdanović' and term_b = 'Orhideja' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 4, id, '{"a":"Grožđe","b":"Orhideja","indeksA":100,"indeksB":55,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Grožđe' and term_b = 'Orhideja' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 5, id, '{"a":"Grožđe","b":"Halo oglasi","indeksA":32,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Grožđe' and term_b = 'Halo oglasi' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 1, id, '{"a":"Stara planina","b":"Kupus","indeksA":28,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Stara planina' and term_b = 'Kupus' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 2, id, '{"a":"Mercedes","b":"Kupus","indeksA":100,"indeksB":34,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Mercedes' and term_b = 'Kupus' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 3, id, '{"a":"Mercedes","b":"Rakija","indeksA":100,"indeksB":55,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Mercedes' and term_b = 'Rakija' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 4, id, '{"a":"Mercedes","b":"Polovni automobili","indeksA":32,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Mercedes' and term_b = 'Polovni automobili' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 5, id, '{"a":"Facebook","b":"Polovni automobili","indeksA":100,"indeksB":53,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Facebook' and term_b = 'Polovni automobili' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 1, id, '{"a":"Punjene paprike","b":"Baklava","indeksA":53,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Punjene paprike' and term_b = 'Baklava' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 2, id, '{"a":"Matematika","b":"Baklava","indeksA":100,"indeksB":35,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Matematika' and term_b = 'Baklava' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 3, id, '{"a":"Matematika","b":"Usisivač","indeksA":38,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Matematika' and term_b = 'Usisivač' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 4, id, '{"a":"Škoda","b":"Usisivač","indeksA":69,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Škoda' and term_b = 'Usisivač' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 5, id, '{"a":"Xiaomi","b":"Usisivač","indeksA":100,"indeksB":68,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Xiaomi' and term_b = 'Usisivač' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 1, id, '{"a":"Prolom Banja","b":"Gulaš","indeksA":26,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Prolom Banja' and term_b = 'Gulaš' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 2, id, '{"a":"Dušan Tadić","b":"Gulaš","indeksA":20,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Dušan Tadić' and term_b = 'Gulaš' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 3, id, '{"a":"Ceca","b":"Gulaš","indeksA":100,"indeksB":45,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Ceca' and term_b = 'Gulaš' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 4, id, '{"a":"Ceca","b":"Paradajz","indeksA":59,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Ceca' and term_b = 'Paradajz' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 5, id, '{"a":"Mercedes","b":"Paradajz","indeksA":100,"indeksB":49,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Mercedes' and term_b = 'Paradajz' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 1, id, '{"a":"Vanilice","b":"Sarma","indeksA":52,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vanilice' and term_b = 'Sarma' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 2, id, '{"a":"Istorija","b":"Sarma","indeksA":100,"indeksB":34,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Istorija' and term_b = 'Sarma' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 3, id, '{"a":"Istorija","b":"Zaječar","indeksA":37,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Istorija' and term_b = 'Zaječar' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 4, id, '{"a":"Hrvatska","b":"Zaječar","indeksA":100,"indeksB":32,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Hrvatska' and term_b = 'Zaječar' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 5, id, '{"a":"Hrvatska","b":"Instagram","indeksA":53,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Hrvatska' and term_b = 'Instagram' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 1, id, '{"a":"Ljubičica","b":"Geografija","indeksA":30,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Ljubičica' and term_b = 'Geografija' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 2, id, '{"a":"Palačinke","b":"Geografija","indeksA":100,"indeksB":22,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Palačinke' and term_b = 'Geografija' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 3, id, '{"a":"Palačinke","b":"Opel","indeksA":42,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Palačinke' and term_b = 'Opel' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 4, id, '{"a":"Košarka","b":"Opel","indeksA":100,"indeksB":40,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Košarka' and term_b = 'Opel' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 5, id, '{"a":"Košarka","b":"Crna Gora","indeksA":100,"indeksB":74,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Košarka' and term_b = 'Crna Gora' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 1, id, '{"a":"Podvarak","b":"Aleksandar Mitrović","indeksA":100,"indeksB":39,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Podvarak' and term_b = 'Aleksandar Mitrović' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 2, id, '{"a":"Podvarak","b":"Božur","indeksA":75,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Podvarak' and term_b = 'Božur' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 3, id, '{"a":"Burek","b":"Božur","indeksA":100,"indeksB":43,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Burek' and term_b = 'Božur' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 4, id, '{"a":"Burek","b":"Huawei","indeksA":42,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Burek' and term_b = 'Huawei' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 5, id, '{"a":"Vaterpolo","b":"Huawei","indeksA":100,"indeksB":61,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vaterpolo' and term_b = 'Huawei' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 1, id, '{"a":"Viber","b":"Nokia","indeksA":100,"indeksB":30,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Viber' and term_b = 'Nokia' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 2, id, '{"a":"Viber","b":"Klima","indeksA":49,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Viber' and term_b = 'Klima' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 3, id, '{"a":"Grčka","b":"Klima","indeksA":100,"indeksB":41,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Grčka' and term_b = 'Klima' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 4, id, '{"a":"Grčka","b":"Polovni automobili","indeksA":61,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Grčka' and term_b = 'Polovni automobili' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 5, id, '{"a":"Tenis","b":"Polovni automobili","indeksA":36,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Tenis' and term_b = 'Polovni automobili' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 1, id, '{"a":"Tulumbe","b":"Lala","indeksA":26,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Tulumbe' and term_b = 'Lala' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 2, id, '{"a":"Lubenica","b":"Lala","indeksA":100,"indeksB":61,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Lubenica' and term_b = 'Lala' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 3, id, '{"a":"Lubenica","b":"Krastavac","indeksA":76,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Lubenica' and term_b = 'Krastavac' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 4, id, '{"a":"Divčibare","b":"Krastavac","indeksA":100,"indeksB":46,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Divčibare' and term_b = 'Krastavac' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 5, id, '{"a":"Divčibare","b":"Pasulj","indeksA":100,"indeksB":44,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Divčibare' and term_b = 'Pasulj' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 1, id, '{"a":"Punjene paprike","b":"Stara planina","indeksA":55,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Punjene paprike' and term_b = 'Stara planina' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 2, id, '{"a":"Limundo","b":"Stara planina","indeksA":100,"indeksB":29,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Limundo' and term_b = 'Stara planina' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 3, id, '{"a":"Limundo","b":"TikTok","indeksA":23,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Limundo' and term_b = 'TikTok' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 4, id, '{"a":"iPhone","b":"TikTok","indeksA":100,"indeksB":57,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'iPhone' and term_b = 'TikTok' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 5, id, '{"a":"iPhone","b":"Vremenska prognoza","indeksA":25,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'iPhone' and term_b = 'Vremenska prognoza' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 1, id, '{"a":"Pivo","b":"Sokobanja","indeksA":100,"indeksB":77,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Pivo' and term_b = 'Sokobanja' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 2, id, '{"a":"Pivo","b":"Horoskop","indeksA":41,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Pivo' and term_b = 'Horoskop' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 3, id, '{"a":"Halo oglasi","b":"Horoskop","indeksA":41,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Halo oglasi' and term_b = 'Horoskop' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 4, id, '{"a":"Facebook","b":"Horoskop","indeksA":100,"indeksB":24,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Facebook' and term_b = 'Horoskop' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 5, id, '{"a":"Facebook","b":"Novi Sad","indeksA":50,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Facebook' and term_b = 'Novi Sad' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-28', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-28', 3, 1, id, '{"a":"Dušan Vlahović","b":"Veš mašina","indeksA":20,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Dušan Vlahović' and term_b = 'Veš mašina' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-28', 3, 2, id, '{"a":"Vrnjačka Banja","b":"Veš mašina","indeksA":100,"indeksB":78,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vrnjačka Banja' and term_b = 'Veš mašina' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-28', 3, 3, id, '{"a":"Vrnjačka Banja","b":"Turska","indeksA":66,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vrnjačka Banja' and term_b = 'Turska' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-28', 3, 4, id, '{"a":"Samsung","b":"Turska","indeksA":100,"indeksB":66,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Samsung' and term_b = 'Turska' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-28', 3, 5, id, '{"a":"Samsung","b":"Vino","indeksA":100,"indeksB":43,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Samsung' and term_b = 'Vino' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;

-- Filmovi i serije (films.json) i njihovi kadrovi.
insert into public.films (title, aliases) values ('Apsolutnih sto', array['Apsolutnih 100']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/d9743ac1239e02.webp' from public.films where title = 'Apsolutnih sto'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Balkanski špijun', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/266f47b4bf4330.webp' from public.films where title = 'Balkanski špijun'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Greh njene majke', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/98c04ce7ffd86f.webp' from public.films where title = 'Greh njene majke'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Ivkova slava', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/64db2b1fcfaceb.webp' from public.films where title = 'Ivkova slava'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Južni vetar', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/b54ac478dd9f9e.webp' from public.films where title = 'Južni vetar'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Kad porastem biću Kengur', array['Kengur']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/2342208e45e0d5.webp' from public.films where title = 'Kad porastem biću Kengur'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Ko to tamo peva', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/dfd186e39dc288.webp' from public.films where title = 'Ko to tamo peva'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Lajanje na zvezde', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/910755bdb2d3ed.webp' from public.films where title = 'Lajanje na zvezde'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Lepa sela lepo gore', array['Lepa sela']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/27aca52c471053.webp' from public.films where title = 'Lepa sela lepo gore'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Mali Budo', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/8d3472b446bb96.webp' from public.films where title = 'Mali Budo'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Maratonci trče počasni krug', array['Maratonci']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/26fcfdf6ce0b4e.webp' from public.films where title = 'Maratonci trče počasni krug'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Montevideo, Bog te video!', array['Montevideo']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/c9bf06d591b178.webp' from public.films where title = 'Montevideo, Bog te video!'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Mrtav ''ladan', array['Mrtav hladan']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/8cbcf42b3b8c7c.webp' from public.films where title = 'Mrtav ''ladan'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Munje!', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/b78562811e4dfd.webp' from public.films where title = 'Munje!'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Nedelja', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/3a05c0c3d6723a.webp' from public.films where title = 'Nedelja'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Nož', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/0f95a920c25413.webp' from public.films where title = 'Nož'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Parada', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/5d7b9193da21b5.webp' from public.films where title = 'Parada'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Ranjeni orao', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/051f731cbbfa6a.webp' from public.films where title = 'Ranjeni orao'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Sedam i po', array['7 i po']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/51593cb69f6231.webp' from public.films where title = 'Sedam i po'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Senke nad Balkanom', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/99e6fa37dacc76.webp' from public.films where title = 'Senke nad Balkanom'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Svadba', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/3f44ee5376ac8f.webp' from public.films where title = 'Svadba'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Tesna koža', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/3888635e9b8672.webp' from public.films where title = 'Tesna koža'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Toma', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/35d341e7bddb04.webp' from public.films where title = 'Toma'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Ubice mog oca', array['Ubice moga oca']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/ce43a77331335f.webp' from public.films where title = 'Ubice mog oca'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Valter brani Sarajevo', array['Valter']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/aea6ef7f9e918e.webp' from public.films where title = 'Valter brani Sarajevo'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Varljivo leto ''68', array['Varljivo leto']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/69d278902e4c57.webp' from public.films where title = 'Varljivo leto ''68'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Zlatni dečko', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/e21b6c218911f0.webp' from public.films where title = 'Zlatni dečko'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Zona Zamfirova', array['Zona']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/0b6135f7ced4ae.webp' from public.films where title = 'Zona Zamfirova'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Bure baruta', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/74b285817c422d.webp' from public.films where title = 'Bure baruta'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Crna mačka, beli mačor', array['Crna macka beli macor', 'Crna mačka beli mačor']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/815ef857493258.webp' from public.films where title = 'Crna mačka, beli mačor'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Rane', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/c99d5b262921f8.webp' from public.films where title = 'Rane'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Balkan ekspres', array['Balkan express']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/40758b744a158d.webp' from public.films where title = 'Balkan ekspres'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Davitelj protiv davitelja', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/475499fe954c78.webp' from public.films where title = 'Davitelj protiv davitelja'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Specijalno vaspitanje', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/cf8f4eb466be71.webp' from public.films where title = 'Specijalno vaspitanje'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Nacionalna klasa', array['Nacionalna klasa do 785 ccm']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/24e7f57eb62a7a.webp' from public.films where title = 'Nacionalna klasa'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Sabirni centar', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/96191c6c5dfe01.webp' from public.films where title = 'Sabirni centar'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Profesionalac', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/a0b756ac7d58a6.webp' from public.films where title = 'Profesionalac'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Šešir profesora Koste Vujića', array['Sesir profesora Koste Vujica', 'Šešir profesora Koste Vujića']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/8e4827fa81a5a1.webp' from public.films where title = 'Šešir profesora Koste Vujića'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Mi nismo anđeli', array['Mi nismo andjeli']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/cb0e6b8b55a0c5.webp' from public.films where title = 'Mi nismo anđeli'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Klopka', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/fb36900e61d6aa.webp' from public.films where title = 'Klopka'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Šišanje', array['Sisanje']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/bb91d77d17150f.webp' from public.films where title = 'Šišanje'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Pljačka Trećeg rajha', array['Pljacka Treceg rajha']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/7b5ddf833ead4f.webp' from public.films where title = 'Pljačka Trećeg rajha'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Bićemo prvaci sveta', array['Bicemo prvaci sveta']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/6608c3c93a6f88.webp' from public.films where title = 'Bićemo prvaci sveta'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Rat uživo', array['Rat uzivo']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/92105c1d5bec10.webp' from public.films where title = 'Rat uživo'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Tri karte za Holivud', array['Tri karte za Hollywood', '3 karte za Holivud']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/1e435737ce5c41.webp' from public.films where title = 'Tri karte za Holivud'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Tito i ja', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/af6ba14c599ee1.webp' from public.films where title = 'Tito i ja'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Hajde da se volimo', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/94d73fc8280f41.webp' from public.films where title = 'Hajde da se volimo'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Bitka na Neretvi', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/1b462c40f445da.webp' from public.films where title = 'Bitka na Neretvi'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Sutjeska', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/3c79020045efac.webp' from public.films where title = 'Sutjeska'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Do koske', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/611f72c23394d1.webp' from public.films where title = 'Do koske'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Šejtanov ratnik', array['Sejtanov ratnik']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/a27705799c0360.webp' from public.films where title = 'Šejtanov ratnik'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Nebeska udica', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/49c857d84cf8c5.webp' from public.films where title = 'Nebeska udica'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Optimisti', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/2af1981e962872.webp' from public.films where title = 'Optimisti'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Sivi kamion crvene boje', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/caa7dafe578391.webp' from public.films where title = 'Sivi kamion crvene boje'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Kordon', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/993e6e8ad2a766.webp' from public.films where title = 'Kordon'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Crni bombarder', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/20afe8e5697f5e.webp' from public.films where title = 'Crni bombarder'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Dara iz Jasenovca', array['Dara']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/85cededd2ae9e6.webp' from public.films where title = 'Dara iz Jasenovca'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Klip', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/768356be9926e8.webp' from public.films where title = 'Klip'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Žikina dinastija', array['Zikina dinastija']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/7caff866e1531a.webp' from public.films where title = 'Žikina dinastija'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Kako je propao rokenrol', array['Kako je propao rock and roll', 'Kako je propao rokenrol']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/ee4e6dfb5ae293.webp' from public.films where title = 'Kako je propao rokenrol'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Policajac sa Petlovog brda', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/7f0916c186db67.webp' from public.films where title = 'Policajac sa Petlovog brda'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Kamiondžije', array['Kamiondzije']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/590ef52fc7ce0e.webp' from public.films where title = 'Kamiondžije'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Vruć vetar', array['Vruc vetar']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/e0c2b74e66b4fb.webp' from public.films where title = 'Vruć vetar'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Pozorište u kući', array['Pozoriste u kuci']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/90491ad532233f.webp' from public.films where title = 'Pozorište u kući'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Grlom u jagode', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/0f55d2c18c9621.webp' from public.films where title = 'Grlom u jagode'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Bolji život', array['Bolji zivot']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/5c0d43bd1d2c40.webp' from public.films where title = 'Bolji život'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Srećni ljudi', array['Srecni ljudi']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/f43da492ce7348.webp' from public.films where title = 'Srećni ljudi'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Porodično blago', array['Porodicno blago']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/60e879f7cad016.webp' from public.films where title = 'Porodično blago'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Otpisani', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/b8f13353e4e2da.webp' from public.films where title = 'Otpisani'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Bela lađa', array['Bela ladja']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/85f3f207a3824e.webp' from public.films where title = 'Bela lađa'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Ljubav, navika, panika', array['Ljubav navika panika']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/65012fcfbb7afe.webp' from public.films where title = 'Ljubav, navika, panika'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Selo gori, a baba se češlja', array['Selo gori a baba se češlja', 'Selo gori a baba se ceslja', 'Selo gori']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/6f82de1bc35654.webp' from public.films where title = 'Selo gori, a baba se češlja'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Vratiće se rode', array['Vratice se rode']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/9afa3a43af7b67.webp' from public.films where title = 'Vratiće se rode'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Sinđelići', array['Sindjelici']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/e02acc8c48dad1.webp' from public.films where title = 'Sinđelići'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Žigosani u reketu', array['Zigosani u reketu']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/f036f1bb7a3ecb.webp' from public.films where title = 'Žigosani u reketu'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Jagodići', array['Jagodici']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/6292e6931ffa64.webp' from public.films where title = 'Jagodići'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Moj rođak sa sela', array['Moj rodjak sa sela']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/eed1aeb8fcddfb.webp' from public.films where title = 'Moj rođak sa sela'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Folk', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/a79d33664812e8.webp' from public.films where title = 'Folk'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Klan', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/d6ed304bf63361.webp' from public.films where title = 'Klan'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Igra sudbine', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/123f51054e1241.webp' from public.films where title = 'Igra sudbine'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Državni službenik', array['Drzavni sluzbenik']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/a5ad4f1ef525b8.webp' from public.films where title = 'Državni službenik'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Besa', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/87b39c6b1298a0.webp' from public.films where title = 'Besa'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Miris kiše na Balkanu', array['Miris kise na Balkanu']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/b6d5176dccb6d2.webp' from public.films where title = 'Miris kiše na Balkanu'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Andrija i Anđelka', array['Andrija i Andjelka']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/cc67547c38c055.webp' from public.films where title = 'Andrija i Anđelka'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Vojna akademija', '{}'::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/0bad9e59555c34.webp' from public.films where title = 'Vojna akademija'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Nečista krv: Greh predaka', array['Nečista krv', 'Necista krv', 'Necista krv Greh predaka']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/a127d46f4324bc.webp' from public.films where title = 'Nečista krv: Greh predaka'
  on conflict (image_url) do nothing;
insert into public.films (title, aliases) values ('Jutro će promeniti sve', array['Jutro ce promeniti sve']::text[])
  on conflict (title) do update set aliases = excluded.aliases, active = true;
insert into public.film_stills (film_id, image_url) select id, '/kadrovi/9e2d03e0873135.webp' from public.films where title = 'Jutro će promeniti sve'
  on conflict (image_url) do nothing;

-- Dnevni kviz: segment 4 (Pogodi domaći film/seriju). Dan koji već ima stavke se ne dira.
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-15', 4, 1, id, '{"naslov":"Kamiondžije","alias":["Kamiondzije"],"slika":"/kadrovi/590ef52fc7ce0e.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/590ef52fc7ce0e.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-15', 4, 2, id, '{"naslov":"Crni bombarder","alias":[],"slika":"/kadrovi/20afe8e5697f5e.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/20afe8e5697f5e.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-15', 4, 3, id, '{"naslov":"Varljivo leto ''68","alias":["Varljivo leto"],"slika":"/kadrovi/69d278902e4c57.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/69d278902e4c57.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-16', 4, 1, id, '{"naslov":"Vratiće se rode","alias":["Vratice se rode"],"slika":"/kadrovi/9afa3a43af7b67.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/9afa3a43af7b67.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-16', 4, 2, id, '{"naslov":"Bure baruta","alias":[],"slika":"/kadrovi/74b285817c422d.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/74b285817c422d.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-16', 4, 3, id, '{"naslov":"Do koske","alias":[],"slika":"/kadrovi/611f72c23394d1.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/611f72c23394d1.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-17', 4, 1, id, '{"naslov":"Pljačka Trećeg rajha","alias":["Pljacka Treceg rajha"],"slika":"/kadrovi/7b5ddf833ead4f.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/7b5ddf833ead4f.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-17', 4, 2, id, '{"naslov":"Ubice mog oca","alias":["Ubice moga oca"],"slika":"/kadrovi/ce43a77331335f.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/ce43a77331335f.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-17', 4, 3, id, '{"naslov":"Šišanje","alias":["Sisanje"],"slika":"/kadrovi/bb91d77d17150f.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/bb91d77d17150f.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-18', 4, 1, id, '{"naslov":"Ranjeni orao","alias":[],"slika":"/kadrovi/051f731cbbfa6a.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/051f731cbbfa6a.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-18', 4, 2, id, '{"naslov":"Kordon","alias":[],"slika":"/kadrovi/993e6e8ad2a766.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/993e6e8ad2a766.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-18', 4, 3, id, '{"naslov":"Nedelja","alias":[],"slika":"/kadrovi/3a05c0c3d6723a.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/3a05c0c3d6723a.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-19', 4, 1, id, '{"naslov":"Vruć vetar","alias":["Vruc vetar"],"slika":"/kadrovi/e0c2b74e66b4fb.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/e0c2b74e66b4fb.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-19', 4, 2, id, '{"naslov":"Optimisti","alias":[],"slika":"/kadrovi/2af1981e962872.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/2af1981e962872.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-19', 4, 3, id, '{"naslov":"Andrija i Anđelka","alias":["Andrija i Andjelka"],"slika":"/kadrovi/cc67547c38c055.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/cc67547c38c055.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-20', 4, 1, id, '{"naslov":"Balkanski špijun","alias":[],"slika":"/kadrovi/266f47b4bf4330.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/266f47b4bf4330.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-20', 4, 2, id, '{"naslov":"Kako je propao rokenrol","alias":["Kako je propao rock and roll","Kako je propao rokenrol"],"slika":"/kadrovi/ee4e6dfb5ae293.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/ee4e6dfb5ae293.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-20', 4, 3, id, '{"naslov":"Jagodići","alias":["Jagodici"],"slika":"/kadrovi/6292e6931ffa64.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/6292e6931ffa64.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-21', 4, 1, id, '{"naslov":"Sinđelići","alias":["Sindjelici"],"slika":"/kadrovi/e02acc8c48dad1.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/e02acc8c48dad1.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-21', 4, 2, id, '{"naslov":"Bitka na Neretvi","alias":[],"slika":"/kadrovi/1b462c40f445da.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/1b462c40f445da.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-21', 4, 3, id, '{"naslov":"Sivi kamion crvene boje","alias":[],"slika":"/kadrovi/caa7dafe578391.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/caa7dafe578391.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-22', 4, 1, id, '{"naslov":"Tri karte za Holivud","alias":["Tri karte za Hollywood","3 karte za Holivud"],"slika":"/kadrovi/1e435737ce5c41.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/1e435737ce5c41.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-22', 4, 2, id, '{"naslov":"Montevideo, Bog te video!","alias":["Montevideo"],"slika":"/kadrovi/c9bf06d591b178.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/c9bf06d591b178.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-22', 4, 3, id, '{"naslov":"Dara iz Jasenovca","alias":["Dara"],"slika":"/kadrovi/85cededd2ae9e6.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/85cededd2ae9e6.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-23', 4, 1, id, '{"naslov":"Južni vetar","alias":[],"slika":"/kadrovi/b54ac478dd9f9e.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/b54ac478dd9f9e.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-23', 4, 2, id, '{"naslov":"Nebeska udica","alias":[],"slika":"/kadrovi/49c857d84cf8c5.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/49c857d84cf8c5.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-23', 4, 3, id, '{"naslov":"Lajanje na zvezde","alias":[],"slika":"/kadrovi/910755bdb2d3ed.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/910755bdb2d3ed.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-24', 4, 1, id, '{"naslov":"Senke nad Balkanom","alias":[],"slika":"/kadrovi/99e6fa37dacc76.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/99e6fa37dacc76.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-24', 4, 2, id, '{"naslov":"Klan","alias":[],"slika":"/kadrovi/d6ed304bf63361.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/d6ed304bf63361.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-24', 4, 3, id, '{"naslov":"Mali Budo","alias":[],"slika":"/kadrovi/8d3472b446bb96.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/8d3472b446bb96.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-25', 4, 1, id, '{"naslov":"Crna mačka, beli mačor","alias":["Crna macka beli macor","Crna mačka beli mačor"],"slika":"/kadrovi/815ef857493258.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/815ef857493258.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-25', 4, 2, id, '{"naslov":"Balkan ekspres","alias":["Balkan express"],"slika":"/kadrovi/40758b744a158d.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/40758b744a158d.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-25', 4, 3, id, '{"naslov":"Toma","alias":[],"slika":"/kadrovi/35d341e7bddb04.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/35d341e7bddb04.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-26', 4, 1, id, '{"naslov":"Folk","alias":[],"slika":"/kadrovi/a79d33664812e8.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/a79d33664812e8.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-26', 4, 2, id, '{"naslov":"Sedam i po","alias":["7 i po"],"slika":"/kadrovi/51593cb69f6231.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/51593cb69f6231.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-26', 4, 3, id, '{"naslov":"Vojna akademija","alias":[],"slika":"/kadrovi/0bad9e59555c34.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/0bad9e59555c34.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-27', 4, 1, id, '{"naslov":"Nacionalna klasa","alias":["Nacionalna klasa do 785 ccm"],"slika":"/kadrovi/24e7f57eb62a7a.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/24e7f57eb62a7a.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-27', 4, 2, id, '{"naslov":"Otpisani","alias":[],"slika":"/kadrovi/b8f13353e4e2da.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/b8f13353e4e2da.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-27', 4, 3, id, '{"naslov":"Tesna koža","alias":[],"slika":"/kadrovi/3888635e9b8672.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/3888635e9b8672.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-28', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-28', 4, 1, id, '{"naslov":"Zlatni dečko","alias":[],"slika":"/kadrovi/e21b6c218911f0.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/e21b6c218911f0.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-28', 4, 2, id, '{"naslov":"Državni službenik","alias":["Drzavni sluzbenik"],"slika":"/kadrovi/a5ad4f1ef525b8.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/a5ad4f1ef525b8.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-28', 4, 3, id, '{"naslov":"Ljubav, navika, panika","alias":["Ljubav navika panika"],"slika":"/kadrovi/65012fcfbb7afe.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/65012fcfbb7afe.webp'
  on conflict (quiz_date, segment, position) do nothing;

-- Dnevni kviz: segment 5 (Joker pitanje). Dan koji već ima Jokera se ne dira.
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koja srpska starleta je učestvovala u Survivoru?', 'Stanija', array['Stanija Dobrojević', 'Dobrojević']::text[], '/joker/7a4788f53ff0db.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-15', 5, 1, id, '{"pitanje":"Koja srpska starleta je učestvovala u Survivoru?","odgovor":"Stanija","alias":["Stanija Dobrojević","Dobrojević"],"slika":"/joker/7a4788f53ff0db.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koja srpska starleta je učestvovala u Survivoru?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Šta povezuje Dragomira Despića i šumara?', 'Motorna testera', array['testera', 'motorka']::text[], '/joker/103bbf66b12f94.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-16', 5, 1, id, '{"pitanje":"Šta povezuje Dragomira Despića i šumara?","odgovor":"Motorna testera","alias":["testera","motorka"],"slika":"/joker/103bbf66b12f94.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Šta povezuje Dragomira Despića i šumara?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove čovek koji je na poznatom jutjub snimku eksirao vinjak i posle toga izgovorio čuveno „MRK” u kameru?', 'Srećko', array['Srećko Mrk', 'Mrk']::text[], '/joker/9efbc008ba617a.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-17', 5, 1, id, '{"pitanje":"Kako se zove čovek koji je na poznatom jutjub snimku eksirao vinjak i posle toga izgovorio čuveno „MRK” u kameru?","odgovor":"Srećko","alias":["Srećko Mrk","Mrk"],"slika":"/joker/9efbc008ba617a.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zove čovek koji je na poznatom jutjub snimku eksirao vinjak i posle toga izgovorio čuveno „MRK” u kameru?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koja pevačica je bila pratilja na maturi jutjubera 2016?', 'Sandra Afrika', array['Afrika']::text[], '/joker/adb8edf7649b14.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-18', 5, 1, id, '{"pitanje":"Koja pevačica je bila pratilja na maturi jutjubera 2016?","odgovor":"Sandra Afrika","alias":["Afrika"],"slika":"/joker/adb8edf7649b14.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koja pevačica je bila pratilja na maturi jutjubera 2016?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Ko je vodio emisiju „48 sati svadba”?', 'Miki Đuričić', array['Đuričić', 'Miki']::text[], '/joker/ef2766e699645a.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-19', 5, 1, id, '{"pitanje":"Ko je vodio emisiju „48 sati svadba”?","odgovor":"Miki Đuričić","alias":["Đuričić","Miki"],"slika":"/joker/ef2766e699645a.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Ko je vodio emisiju „48 sati svadba”?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove kafić iz „Lud, zbunjen, normalan”?', 'San Remo', array['Sanremo']::text[], '/joker/7f4374133fcd9c.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-20', 5, 1, id, '{"pitanje":"Kako se zove kafić iz „Lud, zbunjen, normalan”?","odgovor":"San Remo","alias":["Sanremo"],"slika":"/joker/7f4374133fcd9c.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zove kafić iz „Lud, zbunjen, normalan”?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove konj Nikole Jokića?', 'Dream Catcher', array['Drim Kečer', 'Dreamcatcher', 'Drim Kecer']::text[], '/joker/07370ab3fefdcc.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-21', 5, 1, id, '{"pitanje":"Kako se zove konj Nikole Jokića?","odgovor":"Dream Catcher","alias":["Drim Kečer","Dreamcatcher","Drim Kecer"],"slika":"/joker/07370ab3fefdcc.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zove konj Nikole Jokića?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zvala politička partija Srećka Šojića?', 'Stranka zdravog razuma', array['Zdrav razum', 'zdravog razuma', 'SZR']::text[], '/joker/59bebcb996ba5c.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-22', 5, 1, id, '{"pitanje":"Kako se zvala politička partija Srećka Šojića?","odgovor":"Stranka zdravog razuma","alias":["Zdrav razum","zdravog razuma","SZR"],"slika":"/joker/59bebcb996ba5c.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zvala politička partija Srećka Šojića?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji fudbaler je ugrizao protivnika na Svetskom prvenstvu 2014. godine?', 'Luis Suárez', array['Suarez', 'Luis Suarez', 'Suares', 'Luis Suares']::text[], '/joker/f952d80ea36e34.webp', null, '2014', 'Suárez ugrizao Kjelinija')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-23', 5, 1, id, '{"pitanje":"Koji fudbaler je ugrizao protivnika na Svetskom prvenstvu 2014. godine?","odgovor":"Luis Suárez","alias":["Suarez","Luis Suarez","Suares","Luis Suares"],"slika":"/joker/f952d80ea36e34.webp","slikaPitanja":null,"broj":"2014","natpis":"Suárez ugrizao Kjelinija"}'::jsonb
  from public.joker_questions where question = 'Koji fudbaler je ugrizao protivnika na Svetskom prvenstvu 2014. godine?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove splav koji je potonuo tokom dočeka Nove 2023. godine u Beogradu?', 'Freestyler', array['Fristajler', 'Free styler', 'Fri stajler']::text[], '/joker/a630246548c507.webp', null, '400+', 'gostiju na splavu za 220')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-24', 5, 1, id, '{"pitanje":"Kako se zove splav koji je potonuo tokom dočeka Nove 2023. godine u Beogradu?","odgovor":"Freestyler","alias":["Fristajler","Free styler","Fri stajler"],"slika":"/joker/a630246548c507.webp","slikaPitanja":null,"broj":"400+","natpis":"gostiju na splavu za 220"}'::jsonb
  from public.joker_questions where question = 'Kako se zove splav koji je potonuo tokom dočeka Nove 2023. godine u Beogradu?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji glumac je poznat po memu da ostavi devojku čim ona napuni 25 godina?', 'Leonardo DiCaprio', array['DiCaprio', 'Dikaprio', 'Leonardo Dikaprio', 'Leo']::text[], '/joker/127d0b2f596653.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-25', 5, 1, id, '{"pitanje":"Koji glumac je poznat po memu da ostavi devojku čim ona napuni 25 godina?","odgovor":"Leonardo DiCaprio","alias":["DiCaprio","Dikaprio","Leonardo Dikaprio","Leo"],"slika":"/joker/127d0b2f596653.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koji glumac je poznat po memu da ostavi devojku čim ona napuni 25 godina?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zvala stranka Ljubiše Preletačevića Belog?', 'Sarmu probo nisi', array['SPN', 'Sarmu probo nisi (SPN)', 'Sarmu proba nisi']::text[], '/joker/798e9f34db94be.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-26', 5, 1, id, '{"pitanje":"Kako se zvala stranka Ljubiše Preletačevića Belog?","odgovor":"Sarmu probo nisi","alias":["SPN","Sarmu probo nisi (SPN)","Sarmu proba nisi"],"slika":"/joker/798e9f34db94be.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zvala stranka Ljubiše Preletačevića Belog?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Na čijem koncertu je kiss cam 2025. godine otkrio jednu od najpraćenijih ljubavnih afera godine?', 'Coldplay', array['Koldplej', 'Cold play']::text[], '/joker/58badbf9671d03.webp', null, '2025', 'godina skandala')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-27', 5, 1, id, '{"pitanje":"Na čijem koncertu je kiss cam 2025. godine otkrio jednu od najpraćenijih ljubavnih afera godine?","odgovor":"Coldplay","alias":["Koldplej","Cold play"],"slika":"/joker/58badbf9671d03.webp","slikaPitanja":null,"broj":"2025","natpis":"godina skandala"}'::jsonb
  from public.joker_questions where question = 'Na čijem koncertu je kiss cam 2025. godine otkrio jednu od najpraćenijih ljubavnih afera godine?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji poznati milijarder je kupio društvenu mrežu Twitter i promenio joj naziv u X?', 'Elon Musk', array['Musk', 'Ilon Mask', 'Elon Mask', 'Mask']::text[], '/joker/ac5dedca885fc1.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-28', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-28', 5, 1, id, '{"pitanje":"Koji poznati milijarder je kupio društvenu mrežu Twitter i promenio joj naziv u X?","odgovor":"Elon Musk","alias":["Musk","Ilon Mask","Elon Mask","Mask"],"slika":"/joker/ac5dedca885fc1.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koji poznati milijarder je kupio društvenu mrežu Twitter i promenio joj naziv u X?'
  on conflict (quiz_date, segment, position) do nothing;
