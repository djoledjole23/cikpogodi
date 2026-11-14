-- Čik Pogodi! seed: 14 dana od 2026-11-14. Cenovnik od 2026-11-13.
-- Napravljeno komandom: npm run seed -- 2026-11-14 14

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

-- Dnevni kviz: segment 1 (Pogodi pesmu). Dan koji već ima stavke se ne dira.
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-14', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-14', 1, 1, id, '{"izvodjac":"Aca Lukas","naslov":"Kuda idu ljudi kao ja","alias":[],"deezerId":898922622,"itunesId":1794183990,"omot":"https://cdn-images.dzcdn.net/images/cover/1586b6461b881d4fdbb6f159414f2926/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 898922622
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-14', 1, 2, id, '{"izvodjac":"Kerber","naslov":"Seobe","alias":[],"deezerId":1523410982,"itunesId":1590828710,"omot":"https://cdn-images.dzcdn.net/images/cover/8f5c589408e426f6b63cd14ca4a8f292/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1523410982
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-14', 1, 3, id, '{"izvodjac":"Tea Tairović","naslov":"Hajde","alias":[],"deezerId":3769786922,"itunesId":1868457590,"omot":"https://cdn-images.dzcdn.net/images/cover/996740b19e3858696a09c2476d5b273e/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3769786922
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-14', 1, 4, id, '{"izvodjac":"Jala Brat, Buba Corelli & Devito","naslov":"Roze","alias":[],"deezerId":2826469112,"itunesId":1869458408,"omot":"https://cdn-images.dzcdn.net/images/cover/72997513f3c5926f05168759909990f4/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2826469112
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-14', 1, 5, id, '{"izvodjac":"Flamingosi","naslov":"Ludi letnji ples","alias":[],"deezerId":529456911,"itunesId":1578005436,"omot":"https://cdn-images.dzcdn.net/images/cover/0c19f0a49425d3c1b48a3a9a2144b966/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 529456911
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-15', 1, 1, id, '{"izvodjac":"Indira Radić","naslov":"Zmaj","alias":[],"deezerId":1530384162,"itunesId":1578094304,"omot":"https://cdn-images.dzcdn.net/images/cover/56ac6941cc780e278c465c7eb0c3afef/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1530384162
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-15', 1, 2, id, '{"izvodjac":"YU Grupa","naslov":"Crni leptir","alias":[],"deezerId":93131256,"itunesId":1768883648,"omot":"https://cdn-images.dzcdn.net/images/cover/da08dde9b45fcf2e04473f0329dd68a9/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 93131256
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-15', 1, 3, id, '{"izvodjac":"Van Gogh","naslov":"Neko te ima","alias":[],"deezerId":416407382,"itunesId":1295901266,"omot":"https://cdn-images.dzcdn.net/images/cover/d3d29c706cb790d1d8d012a70cc7e88d/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 416407382
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-15', 1, 4, id, '{"izvodjac":"Željko Joksimović","naslov":"Lane moje","alias":[],"deezerId":543692512,"itunesId":1534307934,"omot":"https://cdn-images.dzcdn.net/images/cover/256eae96a498483a488a87f6aceb2339/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 543692512
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-15', 1, 5, id, '{"izvodjac":"Jala Brat","naslov":"Mlada i luda","alias":[],"deezerId":2826870432,"itunesId":1869456199,"omot":"https://cdn-images.dzcdn.net/images/cover/7f75828e945cf7d96394cc16b5d8c33e/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2826870432
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-16', 1, 1, id, '{"izvodjac":"Milica Pavlović","naslov":"Tango","alias":[],"deezerId":3577739961,"itunesId":1578109034,"omot":"https://cdn-images.dzcdn.net/images/cover/7f737d4d72ee6e7eca098fc04879a06a/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3577739961
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-16', 1, 2, id, '{"izvodjac":"Severina","naslov":"Gas, gas","alias":[],"deezerId":66239087,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/b05932fbca6d5492ec27197ed2b84c38/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 66239087
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-16', 1, 3, id, '{"izvodjac":"Jala Brat & Buba Corelli","naslov":"Ona''e","alias":["Ona e"],"deezerId":2826274332,"itunesId":1869454361,"omot":"https://cdn-images.dzcdn.net/images/cover/30b661dc562993894dbfbb5ce318fd4c/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2826274332
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-16', 1, 4, id, '{"izvodjac":"Partibrejkers","naslov":"Hoću da znam","alias":[],"deezerId":584345352,"itunesId":1057660792,"omot":"https://cdn-images.dzcdn.net/images/cover/0e25a548d7ed6531a0b1b943c1b9102a/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 584345352
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-16', 1, 5, id, '{"izvodjac":"Toše Proeski","naslov":"Igra bez granica","alias":[],"deezerId":529457751,"itunesId":1578045026,"omot":"https://cdn-images.dzcdn.net/images/cover/14e51589c6a8b335d1eb35a8ce48855d/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 529457751
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-17', 1, 1, id, '{"izvodjac":"Vlado Georgiev","naslov":"Anđele","alias":[],"deezerId":3735395272,"itunesId":1863655384,"omot":"https://cdn-images.dzcdn.net/images/cover/86e118efbbf40f163867d2899a62f09e/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3735395272
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-17', 1, 2, id, '{"izvodjac":"Idoli","naslov":"Maljčiki","alias":[],"deezerId":23797711,"itunesId":385266437,"omot":"https://cdn-images.dzcdn.net/images/cover/2081e7a65262a095d8c3296e572b4bb6/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 23797711
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-17', 1, 3, id, '{"izvodjac":"Tanja Savić","naslov":"Tako mlada","alias":[],"deezerId":3577739411,"itunesId":1578130745,"omot":"https://cdn-images.dzcdn.net/images/cover/7f737d4d72ee6e7eca098fc04879a06a/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3577739411
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-17', 1, 4, id, '{"izvodjac":"Jala Brat, Buba Corelli & Rasta","naslov":"Benga po snijegu","alias":["Benga po snegu"],"deezerId":2826274312,"itunesId":1869456476,"omot":"https://cdn-images.dzcdn.net/images/cover/30b661dc562993894dbfbb5ce318fd4c/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2826274312
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-17', 1, 5, id, '{"izvodjac":"Ceca","naslov":"Beograd","alias":[],"deezerId":3918486731,"itunesId":897490637,"omot":"https://cdn-images.dzcdn.net/images/cover/7a4bbba6ddbc251eb2e4fec99da317db/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3918486731
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-18', 1, 1, id, '{"izvodjac":"Osvajači","naslov":"Možda nebo zna","alias":[],"deezerId":91190723,"itunesId":1361362425,"omot":"https://cdn-images.dzcdn.net/images/cover/3405b159010872ae2842ace1ca1a03b4/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 91190723
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-18', 1, 2, id, '{"izvodjac":"Ana Nikolić","naslov":"Romale, romali","alias":[],"deezerId":529454551,"itunesId":1863649027,"omot":"https://cdn-images.dzcdn.net/images/cover/fbf4b170d50755cf14a9962c907c550b/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 529454551
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-18', 1, 3, id, '{"izvodjac":"Riblja Čorba","naslov":"Ostani đubre do kraja","alias":[],"deezerId":3112807371,"itunesId":1708114196,"omot":"https://cdn-images.dzcdn.net/images/cover/4f01059cab768911ce47ec33dc0f9e82/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3112807371
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-18', 1, 4, id, '{"izvodjac":"Rasta","naslov":"Hotel","alias":[],"deezerId":2874735722,"itunesId":1755400371,"omot":"https://cdn-images.dzcdn.net/images/cover/9909b68e9509fb11a3e9ab7fc7e61ebe/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2874735722
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-18', 1, 5, id, '{"izvodjac":"Jelena Rozga","naslov":"Bižuterija","alias":[],"deezerId":719863962,"itunesId":488074409,"omot":"https://cdn-images.dzcdn.net/images/cover/4c05862d7a15651ad52d513ddf6689c7/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 719863962
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-19', 1, 1, id, '{"izvodjac":"Colonia","naslov":"Za tvoje snene oči","alias":["Za tvoje snene oci"],"deezerId":3524461661,"itunesId":380344238,"omot":"https://cdn-images.dzcdn.net/images/cover/03e11f678a397ae09f824831141f31ec/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3524461661
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-19', 1, 2, id, '{"izvodjac":"Marija Šerifović","naslov":"Molitva","alias":[],"deezerId":1841884507,"itunesId":1578027079,"omot":"https://cdn-images.dzcdn.net/images/cover/e095600104ae7adc6560384c44e74e7a/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1841884507
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-19', 1, 3, id, '{"izvodjac":"Senidah","naslov":"Slađana","alias":[],"deezerId":1448120402,"itunesId":1358425136,"omot":"https://cdn-images.dzcdn.net/images/cover/5ef77d9cff1c57cd4e78b7f05889d9e3/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1448120402
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-19', 1, 4, id, '{"izvodjac":"Generacija 5","naslov":"Dolazim za pet minuta","alias":["Dolazim za 5 minuta"],"deezerId":3194092551,"itunesId":1665669373,"omot":"https://cdn-images.dzcdn.net/images/cover/54c6ff4a139c08aa9f1f44df9ef0911e/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3194092551
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-19', 1, 5, id, '{"izvodjac":"Ceca","naslov":"Kukavica","alias":[],"deezerId":4100565851,"itunesId":6781846676,"omot":"https://cdn-images.dzcdn.net/images/cover/f2759717a185d0d126ec4ddcca8fbe89/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 4100565851
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-20', 1, 1, id, '{"izvodjac":"Šaban Šaulić","naslov":"Sneg je opet, Snežana","alias":[],"deezerId":3293842061,"itunesId":1833465638,"omot":"https://cdn-images.dzcdn.net/images/cover/5cf4e70b4164ea2a5890e28234dec13a/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3293842061
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-20', 1, 2, id, '{"izvodjac":"Džej Ramadanovski","naslov":"Nedelja","alias":[],"deezerId":75897511,"itunesId":814036745,"omot":"https://cdn-images.dzcdn.net/images/cover/66c50084acefb4789eb7e05595bfb910/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 75897511
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-20', 1, 3, id, '{"izvodjac":"Elitni Odredi","naslov":"Ne koči","alias":[],"deezerId":367409741,"itunesId":1578161233,"omot":"https://cdn-images.dzcdn.net/images/cover/803813f492547a845a0e773fe5a18f87/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 367409741
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-20', 1, 4, id, '{"izvodjac":"Nataša Bekvalac","naslov":"Nikotin","alias":[],"deezerId":572082382,"itunesId":1578038327,"omot":"https://cdn-images.dzcdn.net/images/cover/133979e36499dff7b58ad7a2cb7c4fec/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 572082382
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-20', 1, 5, id, '{"izvodjac":"Negative","naslov":"Ja bih te sanjala","alias":[],"deezerId":1097617292,"itunesId":342452460,"omot":"https://cdn-images.dzcdn.net/images/cover/6a24c1d12b8ad6b3b2a1d0f61d9f99f5/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1097617292
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-21', 1, 1, id, '{"izvodjac":"Piloti","naslov":"Kao ptica na mom dlanu","alias":[],"deezerId":2136800977,"itunesId":1670154957,"omot":"https://cdn-images.dzcdn.net/images/cover/07892c80eee21cb133e03743ea56da54/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2136800977
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-21', 1, 2, id, '{"izvodjac":"Električni Orgazam","naslov":"Igra rok''en''rol cela Jugoslavija","alias":["Igra rokenrol cela Jugoslavija","Igra rock and roll cela Jugoslavija","Igra rock''n''roll cela Jugoslavija","Igra rok end rol cela Jugoslavija"],"deezerId":2997909791,"itunesId":381727354,"omot":"https://cdn-images.dzcdn.net/images/cover/a1daef37893c7371a79c1d084a8aed13/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2997909791
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-21', 1, 3, id, '{"izvodjac":"Voyage","naslov":"Euforija","alias":[],"deezerId":1524834902,"itunesId":1590822353,"omot":"https://cdn-images.dzcdn.net/images/cover/3e2caab42106c745671878d679678914/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1524834902
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-21', 1, 4, id, '{"izvodjac":"Knez","naslov":"Dal'' si ikada mene voljela","alias":["Da li si ikada mene voljela","Dal si ikada mene volela"],"deezerId":569467032,"itunesId":1779524665,"omot":"https://cdn-images.dzcdn.net/images/cover/d2e8819830c005d290436ff45cd3e100/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 569467032
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-21', 1, 5, id, '{"izvodjac":"Milica Todorović","naslov":"Tri čaše","alias":[],"deezerId":464556372,"itunesId":1578147923,"omot":"https://cdn-images.dzcdn.net/images/cover/70f9546a52fbbe77edd2a85c8727f13a/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 464556372
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-22', 1, 1, id, '{"izvodjac":"Boban Rajović","naslov":"Usne boje vina","alias":[],"deezerId":1097490802,"itunesId":1577984193,"omot":"https://cdn-images.dzcdn.net/images/cover/3d2467e404000ce8672df185747ce77e/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1097490802
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-22', 1, 2, id, '{"izvodjac":"Sara Jo","naslov":"Mili, mili","alias":[],"deezerId":1458276022,"itunesId":1485997194,"omot":"https://cdn-images.dzcdn.net/images/cover/5c32fe082b74da88e2f70874158a7434/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1458276022
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-22', 1, 3, id, '{"izvodjac":"Smak","naslov":"Crna dama","alias":[],"deezerId":1189113242,"itunesId":1673511045,"omot":"https://cdn-images.dzcdn.net/images/cover/d551c7f7f3e9738741cafa9dd69e695f/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1189113242
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-22', 1, 4, id, '{"izvodjac":"Funky G","naslov":"Robinja","alias":[],"deezerId":3251372211,"itunesId":1798518554,"omot":"https://cdn-images.dzcdn.net/images/cover/350b80d5b91c0d49b05d7c52ce3ef666/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3251372211
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-22', 1, 5, id, '{"izvodjac":"Buba Corelli","naslov":"Balenciaga","alias":[],"deezerId":2826423592,"itunesId":1869456343,"omot":"https://cdn-images.dzcdn.net/images/cover/755122dbe831587019a0ff9596c38b31/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2826423592
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-23', 1, 1, id, '{"izvodjac":"Elena","naslov":"Geto princeza","alias":[],"deezerId":2874736332,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/68eef0cddd4de7acc5fdfee9a3c2f959/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2874736332
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-23', 1, 2, id, '{"izvodjac":"Bajaga i Instruktori","naslov":"Godine prolaze","alias":[],"deezerId":2619831532,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/876f6e3b5a47da8258356260596a69ab/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2619831532
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-23', 1, 3, id, '{"izvodjac":"Zorica Brunclik","naslov":"A tebe nema","alias":[],"deezerId":1267209572,"itunesId":1785561136,"omot":"https://cdn-images.dzcdn.net/images/cover/dd714c76af7b5a1a51369b0b5ec826ba/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1267209572
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-23', 1, 4, id, '{"izvodjac":"Sinan Sakić","naslov":"Lepa do bola","alias":[],"deezerId":1148816532,"itunesId":1541356044,"omot":"https://cdn-images.dzcdn.net/images/cover/d18891c57626dc413055ba40cde08701/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1148816532
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-23', 1, 5, id, '{"izvodjac":"Tijana Dapčević","naslov":"Sve je isto, samo njega nema","alias":["Sve je isto samo njega nema"],"deezerId":669816782,"itunesId":1578048136,"omot":"https://cdn-images.dzcdn.net/images/cover/0f63522949f5600757c9685fae420efd/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 669816782
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-24', 1, 1, id, '{"izvodjac":"Neverne Bebe","naslov":"Dvoje","alias":[],"deezerId":1246526562,"itunesId":1553971637,"omot":"https://cdn-images.dzcdn.net/images/cover/7efd9db31e140595b23ee660d7f90dbf/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1246526562
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-24', 1, 2, id, '{"izvodjac":"Stoja","naslov":"Evropa","alias":[],"deezerId":3515146491,"itunesId":1834143575,"omot":"https://cdn-images.dzcdn.net/images/cover/4d6ab6c1df27a2b5f700554549ecb360/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3515146491
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-24', 1, 3, id, '{"izvodjac":"Željko Samardžić","naslov":"Grlica","alias":[],"deezerId":730630702,"itunesId":1690799736,"omot":"https://cdn-images.dzcdn.net/images/cover/5710206419be4921023ac329d20c707b/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 730630702
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-24', 1, 4, id, '{"izvodjac":"Ekatarina Velika","naslov":"Par godina za nas","alias":[],"deezerId":2178288577,"itunesId":1676062744,"omot":"https://cdn-images.dzcdn.net/images/cover/c9f573b1c326b7612b65ba29b18b9830/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2178288577
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-24', 1, 5, id, '{"izvodjac":"Marčelo","naslov":"Pegla","alias":[],"deezerId":126398043,"itunesId":1122634973,"omot":"https://cdn-images.dzcdn.net/images/cover/aec32e8015c2b22615ba2d97a2c6ac3b/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 126398043
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-25', 1, 1, id, '{"izvodjac":"Zdravko Čolić","naslov":"Pusti, pusti modu","alias":[],"deezerId":3873062881,"itunesId":1768453459,"omot":"https://cdn-images.dzcdn.net/images/cover/d583b7a39e792bee9e271a46ee4be9aa/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3873062881
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-25', 1, 2, id, '{"izvodjac":"Dara Bubamara","naslov":"Kraj i tačka","alias":[],"deezerId":76953700,"itunesId":853807117,"omot":"https://cdn-images.dzcdn.net/images/cover/39969f9ae6ee3e7e45b3504aaa96e5dc/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 76953700
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-25', 1, 3, id, '{"izvodjac":"Aleksandra Radović","naslov":"Čuvam te","alias":[],"deezerId":724771892,"itunesId":1577968457,"omot":"https://cdn-images.dzcdn.net/images/cover/c5fc18b55056ab0e7eaf24497bff3520/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 724771892
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-25', 1, 4, id, '{"izvodjac":"Nikolija","naslov":"Opasna igra","alias":[],"deezerId":3585357171,"itunesId":1578171020,"omot":"https://cdn-images.dzcdn.net/images/cover/f157da565f7decc3d4a773857aef0061/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3585357171
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-25', 1, 5, id, '{"izvodjac":"Galija","naslov":"Dodirni me","alias":[],"deezerId":1029768162,"itunesId":1524533589,"omot":"https://cdn-images.dzcdn.net/images/cover/90332e72f902bd26deb0a195ea735fd6/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1029768162
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-26', 1, 1, id, '{"izvodjac":"Mitar Mirić","naslov":"Ne može nam niko ništa","alias":[],"deezerId":15620002,"itunesId":1877161517,"omot":"https://cdn-images.dzcdn.net/images/cover/d72ac926caf3ca020cd716b445803900/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 15620002
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-26', 1, 2, id, '{"izvodjac":"Sunshine","naslov":"Kokane","alias":[],"deezerId":74220640,"itunesId":1591697553,"omot":"https://cdn-images.dzcdn.net/images/cover/addfca3b309c6ea81ad769b448f00cca/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 74220640
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-26', 1, 3, id, '{"izvodjac":"Van Gogh","naslov":"Za godine tvoje","alias":[],"deezerId":416410952,"itunesId":1296178804,"omot":"https://cdn-images.dzcdn.net/images/cover/66b0517f8a4e19b9ce7d99b49243700a/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 416410952
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-26', 1, 4, id, '{"izvodjac":"Vesna Zmijanac","naslov":"Idem preko zemlje Srbije","alias":[],"deezerId":1070199542,"itunesId":1530116401,"omot":"https://cdn-images.dzcdn.net/images/cover/e3e1493645800a176ebb64ce25626611/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1070199542
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-26', 1, 5, id, '{"izvodjac":"Željko Samardžić","naslov":"9000 metara","alias":["Devet hiljada metara"],"deezerId":458468242,"itunesId":1578134286,"omot":"https://cdn-images.dzcdn.net/images/cover/bd90f01cb0edb6a944408d7ab9361916/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 458468242
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-27', 1, 1, id, '{"izvodjac":"Jelena Rozga","naslov":"Nirvana","alias":[],"deezerId":2998009921,"itunesId":632120047,"omot":"https://cdn-images.dzcdn.net/images/cover/4b108ec75e2bd830d4f5552c36d17ded/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 2998009921
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-27', 1, 2, id, '{"izvodjac":"Džej Ramadanovski","naslov":"Upalite za mnom sveće","alias":["Upalite za mnom svijeće"],"deezerId":3538539621,"itunesId":1787133566,"omot":"https://cdn-images.dzcdn.net/images/cover/6eaadab518195ebd3b64a865049cbbbe/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3538539621
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-27', 1, 3, id, '{"izvodjac":"Teodora","naslov":"Voli me, voli me","alias":[],"deezerId":1337899422,"itunesId":1578179364,"omot":"https://cdn-images.dzcdn.net/images/cover/53e871ea0321a0b3806556170a0b3209/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 1337899422
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-27', 1, 4, id, '{"izvodjac":"Đorđe Balašević","naslov":"Ringišpil","alias":[],"deezerId":775360092,"itunesId":1483596245,"omot":"https://cdn-images.dzcdn.net/images/cover/ff2ba6e22337997fd05523f46015b15e/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 775360092
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, song_id, snapshot)
  select '2026-11-27', 1, 5, id, '{"izvodjac":"Piloti","naslov":"Ne veruj u idole","alias":[],"deezerId":3020679851,"itunesId":null,"omot":"https://cdn-images.dzcdn.net/images/cover/580fc7b2b1ba75ed6afd50b21390245b/250x250-000000-80-0-0.jpg"}'::jsonb || jsonb_build_object('songId', id)
  from public.songs where deezer_id = 3020679851
  on conflict (quiz_date, segment, position) do nothing;

-- Artikli (products.json). Postojeći se osvežavaju po barkodu.
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043000023', 'Plazma keks', '300 g', '/artikli/8600043000023.webp', 288.56, 279.99, 294.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043000016', 'Plazma keks', '150 g', '/artikli/8600043000016.webp', 158.19, 152.99, 159.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043039788', 'Plazma keks', '400 g', '/artikli/8600043039788.webp', 387.71, 369.99, 401.66, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043001105', 'Plazma mlevena', '300 g', '/artikli/8600043001105.webp', 292.59, 279.99, 299.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043028263', 'Plazma Kocka napolitanke', '135 g', '/artikli/8600043028263.webp', 205.77, 183.99, 219.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043029512', 'Plazma Stiksi', '125 g', '/artikli/8600043029512.webp', 250.19, 217.99, 270.67, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043036794', 'Plazma od srca lešnik', '100 g', '/artikli/8600043036794.webp', 196.53, 184.99, 205.7, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043041484', 'Plazma Rolsi lešnik', '130 g', '/artikli/8600043041484.webp', 185.59, 170.99, 212.49, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114000013', 'Jaffa keks', '150 g', '/artikli/8600114000013.webp', 143.62, 139.99, 146.66, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114000211', 'Jaffa keks', '300 g', '/artikli/8600114000211.webp', 252, 249.69, 258.32, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114000020', 'Munchmallow', '105 g', '/artikli/8600114000020.webp', 107.98, 102.99, 111.66, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114006626', 'Jaffa napolitanke šlag i čokolada', '187 g', '/artikli/8600114006626.webp', 122.33, 109.99, 139.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939313701', 'Najlepše želje mlečna čokolada', '200 g', '/artikli/8600939313701.webp', 381.76, 364.99, 389.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939313602', 'Najlepše želje mlečna čokolada', '90 g', '/artikli/8600939313602.webp', 192.96, 189.99, 198.32, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939334171', 'Najlepše želje crna sa bananicom', '184 g', '/artikli/8600939334171.webp', 367.08, 349.99, 389.99, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939346082', 'Najlepše želje sa keksom', '170 g', '/artikli/8600939346082.webp', 352.63, 349.99, 363.32, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('86006675', 'Štark Bananica', '25 g', '/artikli/86006675.webp', 27.19, 24.99, 29.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939366424', 'Štark Bananica', '250 g', '/artikli/8600939366424.webp', 255.99, 247.99, 269.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939365472', 'Štark Bananica 5 kom', '125 g', '/artikli/8600939365472.webp', 138.89, 134.99, 141.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939130841', 'Štark Piškote', '105 g', '/artikli/8600939130841.webp', 106.79, 96.99, 122.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939303115', 'Štark Menaž čokolada za kuvanje', '100 g', '/artikli/8600939303115.webp', 201.92, 192.99, 211.66, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939841204', 'Štark Čajni keksići', '800 g', '/artikli/8600939841204.webp', 322.46, 309.99, 349.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939110454', 'Štark napolitanke sa čokoladom', '180 g', '/artikli/8600939110454.webp', 146.77, 128.99, 159.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900502032', 'Eurocrem Euro blok', '50 g', '/artikli/8601900502032.webp', 66.79, 59.99, 74.99, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900502100', 'Eurocrem Euro blok', '100 g', '/artikli/8601900502100.webp', 121.33, 99.99, 137.99, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900503411', 'Eurocrem činija', '500 g', '/artikli/8601900503411.webp', 480.46, 399.99, 543.32, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600946442111', 'Swisslion Isleri sa Eurocremom', '125 g', '/artikli/8600946442111.webp', 155.19, 129.99, 184.99, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300236022', 'Pionir Medeno srce', '150 g', '/artikli/8602300236022.webp', 145.63, 139.99, 153.32, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300200245', 'Pionir zeleni mentol bombone', '100 g', '/artikli/8602300200245.webp', 67.39, 59.99, 74.72, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300207305', 'Pionir karamele lešnik', '100 g', '/artikli/8602300207305.webp', 143.88, 132.99, 154.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300233229', 'Pionir mix Negro i Karamela lešnik', '250 g', '/artikli/8602300233229.webp', 264.47, 252.99, 286.16, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600104004458', 'Medela štrudla', '240 g', '/artikli/8600104004458.webp', 150.42, 139.99, 157.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939506912', 'Smoki', '50 g', '/artikli/8600939506912.webp', 47.66, 45.99, 49.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939508190', 'Smoki', '80 g', '/artikli/8600939508190.webp', 73.8, 69.99, 76.99, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939506936', 'Smoki', '150 g', '/artikli/8600939506936.webp', 129.26, 127.99, 129.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939507025', 'Smoki', '250 g', '/artikli/8600939507025.webp', 184.73, 171.99, 199.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939375563', 'Čoko Smoki', '80 g', '/artikli/8600939375563.webp', 170.95, 149.99, 179.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017378495', 'Chipsy Classic', '140 g', '/artikli/8606017378495.webp', 192.37, 171.49, 214.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606033742416', 'Chipsy Domaćinski kajmak', '145 g', '/artikli/8606033742416.webp', 194.88, 184.99, 199.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606033741495', 'Clipsy Mix flips', '150 g', '/artikli/8606033741495.webp', 149.35, 144.99, 156.66, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017378822', 'Pardon štapići sa kikirikijem', '210 g', '/artikli/8606017378822.webp', 159.22, 137.99, 169.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017370048', 'Pardon perece', '95 g', '/artikli/8606017370048.webp', 81.39, 74.99, 88.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037000312', 'Knjaz Miloš gazirana voda', '0,5 l', '/artikli/8600037000312.webp', 54.78, 49.99, 57.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037005133', 'Knjaz Miloš gazirana voda', '1,75 l', '/artikli/8600037005133.webp', 64.65, 62.99, 65.59, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037008011', 'Knjaz Miloš staklo', '0,25 l', '/artikli/8600037008011.webp', 82.99, 77.99, 89.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600169600022', 'Prolom voda', '1,5 l', '/artikli/8600169600022.webp', 86.23, 82.66, 99.99, 'Idea', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606002170066', 'Aqua Heba gazirana', '1,5 l', '/artikli/8606002170066.webp', 65.35, 61.99, 69.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606030051702', 'Fruvita narandža 100%', '0,8 l', '/artikli/8606030051702.webp', 317.47, 297.99, 349.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600105001463', 'Jelen pivo limenka', '0,5 l', '/artikli/8600105001463.webp', 98.28, 90.99, 109.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('86027618', 'Jelen pivo flaša', '0,5 l', '/artikli/86027618.webp', 91.19, 89.99, 94.99, 'Gomex', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600102672383', 'Lav pivo limenka', '0,5 l', '/artikli/8600102672383.webp', 88.2, 82.99, 92.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600649000427', 'Zaječarsko pivo limenka', '0,5 l', '/artikli/8600649000427.webp', 96.28, 89.99, 104.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606105157360', 'Zaječarsko pivo PET', '2 l', '/artikli/8606105157360.webp', 305.37, 279.99, 316.66, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600101521439', 'Doncafe Moment kafa', '200 g', '/artikli/8600101521439.webp', 471.34, 449.99, 483.32, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600103056250', 'Grand Gold kafa', '500 g', '/artikli/8600103056250.webp', 1103.99, 999.99, 1159.99, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606106464078', 'Bonito tamno pržena kafa', '200 g', '/artikli/8606106464078.webp', 457.04, 429.99, 507.68, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606018312276', 'Grand 3u1 Najlepše želje', '18 g', '/artikli/8606018312276.webp', 32.92, 28.99, 39.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500116011', 'Moja Kravica mleko dugotrajno 2,8%', '1 l', '/artikli/8601500116011.webp', 112.99, 99.99, 139.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500138655', 'Moja Kravica sveže mleko 2,8%', '1,75 l', '/artikli/8601500138655.webp', 226.79, 219.99, 230.62, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500138495', 'Moja Kravica jogurt 2,8%', '1,75 kg', '/artikli/8601500138495.webp', 232.61, 224.99, 240.09, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500115892', 'Moja Kravica jogurt čaša', '180 g', '/artikli/8601500115892.webp', 38.46, 35.99, 39.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500110330', 'Moja Kravica čokoladno mleko', '0,25 l', '/artikli/8601500110330.webp', 67.56, 64.99, 69.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500112419', 'Moja Kravica kisela pavlaka 20%', '400 g', '/artikli/8601500112419.webp', 187.09, 179.99, 189.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500111122', 'Moja Kravica maslac', '125 g', '/artikli/8601500111122.webp', 321.53, 315.99, 329.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500119609', 'Moja Kravica krem sir', '200 g', '/artikli/8601500119609.webp', 194.35, 179.99, 201.49, 'Gomex', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500126492', 'Ella sveži sir', '400 g', '/artikli/8601500126492.webp', 281.62, 262.99, 299.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500133490', 'Imlek protein čoko šejk', '300 ml', '/artikli/8601500133490.webp', 180.06, 169.99, 189.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012700183', 'Carnex mesni narezak', '150 g', '/artikli/8600012700183.webp', 212.99, 174.99, 229.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('86002783', 'Carnex jetrena pašteta', '75 g', '/artikli/86002783.webp', 88.94, 79.99, 99.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012700336', 'Carnex sarma', '400 g', '/artikli/8600012700336.webp', 495.72, 469.99, 521.66, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012700282', 'Carnex pasulj sa slaninom', '400 g', '/artikli/8600012700282.webp', 359.45, 317.49, 403.32, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012502510', 'Carnex delikates viršla', '205 g', '/artikli/8600012502510.webp', 211.07, 196.99, 229.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600084005841', 'Yuhor Alpska kobasica', '350 g', '/artikli/8600084005841.webp', 302.85, 244.99, 339.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600084005612', 'Yuhor Levački štapići', '200 g', '/artikli/8600084005612.webp', 594.16, 557.99, 639.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600763655244', 'Neoplanta Pipi pileća viršla', '205 g', '/artikli/8600763655244.webp', 193.67, 182.99, 209.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600763025559', 'Neoplanta namaz u crevu', '125 g', '/artikli/8600763025559.webp', 95.66, 84.99, 104.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600763036777', 'Neoplanta pizza šunka', '330 g', '/artikli/8600763036777.webp', 349.32, 284.99, 379.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606100145775', 'Zlatiborac kulen slajs', '100 g', '/artikli/8606100145775.webp', 270.52, 207.49, 309.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606100145737', 'Zlatiborac goveđa pršuta slajs', '100 g', '/artikli/8606100145737.webp', 687.7, 617.99, 714.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606106822403', 'Zlatiborac čvarci', '150 g', '/artikli/8606106822403.webp', 469.72, 436.99, 499.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498170029', 'Dijamant suncokretovo ulje', '1 l', '/artikli/8600498170029.webp', 201.52, 195.66, 214.99, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498150083', 'Dijamant kečap blagi', '500 g', '/artikli/8600498150083.webp', 160.84, 147.99, 179.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498176359', 'Dijamant majonez', '285 ml', '/artikli/8600498176359.webp', 191.65, 189.99, 199.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498172115', 'Dijamant stoni margarin', '250 g', '/artikli/8600498172115.webp', 114.79, 104.99, 124.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498151479', 'Dijamant ajvar blagi', '680 g', '/artikli/8600498151479.webp', 470.1, 449.55, 514.99, 'Idea', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900201119', 'Takovo koncentrat kokošije supe', '88 g', '/artikli/8601900201119.webp', 194.01, 130.32, 245.99, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080064', 'Frikom Macho sladoled', '75 ml', '/artikli/8606006080064.webp', 150.49, 148.99, 153.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080088', 'Frikom Kapri sladoled', '70 ml', '/artikli/8606006080088.webp', 98.83, 89.99, 102.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080040', 'Frikom Sneško', '46 g', '/artikli/8606006080040.webp', 76.39, 65.99, 80.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080095', 'Frikom Čoko Moko', '52 g', '/artikli/8606006080095.webp', 80.39, 79.99, 81.99, 'Idea', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606029612204', 'Frikom Quattro Plazma', '1,5 l', '/artikli/8606029612204.webp', 651.18, 599.99, 699.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606029610019', 'Frikom grašak', '400 g', '/artikli/8606029610019.webp', 165.75, 149.99, 179.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006081252', 'Frikom pomfrit', '1 kg', '/artikli/8606006081252.webp', 388.66, 382.99, 399.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017433705', 'Frikom pogačice', '800 g', '/artikli/8606017433705.webp', 315.9, 289.99, 374.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();

-- Dnevni kviz: segment 2 (Pogodi cenu). Dan koji već ima stavke se ne dira.
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-14', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 1, id, '{"naziv":"Zaječarsko pivo PET","kolicina":"2 l","slika":"/artikli/8606105157360.webp","cena":305,"min":279.99,"max":316.66,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606105157360'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 2, id, '{"naziv":"Najlepše želje mlečna čokolada","kolicina":"90 g","slika":"/artikli/8600939313602.webp","cena":193,"min":189.99,"max":198.32,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939313602'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 3, id, '{"naziv":"Neoplanta Pipi pileća viršla","kolicina":"205 g","slika":"/artikli/8600763655244.webp","cena":194,"min":182.99,"max":209.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600763655244'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 4, id, '{"naziv":"Eurocrem Euro blok","kolicina":"50 g","slika":"/artikli/8601900502032.webp","cena":67,"min":59.99,"max":74.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900502032'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 5, id, '{"naziv":"Dijamant kečap blagi","kolicina":"500 g","slika":"/artikli/8600498150083.webp","cena":161,"min":147.99,"max":179.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498150083'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 6, id, '{"naziv":"Lav pivo limenka","kolicina":"0,5 l","slika":"/artikli/8600102672383.webp","cena":88,"min":82.99,"max":92.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600102672383'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 7, id, '{"naziv":"Plazma Rolsi lešnik","kolicina":"130 g","slika":"/artikli/8600043041484.webp","cena":186,"min":170.99,"max":212.49,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043041484'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 8, id, '{"naziv":"Imlek protein čoko šejk","kolicina":"300 ml","slika":"/artikli/8601500133490.webp","cena":180,"min":169.99,"max":189.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500133490'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 9, id, '{"naziv":"Moja Kravica jogurt čaša","kolicina":"180 g","slika":"/artikli/8601500115892.webp","cena":38,"min":35.99,"max":39.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500115892'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 10, id, '{"naziv":"Moja Kravica sveže mleko 2,8%","kolicina":"1,75 l","slika":"/artikli/8601500138655.webp","cena":227,"min":219.99,"max":230.62,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500138655'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 1, id, '{"naziv":"Plazma keks","kolicina":"400 g","slika":"/artikli/8600043039788.webp","cena":388,"min":369.99,"max":401.66,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043039788'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 2, id, '{"naziv":"Moja Kravica kisela pavlaka 20%","kolicina":"400 g","slika":"/artikli/8601500112419.webp","cena":187,"min":179.99,"max":189.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500112419'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 3, id, '{"naziv":"Smoki","kolicina":"250 g","slika":"/artikli/8600939507025.webp","cena":185,"min":171.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939507025'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 4, id, '{"naziv":"Zlatiborac čvarci","kolicina":"150 g","slika":"/artikli/8606106822403.webp","cena":470,"min":436.99,"max":499.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606106822403'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 5, id, '{"naziv":"Chipsy Domaćinski kajmak","kolicina":"145 g","slika":"/artikli/8606033742416.webp","cena":195,"min":184.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606033742416'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 6, id, '{"naziv":"Swisslion Isleri sa Eurocremom","kolicina":"125 g","slika":"/artikli/8600946442111.webp","cena":155,"min":129.99,"max":184.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600946442111'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 7, id, '{"naziv":"Plazma mlevena","kolicina":"300 g","slika":"/artikli/8600043001105.webp","cena":293,"min":279.99,"max":299.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043001105'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 8, id, '{"naziv":"Clipsy Mix flips","kolicina":"150 g","slika":"/artikli/8606033741495.webp","cena":149,"min":144.99,"max":156.66,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606033741495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 9, id, '{"naziv":"Frikom Sneško","kolicina":"46 g","slika":"/artikli/8606006080040.webp","cena":76,"min":65.99,"max":80.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080040'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 10, id, '{"naziv":"Štark Piškote","kolicina":"105 g","slika":"/artikli/8600939130841.webp","cena":107,"min":96.99,"max":122.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939130841'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 1, id, '{"naziv":"Smoki","kolicina":"80 g","slika":"/artikli/8600939508190.webp","cena":74,"min":69.99,"max":76.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939508190'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 2, id, '{"naziv":"Carnex mesni narezak","kolicina":"150 g","slika":"/artikli/8600012700183.webp","cena":213,"min":174.99,"max":229.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012700183'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 3, id, '{"naziv":"Najlepše želje sa keksom","kolicina":"170 g","slika":"/artikli/8600939346082.webp","cena":353,"min":349.99,"max":363.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939346082'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 4, id, '{"naziv":"Frikom Čoko Moko","kolicina":"52 g","slika":"/artikli/8606006080095.webp","cena":80,"min":79.99,"max":81.99,"najjeftinije":"Idea","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080095'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 5, id, '{"naziv":"Štark Bananica 5 kom","kolicina":"125 g","slika":"/artikli/8600939365472.webp","cena":139,"min":134.99,"max":141.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939365472'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 6, id, '{"naziv":"Štark Menaž čokolada za kuvanje","kolicina":"100 g","slika":"/artikli/8600939303115.webp","cena":202,"min":192.99,"max":211.66,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939303115'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 7, id, '{"naziv":"Prolom voda","kolicina":"1,5 l","slika":"/artikli/8600169600022.webp","cena":86,"min":82.66,"max":99.99,"najjeftinije":"Idea","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600169600022'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 8, id, '{"naziv":"Dijamant majonez","kolicina":"285 ml","slika":"/artikli/8600498176359.webp","cena":192,"min":189.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498176359'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 9, id, '{"naziv":"Ella sveži sir","kolicina":"400 g","slika":"/artikli/8601500126492.webp","cena":282,"min":262.99,"max":299.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500126492'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 10, id, '{"naziv":"Čoko Smoki","kolicina":"80 g","slika":"/artikli/8600939375563.webp","cena":171,"min":149.99,"max":179.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939375563'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 1, id, '{"naziv":"Neoplanta pizza šunka","kolicina":"330 g","slika":"/artikli/8600763036777.webp","cena":349,"min":284.99,"max":379.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600763036777'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 2, id, '{"naziv":"Pardon štapići sa kikirikijem","kolicina":"210 g","slika":"/artikli/8606017378822.webp","cena":159,"min":137.99,"max":169.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017378822'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 3, id, '{"naziv":"Plazma Kocka napolitanke","kolicina":"135 g","slika":"/artikli/8600043028263.webp","cena":206,"min":183.99,"max":219.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043028263'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 4, id, '{"naziv":"Takovo koncentrat kokošije supe","kolicina":"88 g","slika":"/artikli/8601900201119.webp","cena":194,"min":130.32,"max":245.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900201119'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 5, id, '{"naziv":"Jelen pivo limenka","kolicina":"0,5 l","slika":"/artikli/8600105001463.webp","cena":98,"min":90.99,"max":109.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600105001463'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 6, id, '{"naziv":"Knjaz Miloš staklo","kolicina":"0,25 l","slika":"/artikli/8600037008011.webp","cena":83,"min":77.99,"max":89.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600037008011'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 7, id, '{"naziv":"Carnex jetrena pašteta","kolicina":"75 g","slika":"/artikli/86002783.webp","cena":89,"min":79.99,"max":99.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '86002783'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 8, id, '{"naziv":"Carnex delikates viršla","kolicina":"205 g","slika":"/artikli/8600012502510.webp","cena":211,"min":196.99,"max":229.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012502510'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 9, id, '{"naziv":"Medela štrudla","kolicina":"240 g","slika":"/artikli/8600104004458.webp","cena":150,"min":139.99,"max":157.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600104004458'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 10, id, '{"naziv":"Najlepše želje mlečna čokolada","kolicina":"200 g","slika":"/artikli/8600939313701.webp","cena":382,"min":364.99,"max":389.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939313701'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 1, id, '{"naziv":"Moja Kravica jogurt 2,8%","kolicina":"1,75 kg","slika":"/artikli/8601500138495.webp","cena":233,"min":224.99,"max":240.09,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500138495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 2, id, '{"naziv":"Doncafe Moment kafa","kolicina":"200 g","slika":"/artikli/8600101521439.webp","cena":471,"min":449.99,"max":483.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600101521439'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 3, id, '{"naziv":"Zlatiborac kulen slajs","kolicina":"100 g","slika":"/artikli/8606100145775.webp","cena":271,"min":207.49,"max":309.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606100145775'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 4, id, '{"naziv":"Štark napolitanke sa čokoladom","kolicina":"180 g","slika":"/artikli/8600939110454.webp","cena":147,"min":128.99,"max":159.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939110454'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 5, id, '{"naziv":"Yuhor Levački štapići","kolicina":"200 g","slika":"/artikli/8600084005612.webp","cena":594,"min":557.99,"max":639.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600084005612'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 6, id, '{"naziv":"Frikom Quattro Plazma","kolicina":"1,5 l","slika":"/artikli/8606029612204.webp","cena":651,"min":599.99,"max":699.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606029612204'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 7, id, '{"naziv":"Jaffa keks","kolicina":"150 g","slika":"/artikli/8600114000013.webp","cena":144,"min":139.99,"max":146.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000013'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 8, id, '{"naziv":"Yuhor Alpska kobasica","kolicina":"350 g","slika":"/artikli/8600084005841.webp","cena":303,"min":244.99,"max":339.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600084005841'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 9, id, '{"naziv":"Grand 3u1 Najlepše želje","kolicina":"18 g","slika":"/artikli/8606018312276.webp","cena":33,"min":28.99,"max":39.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606018312276'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 10, id, '{"naziv":"Pionir Medeno srce","kolicina":"150 g","slika":"/artikli/8602300236022.webp","cena":146,"min":139.99,"max":153.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300236022'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 1, id, '{"naziv":"Pardon perece","kolicina":"95 g","slika":"/artikli/8606017370048.webp","cena":81,"min":74.99,"max":88.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017370048'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 2, id, '{"naziv":"Pionir zeleni mentol bombone","kolicina":"100 g","slika":"/artikli/8602300200245.webp","cena":67,"min":59.99,"max":74.72,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300200245'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 3, id, '{"naziv":"Eurocrem činija","kolicina":"500 g","slika":"/artikli/8601900503411.webp","cena":480,"min":399.99,"max":543.32,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900503411'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 4, id, '{"naziv":"Dijamant suncokretovo ulje","kolicina":"1 l","slika":"/artikli/8600498170029.webp","cena":202,"min":195.66,"max":214.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498170029'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 5, id, '{"naziv":"Chipsy Classic","kolicina":"140 g","slika":"/artikli/8606017378495.webp","cena":192,"min":171.49,"max":214.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017378495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 6, id, '{"naziv":"Smoki","kolicina":"150 g","slika":"/artikli/8600939506936.webp","cena":129,"min":127.99,"max":129.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939506936'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 7, id, '{"naziv":"Plazma keks","kolicina":"150 g","slika":"/artikli/8600043000016.webp","cena":158,"min":152.99,"max":159.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043000016'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 8, id, '{"naziv":"Plazma od srca lešnik","kolicina":"100 g","slika":"/artikli/8600043036794.webp","cena":197,"min":184.99,"max":205.7,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043036794'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 9, id, '{"naziv":"Knjaz Miloš gazirana voda","kolicina":"0,5 l","slika":"/artikli/8600037000312.webp","cena":55,"min":49.99,"max":57.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600037000312'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 10, id, '{"naziv":"Dijamant stoni margarin","kolicina":"250 g","slika":"/artikli/8600498172115.webp","cena":115,"min":104.99,"max":124.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498172115'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 1, id, '{"naziv":"Frikom grašak","kolicina":"400 g","slika":"/artikli/8606029610019.webp","cena":166,"min":149.99,"max":179.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606029610019'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 2, id, '{"naziv":"Knjaz Miloš gazirana voda","kolicina":"1,75 l","slika":"/artikli/8600037005133.webp","cena":65,"min":62.99,"max":65.59,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600037005133'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 3, id, '{"naziv":"Plazma keks","kolicina":"300 g","slika":"/artikli/8600043000023.webp","cena":289,"min":279.99,"max":294.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043000023'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 4, id, '{"naziv":"Moja Kravica čokoladno mleko","kolicina":"0,25 l","slika":"/artikli/8601500110330.webp","cena":68,"min":64.99,"max":69.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500110330'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 5, id, '{"naziv":"Grand Gold kafa","kolicina":"500 g","slika":"/artikli/8600103056250.webp","cena":1104,"min":999.99,"max":1159.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600103056250'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 6, id, '{"naziv":"Štark Bananica","kolicina":"250 g","slika":"/artikli/8600939366424.webp","cena":256,"min":247.99,"max":269.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939366424'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 7, id, '{"naziv":"Jaffa keks","kolicina":"300 g","slika":"/artikli/8600114000211.webp","cena":252,"min":249.69,"max":258.32,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000211'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 8, id, '{"naziv":"Carnex sarma","kolicina":"400 g","slika":"/artikli/8600012700336.webp","cena":496,"min":469.99,"max":521.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012700336'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 9, id, '{"naziv":"Pionir mix Negro i Karamela lešnik","kolicina":"250 g","slika":"/artikli/8602300233229.webp","cena":264,"min":252.99,"max":286.16,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300233229'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 10, id, '{"naziv":"Moja Kravica mleko dugotrajno 2,8%","kolicina":"1 l","slika":"/artikli/8601500116011.webp","cena":113,"min":99.99,"max":139.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500116011'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 1, id, '{"naziv":"Štark Bananica","kolicina":"25 g","slika":"/artikli/86006675.webp","cena":27,"min":24.99,"max":29.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '86006675'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 2, id, '{"naziv":"Plazma Stiksi","kolicina":"125 g","slika":"/artikli/8600043029512.webp","cena":250,"min":217.99,"max":270.67,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043029512'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 3, id, '{"naziv":"Bonito tamno pržena kafa","kolicina":"200 g","slika":"/artikli/8606106464078.webp","cena":457,"min":429.99,"max":507.68,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606106464078'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 4, id, '{"naziv":"Frikom pogačice","kolicina":"800 g","slika":"/artikli/8606017433705.webp","cena":316,"min":289.99,"max":374.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017433705'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 5, id, '{"naziv":"Carnex pasulj sa slaninom","kolicina":"400 g","slika":"/artikli/8600012700282.webp","cena":359,"min":317.49,"max":403.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012700282'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 6, id, '{"naziv":"Fruvita narandža 100%","kolicina":"0,8 l","slika":"/artikli/8606030051702.webp","cena":317,"min":297.99,"max":349.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606030051702'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 7, id, '{"naziv":"Frikom pomfrit","kolicina":"1 kg","slika":"/artikli/8606006081252.webp","cena":389,"min":382.99,"max":399.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006081252'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 8, id, '{"naziv":"Najlepše želje crna sa bananicom","kolicina":"184 g","slika":"/artikli/8600939334171.webp","cena":367,"min":349.99,"max":389.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939334171'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 9, id, '{"naziv":"Frikom Kapri sladoled","kolicina":"70 ml","slika":"/artikli/8606006080088.webp","cena":99,"min":89.99,"max":102.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080088'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 10, id, '{"naziv":"Moja Kravica krem sir","kolicina":"200 g","slika":"/artikli/8601500119609.webp","cena":194,"min":179.99,"max":201.49,"najjeftinije":"Gomex","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500119609'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 1, id, '{"naziv":"Aqua Heba gazirana","kolicina":"1,5 l","slika":"/artikli/8606002170066.webp","cena":65,"min":61.99,"max":69.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606002170066'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 2, id, '{"naziv":"Jelen pivo flaša","kolicina":"0,5 l","slika":"/artikli/86027618.webp","cena":91,"min":89.99,"max":94.99,"najjeftinije":"Gomex","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '86027618'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 3, id, '{"naziv":"Zaječarsko pivo limenka","kolicina":"0,5 l","slika":"/artikli/8600649000427.webp","cena":96,"min":89.99,"max":104.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600649000427'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 4, id, '{"naziv":"Pionir karamele lešnik","kolicina":"100 g","slika":"/artikli/8602300207305.webp","cena":144,"min":132.99,"max":154.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300207305'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 5, id, '{"naziv":"Dijamant ajvar blagi","kolicina":"680 g","slika":"/artikli/8600498151479.webp","cena":470,"min":449.55,"max":514.99,"najjeftinije":"Idea","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498151479'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 6, id, '{"naziv":"Smoki","kolicina":"50 g","slika":"/artikli/8600939506912.webp","cena":48,"min":45.99,"max":49.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939506912'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 7, id, '{"naziv":"Frikom Macho sladoled","kolicina":"75 ml","slika":"/artikli/8606006080064.webp","cena":150,"min":148.99,"max":153.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080064'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 8, id, '{"naziv":"Jaffa napolitanke šlag i čokolada","kolicina":"187 g","slika":"/artikli/8600114006626.webp","cena":122,"min":109.99,"max":139.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114006626'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 9, id, '{"naziv":"Moja Kravica maslac","kolicina":"125 g","slika":"/artikli/8601500111122.webp","cena":322,"min":315.99,"max":329.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500111122'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 10, id, '{"naziv":"Štark Čajni keksići","kolicina":"800 g","slika":"/artikli/8600939841204.webp","cena":322,"min":309.99,"max":349.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939841204'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 1, id, '{"naziv":"Bonito tamno pržena kafa","kolicina":"200 g","slika":"/artikli/8606106464078.webp","cena":457,"min":429.99,"max":507.68,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606106464078'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 2, id, '{"naziv":"Eurocrem Euro blok","kolicina":"100 g","slika":"/artikli/8601900502100.webp","cena":121,"min":99.99,"max":137.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900502100'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 3, id, '{"naziv":"Jaffa keks","kolicina":"150 g","slika":"/artikli/8600114000013.webp","cena":144,"min":139.99,"max":146.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000013'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 4, id, '{"naziv":"Neoplanta namaz u crevu","kolicina":"125 g","slika":"/artikli/8600763025559.webp","cena":96,"min":84.99,"max":104.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600763025559'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 5, id, '{"naziv":"Zlatiborac goveđa pršuta slajs","kolicina":"100 g","slika":"/artikli/8606100145737.webp","cena":688,"min":617.99,"max":714.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606100145737'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 6, id, '{"naziv":"Munchmallow","kolicina":"105 g","slika":"/artikli/8600114000020.webp","cena":108,"min":102.99,"max":111.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000020'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 7, id, '{"naziv":"Plazma od srca lešnik","kolicina":"100 g","slika":"/artikli/8600043036794.webp","cena":197,"min":184.99,"max":205.7,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043036794'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 8, id, '{"naziv":"Frikom Quattro Plazma","kolicina":"1,5 l","slika":"/artikli/8606029612204.webp","cena":651,"min":599.99,"max":699.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606029612204'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 9, id, '{"naziv":"Moja Kravica jogurt 2,8%","kolicina":"1,75 kg","slika":"/artikli/8601500138495.webp","cena":233,"min":224.99,"max":240.09,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500138495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 10, id, '{"naziv":"Grand 3u1 Najlepše želje","kolicina":"18 g","slika":"/artikli/8606018312276.webp","cena":33,"min":28.99,"max":39.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606018312276'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 1, id, '{"naziv":"Clipsy Mix flips","kolicina":"150 g","slika":"/artikli/8606033741495.webp","cena":149,"min":144.99,"max":156.66,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606033741495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 2, id, '{"naziv":"Pardon štapići sa kikirikijem","kolicina":"210 g","slika":"/artikli/8606017378822.webp","cena":159,"min":137.99,"max":169.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017378822'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 3, id, '{"naziv":"Moja Kravica krem sir","kolicina":"200 g","slika":"/artikli/8601500119609.webp","cena":194,"min":179.99,"max":201.49,"najjeftinije":"Gomex","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500119609'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 4, id, '{"naziv":"Moja Kravica kisela pavlaka 20%","kolicina":"400 g","slika":"/artikli/8601500112419.webp","cena":187,"min":179.99,"max":189.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500112419'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 5, id, '{"naziv":"Jaffa napolitanke šlag i čokolada","kolicina":"187 g","slika":"/artikli/8600114006626.webp","cena":122,"min":109.99,"max":139.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114006626'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 6, id, '{"naziv":"Pionir zeleni mentol bombone","kolicina":"100 g","slika":"/artikli/8602300200245.webp","cena":67,"min":59.99,"max":74.72,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300200245'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 7, id, '{"naziv":"Frikom Sneško","kolicina":"46 g","slika":"/artikli/8606006080040.webp","cena":76,"min":65.99,"max":80.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080040'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 8, id, '{"naziv":"Smoki","kolicina":"80 g","slika":"/artikli/8600939508190.webp","cena":74,"min":69.99,"max":76.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939508190'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 9, id, '{"naziv":"Carnex mesni narezak","kolicina":"150 g","slika":"/artikli/8600012700183.webp","cena":213,"min":174.99,"max":229.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012700183'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 10, id, '{"naziv":"Zaječarsko pivo limenka","kolicina":"0,5 l","slika":"/artikli/8600649000427.webp","cena":96,"min":89.99,"max":104.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600649000427'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 1, id, '{"naziv":"Doncafe Moment kafa","kolicina":"200 g","slika":"/artikli/8600101521439.webp","cena":471,"min":449.99,"max":483.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600101521439'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 2, id, '{"naziv":"Chipsy Domaćinski kajmak","kolicina":"145 g","slika":"/artikli/8606033742416.webp","cena":195,"min":184.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606033742416'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 3, id, '{"naziv":"Plazma Rolsi lešnik","kolicina":"130 g","slika":"/artikli/8600043041484.webp","cena":186,"min":170.99,"max":212.49,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043041484'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 4, id, '{"naziv":"Zlatiborac kulen slajs","kolicina":"100 g","slika":"/artikli/8606100145775.webp","cena":271,"min":207.49,"max":309.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606100145775'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 5, id, '{"naziv":"Zlatiborac goveđa pršuta slajs","kolicina":"100 g","slika":"/artikli/8606100145737.webp","cena":688,"min":617.99,"max":714.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606100145737'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 6, id, '{"naziv":"Štark Bananica","kolicina":"250 g","slika":"/artikli/8600939366424.webp","cena":256,"min":247.99,"max":269.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939366424'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 7, id, '{"naziv":"Fruvita narandža 100%","kolicina":"0,8 l","slika":"/artikli/8606030051702.webp","cena":317,"min":297.99,"max":349.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606030051702'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 8, id, '{"naziv":"Carnex sarma","kolicina":"400 g","slika":"/artikli/8600012700336.webp","cena":496,"min":469.99,"max":521.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012700336'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 9, id, '{"naziv":"Eurocrem Euro blok","kolicina":"50 g","slika":"/artikli/8601900502032.webp","cena":67,"min":59.99,"max":74.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900502032'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 10, id, '{"naziv":"Najlepše želje crna sa bananicom","kolicina":"184 g","slika":"/artikli/8600939334171.webp","cena":367,"min":349.99,"max":389.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939334171'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 1, id, '{"naziv":"Eurocrem Euro blok","kolicina":"100 g","slika":"/artikli/8601900502100.webp","cena":121,"min":99.99,"max":137.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900502100'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 2, id, '{"naziv":"Dijamant ajvar blagi","kolicina":"680 g","slika":"/artikli/8600498151479.webp","cena":470,"min":449.55,"max":514.99,"najjeftinije":"Idea","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498151479'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 3, id, '{"naziv":"Plazma keks","kolicina":"300 g","slika":"/artikli/8600043000023.webp","cena":289,"min":279.99,"max":294.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043000023'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 4, id, '{"naziv":"Aqua Heba gazirana","kolicina":"1,5 l","slika":"/artikli/8606002170066.webp","cena":65,"min":61.99,"max":69.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606002170066'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 5, id, '{"naziv":"Dijamant kečap blagi","kolicina":"500 g","slika":"/artikli/8600498150083.webp","cena":161,"min":147.99,"max":179.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498150083'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 6, id, '{"naziv":"Štark Čajni keksići","kolicina":"800 g","slika":"/artikli/8600939841204.webp","cena":322,"min":309.99,"max":349.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939841204'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 7, id, '{"naziv":"Swisslion Isleri sa Eurocremom","kolicina":"125 g","slika":"/artikli/8600946442111.webp","cena":155,"min":129.99,"max":184.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600946442111'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 8, id, '{"naziv":"Lav pivo limenka","kolicina":"0,5 l","slika":"/artikli/8600102672383.webp","cena":88,"min":82.99,"max":92.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600102672383'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 9, id, '{"naziv":"Smoki","kolicina":"250 g","slika":"/artikli/8600939507025.webp","cena":185,"min":171.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939507025'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 10, id, '{"naziv":"Frikom Macho sladoled","kolicina":"75 ml","slika":"/artikli/8606006080064.webp","cena":150,"min":148.99,"max":153.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080064'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 1, id, '{"naziv":"Frikom Kapri sladoled","kolicina":"70 ml","slika":"/artikli/8606006080088.webp","cena":99,"min":89.99,"max":102.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080088'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 2, id, '{"naziv":"Yuhor Levački štapići","kolicina":"200 g","slika":"/artikli/8600084005612.webp","cena":594,"min":557.99,"max":639.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600084005612'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 3, id, '{"naziv":"Najlepše želje mlečna čokolada","kolicina":"90 g","slika":"/artikli/8600939313602.webp","cena":193,"min":189.99,"max":198.32,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939313602'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 4, id, '{"naziv":"Carnex jetrena pašteta","kolicina":"75 g","slika":"/artikli/86002783.webp","cena":89,"min":79.99,"max":99.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '86002783'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 5, id, '{"naziv":"Štark Bananica 5 kom","kolicina":"125 g","slika":"/artikli/8600939365472.webp","cena":139,"min":134.99,"max":141.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939365472'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 6, id, '{"naziv":"Zlatiborac čvarci","kolicina":"150 g","slika":"/artikli/8606106822403.webp","cena":470,"min":436.99,"max":499.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606106822403'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 7, id, '{"naziv":"Jaffa keks","kolicina":"300 g","slika":"/artikli/8600114000211.webp","cena":252,"min":249.69,"max":258.32,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000211'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 8, id, '{"naziv":"Jelen pivo flaša","kolicina":"0,5 l","slika":"/artikli/86027618.webp","cena":91,"min":89.99,"max":94.99,"najjeftinije":"Gomex","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '86027618'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 9, id, '{"naziv":"Medela štrudla","kolicina":"240 g","slika":"/artikli/8600104004458.webp","cena":150,"min":139.99,"max":157.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600104004458'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 10, id, '{"naziv":"Smoki","kolicina":"150 g","slika":"/artikli/8600939506936.webp","cena":129,"min":127.99,"max":129.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939506936'
  on conflict (quiz_date, segment, position) do nothing;

-- Isto što i migracija 0002: ponovljeno ovde da seed radi i ako ona nije puštena.
create unique index if not exists trend_pairs_par_idx on public.trend_pairs (term_a, term_b, period);

-- Dueli pojmova (trends.json). Postojeći se osvežavaju.
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Aleksandar Mitrović', 'Lala', 24, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Lubenica', 'Lala', 100, 61, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Lubenica', 'Matematika', 40, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pasulj', 'Matematika', 50, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Loto', 'Matematika', 100, 29, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Loto', 'Krompir', 100, 57, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Loto', 'Subotica', 40, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Xiaomi', 'Subotica', 44, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Srpski jezik', 'Prolom Banja', 100, 24, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Srpski jezik', 'Gibanica', 100, 48, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Srpski jezik', 'Divčibare', 43, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Čaj', 'Divčibare', 100, 30, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Čaj', 'Frižider', 100, 69, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Čaj', 'iPhone', 43, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Instagram', 'iPhone', 100, 75, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Instagram', 'Opel', 100, 24, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Baklava', 'Burek', 77, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Viber', 'Burek', 100, 34, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Viber', 'Musaka', 100, 29, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Viber', 'BMW', 23, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vaterpolo', 'BMW', 31, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('KupujemProdajem', 'BMW', 100, 30, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('KupujemProdajem', 'Kragujevac', 100, 58, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('KupujemProdajem', 'Samsung', 100, 32, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krofne', 'Šljiva', 29, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Horoskop', 'Šljiva', 100, 28, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Horoskop', 'Košarka', 67, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Egipat', 'Košarka', 23, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Facebook', 'Košarka', 100, 35, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Facebook', 'Audi', 100, 23, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Facebook', 'Polovni automobili', 100, 53, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Facebook', 'Novi Sad', 50, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Stara planina', 'Grožđe', 55, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Lepa Brena', 'Grožđe', 70, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vino', 'Grožđe', 100, 23, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vino', 'Škoda', 100, 67, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vino', 'Turska', 65, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Fudbal', 'Turska', 100, 28, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Fudbal', 'Čačak', 100, 54, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Fudbal', 'TikTok', 100, 35, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Jabuka', 'Kupus', 100, 76, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Jabuka', 'Limundo', 100, 75, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Jabuka', 'Orhideja', 100, 22, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Jabuka', 'Zlatibor', 29, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kragujevac', 'Zlatibor', 100, 48, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kragujevac', 'WhatsApp', 100, 22, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kragujevac', 'Vremenska prognoza', 30, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('iPhone', 'Vremenska prognoza', 25, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Punjene paprike', 'Tulumbe', 100, 33, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Punjene paprike', 'Ćevapi', 44, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Engleski jezik', 'Ćevapi', 35, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kurs evra', 'Ćevapi', 100, 33, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kurs evra', 'Nokia', 100, 32, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kurs evra', 'Usisivač', 49, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Grčka', 'Usisivač', 100, 39, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Grčka', 'Tenis', 100, 58, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Klima', 'Huawei', 100, 40, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Klima', 'Kafa', 65, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Halo oglasi', 'Kafa', 47, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Crna Gora', 'Kafa', 100, 78, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Crna Gora', 'Palačinke', 100, 23, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Crna Gora', 'Odbojka', 100, 39, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Crna Gora', 'Čačak', 67, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kopaonik', 'Čačak', 24, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krastavac', 'Željko Joksimović', 100, 29, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krastavac', 'Ruža', 34, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Hrvatska', 'Ruža', 100, 24, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Hrvatska', 'Facebook', 31, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Subotica', 'Facebook', 42, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Zlatibor', 'Facebook', 26, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vremenska prognoza', 'Facebook', 100, 56, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vremenska prognoza', 'Fudbal', 100, 40, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Aca Lukas', 'Sarma', 100, 63, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Aca Lukas', 'Paradajz', 24, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Gulaš', 'Paradajz', 27, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Nikola Jokić', 'Paradajz', 63, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vrnjačka Banja', 'Paradajz', 100, 62, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vrnjačka Banja', 'TikTok', 53, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Zaječar', 'TikTok', 40, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Košarka', 'TikTok', 100, 72, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pljeskavica', 'Paprika', 25, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Zdravko Čolić', 'Paprika', 57, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Malina', 'Paprika', 63, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pivo', 'Paprika', 100, 51, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pivo', 'Mercedes', 58, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Instagram', 'Mercedes', 100, 28, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Instagram', 'Usisivač', 100, 21, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Instagram', 'KupujemProdajem', 64, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Banja Koviljača', 'Božur', 100, 53, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Banja Koviljača', 'Ceca', 36, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Bogdan Bogdanović', 'Ceca', 24, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Rakija', 'Ceca', 100, 52, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Rakija', 'Istorija', 100, 40, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Rakija', 'Tenis', 50, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Veš mašina', 'Tenis', 56, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Horoskop', 'Tenis', 100, 80, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Ljubičica', 'Vanilice', 60, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Fruška gora', 'Vanilice', 100, 21, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Fruška gora', 'Sokobanja', 42, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krompir', 'Sokobanja', 100, 78, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krompir', 'Šporet', 100, 27, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krompir', 'Dušan Vlahović', 100, 22, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krompir', 'Čaj', 51, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Huawei', 'Čaj', 28, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Dušan Tadić', 'Podvarak', 63, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Geografija', 'Podvarak', 100, 54, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Geografija', 'Vanilice', 100, 50, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Geografija', 'Ljubičica', 100, 30, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Geografija', 'Kupindo', 39, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Sokobanja', 'Kupindo', 100, 44, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Sokobanja', 'Ceca', 100, 65, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Sokobanja', 'Zaječar', 74, 100, '14.11.2025 – 14.11.2026', '2026-11-14')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;

-- Dnevni kviz: segment 3 (Šta se više gugla). Pobednik duela ostaje i u sledećem.
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-14', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 1, id, '{"a":"Aleksandar Mitrović","b":"Lala","indeksA":24,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Aleksandar Mitrović' and term_b = 'Lala' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 2, id, '{"a":"Lubenica","b":"Lala","indeksA":100,"indeksB":61,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Lubenica' and term_b = 'Lala' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 3, id, '{"a":"Lubenica","b":"Matematika","indeksA":40,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Lubenica' and term_b = 'Matematika' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 4, id, '{"a":"Pasulj","b":"Matematika","indeksA":50,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Pasulj' and term_b = 'Matematika' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 5, id, '{"a":"Loto","b":"Matematika","indeksA":100,"indeksB":29,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Loto' and term_b = 'Matematika' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 6, id, '{"a":"Loto","b":"Krompir","indeksA":100,"indeksB":57,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Loto' and term_b = 'Krompir' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 7, id, '{"a":"Loto","b":"Subotica","indeksA":40,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Loto' and term_b = 'Subotica' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 8, id, '{"a":"Xiaomi","b":"Subotica","indeksA":44,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Xiaomi' and term_b = 'Subotica' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 1, id, '{"a":"Srpski jezik","b":"Prolom Banja","indeksA":100,"indeksB":24,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Srpski jezik' and term_b = 'Prolom Banja' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 2, id, '{"a":"Srpski jezik","b":"Gibanica","indeksA":100,"indeksB":48,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Srpski jezik' and term_b = 'Gibanica' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 3, id, '{"a":"Srpski jezik","b":"Divčibare","indeksA":43,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Srpski jezik' and term_b = 'Divčibare' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 4, id, '{"a":"Čaj","b":"Divčibare","indeksA":100,"indeksB":30,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Čaj' and term_b = 'Divčibare' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 5, id, '{"a":"Čaj","b":"Frižider","indeksA":100,"indeksB":69,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Čaj' and term_b = 'Frižider' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 6, id, '{"a":"Čaj","b":"iPhone","indeksA":43,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Čaj' and term_b = 'iPhone' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 7, id, '{"a":"Instagram","b":"iPhone","indeksA":100,"indeksB":75,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Instagram' and term_b = 'iPhone' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 8, id, '{"a":"Instagram","b":"Opel","indeksA":100,"indeksB":24,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Instagram' and term_b = 'Opel' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 1, id, '{"a":"Baklava","b":"Burek","indeksA":77,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Baklava' and term_b = 'Burek' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 2, id, '{"a":"Viber","b":"Burek","indeksA":100,"indeksB":34,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Viber' and term_b = 'Burek' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 3, id, '{"a":"Viber","b":"Musaka","indeksA":100,"indeksB":29,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Viber' and term_b = 'Musaka' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 4, id, '{"a":"Viber","b":"BMW","indeksA":23,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Viber' and term_b = 'BMW' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 5, id, '{"a":"Vaterpolo","b":"BMW","indeksA":31,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vaterpolo' and term_b = 'BMW' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 6, id, '{"a":"KupujemProdajem","b":"BMW","indeksA":100,"indeksB":30,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'KupujemProdajem' and term_b = 'BMW' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 7, id, '{"a":"KupujemProdajem","b":"Kragujevac","indeksA":100,"indeksB":58,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'KupujemProdajem' and term_b = 'Kragujevac' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 8, id, '{"a":"KupujemProdajem","b":"Samsung","indeksA":100,"indeksB":32,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'KupujemProdajem' and term_b = 'Samsung' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 1, id, '{"a":"Krofne","b":"Šljiva","indeksA":29,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Krofne' and term_b = 'Šljiva' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 2, id, '{"a":"Horoskop","b":"Šljiva","indeksA":100,"indeksB":28,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Horoskop' and term_b = 'Šljiva' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 3, id, '{"a":"Horoskop","b":"Košarka","indeksA":67,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Horoskop' and term_b = 'Košarka' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 4, id, '{"a":"Egipat","b":"Košarka","indeksA":23,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Egipat' and term_b = 'Košarka' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 5, id, '{"a":"Facebook","b":"Košarka","indeksA":100,"indeksB":35,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Facebook' and term_b = 'Košarka' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 6, id, '{"a":"Facebook","b":"Audi","indeksA":100,"indeksB":23,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Facebook' and term_b = 'Audi' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 7, id, '{"a":"Facebook","b":"Polovni automobili","indeksA":100,"indeksB":53,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Facebook' and term_b = 'Polovni automobili' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 8, id, '{"a":"Facebook","b":"Novi Sad","indeksA":50,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Facebook' and term_b = 'Novi Sad' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 1, id, '{"a":"Stara planina","b":"Grožđe","indeksA":55,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Stara planina' and term_b = 'Grožđe' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 2, id, '{"a":"Lepa Brena","b":"Grožđe","indeksA":70,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Lepa Brena' and term_b = 'Grožđe' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 3, id, '{"a":"Vino","b":"Grožđe","indeksA":100,"indeksB":23,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vino' and term_b = 'Grožđe' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 4, id, '{"a":"Vino","b":"Škoda","indeksA":100,"indeksB":67,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vino' and term_b = 'Škoda' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 5, id, '{"a":"Vino","b":"Turska","indeksA":65,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vino' and term_b = 'Turska' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 6, id, '{"a":"Fudbal","b":"Turska","indeksA":100,"indeksB":28,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Fudbal' and term_b = 'Turska' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 7, id, '{"a":"Fudbal","b":"Čačak","indeksA":100,"indeksB":54,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Fudbal' and term_b = 'Čačak' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 8, id, '{"a":"Fudbal","b":"TikTok","indeksA":100,"indeksB":35,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Fudbal' and term_b = 'TikTok' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 1, id, '{"a":"Jabuka","b":"Kupus","indeksA":100,"indeksB":76,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Jabuka' and term_b = 'Kupus' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 2, id, '{"a":"Jabuka","b":"Limundo","indeksA":100,"indeksB":75,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Jabuka' and term_b = 'Limundo' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 3, id, '{"a":"Jabuka","b":"Orhideja","indeksA":100,"indeksB":22,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Jabuka' and term_b = 'Orhideja' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 4, id, '{"a":"Jabuka","b":"Zlatibor","indeksA":29,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Jabuka' and term_b = 'Zlatibor' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 5, id, '{"a":"Kragujevac","b":"Zlatibor","indeksA":100,"indeksB":48,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Kragujevac' and term_b = 'Zlatibor' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 6, id, '{"a":"Kragujevac","b":"WhatsApp","indeksA":100,"indeksB":22,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Kragujevac' and term_b = 'WhatsApp' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 7, id, '{"a":"Kragujevac","b":"Vremenska prognoza","indeksA":30,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Kragujevac' and term_b = 'Vremenska prognoza' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 8, id, '{"a":"iPhone","b":"Vremenska prognoza","indeksA":25,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'iPhone' and term_b = 'Vremenska prognoza' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 1, id, '{"a":"Punjene paprike","b":"Tulumbe","indeksA":100,"indeksB":33,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Punjene paprike' and term_b = 'Tulumbe' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 2, id, '{"a":"Punjene paprike","b":"Ćevapi","indeksA":44,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Punjene paprike' and term_b = 'Ćevapi' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 3, id, '{"a":"Engleski jezik","b":"Ćevapi","indeksA":35,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Engleski jezik' and term_b = 'Ćevapi' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 4, id, '{"a":"Kurs evra","b":"Ćevapi","indeksA":100,"indeksB":33,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Kurs evra' and term_b = 'Ćevapi' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 5, id, '{"a":"Kurs evra","b":"Nokia","indeksA":100,"indeksB":32,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Kurs evra' and term_b = 'Nokia' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 6, id, '{"a":"Kurs evra","b":"Usisivač","indeksA":49,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Kurs evra' and term_b = 'Usisivač' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 7, id, '{"a":"Grčka","b":"Usisivač","indeksA":100,"indeksB":39,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Grčka' and term_b = 'Usisivač' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 8, id, '{"a":"Grčka","b":"Tenis","indeksA":100,"indeksB":58,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Grčka' and term_b = 'Tenis' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 1, id, '{"a":"Klima","b":"Huawei","indeksA":100,"indeksB":40,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Klima' and term_b = 'Huawei' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 2, id, '{"a":"Klima","b":"Kafa","indeksA":65,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Klima' and term_b = 'Kafa' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 3, id, '{"a":"Halo oglasi","b":"Kafa","indeksA":47,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Halo oglasi' and term_b = 'Kafa' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 4, id, '{"a":"Crna Gora","b":"Kafa","indeksA":100,"indeksB":78,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Crna Gora' and term_b = 'Kafa' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 5, id, '{"a":"Crna Gora","b":"Palačinke","indeksA":100,"indeksB":23,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Crna Gora' and term_b = 'Palačinke' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 6, id, '{"a":"Crna Gora","b":"Odbojka","indeksA":100,"indeksB":39,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Crna Gora' and term_b = 'Odbojka' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 7, id, '{"a":"Crna Gora","b":"Čačak","indeksA":67,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Crna Gora' and term_b = 'Čačak' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 8, id, '{"a":"Kopaonik","b":"Čačak","indeksA":24,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Kopaonik' and term_b = 'Čačak' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 1, id, '{"a":"Krastavac","b":"Željko Joksimović","indeksA":100,"indeksB":29,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Krastavac' and term_b = 'Željko Joksimović' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 2, id, '{"a":"Krastavac","b":"Ruža","indeksA":34,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Krastavac' and term_b = 'Ruža' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 3, id, '{"a":"Hrvatska","b":"Ruža","indeksA":100,"indeksB":24,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Hrvatska' and term_b = 'Ruža' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 4, id, '{"a":"Hrvatska","b":"Facebook","indeksA":31,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Hrvatska' and term_b = 'Facebook' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 5, id, '{"a":"Subotica","b":"Facebook","indeksA":42,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Subotica' and term_b = 'Facebook' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 6, id, '{"a":"Zlatibor","b":"Facebook","indeksA":26,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Zlatibor' and term_b = 'Facebook' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 7, id, '{"a":"Vremenska prognoza","b":"Facebook","indeksA":100,"indeksB":56,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vremenska prognoza' and term_b = 'Facebook' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 8, id, '{"a":"Vremenska prognoza","b":"Fudbal","indeksA":100,"indeksB":40,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vremenska prognoza' and term_b = 'Fudbal' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 1, id, '{"a":"Aca Lukas","b":"Sarma","indeksA":100,"indeksB":63,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Aca Lukas' and term_b = 'Sarma' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 2, id, '{"a":"Aca Lukas","b":"Paradajz","indeksA":24,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Aca Lukas' and term_b = 'Paradajz' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 3, id, '{"a":"Gulaš","b":"Paradajz","indeksA":27,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Gulaš' and term_b = 'Paradajz' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 4, id, '{"a":"Nikola Jokić","b":"Paradajz","indeksA":63,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Nikola Jokić' and term_b = 'Paradajz' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 5, id, '{"a":"Vrnjačka Banja","b":"Paradajz","indeksA":100,"indeksB":62,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vrnjačka Banja' and term_b = 'Paradajz' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 6, id, '{"a":"Vrnjačka Banja","b":"TikTok","indeksA":53,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Vrnjačka Banja' and term_b = 'TikTok' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 7, id, '{"a":"Zaječar","b":"TikTok","indeksA":40,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Zaječar' and term_b = 'TikTok' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 8, id, '{"a":"Košarka","b":"TikTok","indeksA":100,"indeksB":72,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Košarka' and term_b = 'TikTok' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 1, id, '{"a":"Pljeskavica","b":"Paprika","indeksA":25,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Pljeskavica' and term_b = 'Paprika' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 2, id, '{"a":"Zdravko Čolić","b":"Paprika","indeksA":57,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Zdravko Čolić' and term_b = 'Paprika' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 3, id, '{"a":"Malina","b":"Paprika","indeksA":63,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Malina' and term_b = 'Paprika' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 4, id, '{"a":"Pivo","b":"Paprika","indeksA":100,"indeksB":51,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Pivo' and term_b = 'Paprika' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 5, id, '{"a":"Pivo","b":"Mercedes","indeksA":58,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Pivo' and term_b = 'Mercedes' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 6, id, '{"a":"Instagram","b":"Mercedes","indeksA":100,"indeksB":28,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Instagram' and term_b = 'Mercedes' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 7, id, '{"a":"Instagram","b":"Usisivač","indeksA":100,"indeksB":21,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Instagram' and term_b = 'Usisivač' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 8, id, '{"a":"Instagram","b":"KupujemProdajem","indeksA":64,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Instagram' and term_b = 'KupujemProdajem' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 1, id, '{"a":"Banja Koviljača","b":"Božur","indeksA":100,"indeksB":53,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Banja Koviljača' and term_b = 'Božur' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 2, id, '{"a":"Banja Koviljača","b":"Ceca","indeksA":36,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Banja Koviljača' and term_b = 'Ceca' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 3, id, '{"a":"Bogdan Bogdanović","b":"Ceca","indeksA":24,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Bogdan Bogdanović' and term_b = 'Ceca' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 4, id, '{"a":"Rakija","b":"Ceca","indeksA":100,"indeksB":52,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Rakija' and term_b = 'Ceca' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 5, id, '{"a":"Rakija","b":"Istorija","indeksA":100,"indeksB":40,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Rakija' and term_b = 'Istorija' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 6, id, '{"a":"Rakija","b":"Tenis","indeksA":50,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Rakija' and term_b = 'Tenis' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 7, id, '{"a":"Veš mašina","b":"Tenis","indeksA":56,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Veš mašina' and term_b = 'Tenis' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 8, id, '{"a":"Horoskop","b":"Tenis","indeksA":100,"indeksB":80,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Horoskop' and term_b = 'Tenis' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 1, id, '{"a":"Ljubičica","b":"Vanilice","indeksA":60,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Ljubičica' and term_b = 'Vanilice' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 2, id, '{"a":"Fruška gora","b":"Vanilice","indeksA":100,"indeksB":21,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Fruška gora' and term_b = 'Vanilice' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 3, id, '{"a":"Fruška gora","b":"Sokobanja","indeksA":42,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Fruška gora' and term_b = 'Sokobanja' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 4, id, '{"a":"Krompir","b":"Sokobanja","indeksA":100,"indeksB":78,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Krompir' and term_b = 'Sokobanja' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 5, id, '{"a":"Krompir","b":"Šporet","indeksA":100,"indeksB":27,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Krompir' and term_b = 'Šporet' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 6, id, '{"a":"Krompir","b":"Dušan Vlahović","indeksA":100,"indeksB":22,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Krompir' and term_b = 'Dušan Vlahović' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 7, id, '{"a":"Krompir","b":"Čaj","indeksA":51,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Krompir' and term_b = 'Čaj' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 8, id, '{"a":"Huawei","b":"Čaj","indeksA":28,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Huawei' and term_b = 'Čaj' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 1, id, '{"a":"Dušan Tadić","b":"Podvarak","indeksA":63,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Dušan Tadić' and term_b = 'Podvarak' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 2, id, '{"a":"Geografija","b":"Podvarak","indeksA":100,"indeksB":54,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Geografija' and term_b = 'Podvarak' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 3, id, '{"a":"Geografija","b":"Vanilice","indeksA":100,"indeksB":50,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Geografija' and term_b = 'Vanilice' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 4, id, '{"a":"Geografija","b":"Ljubičica","indeksA":100,"indeksB":30,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Geografija' and term_b = 'Ljubičica' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 5, id, '{"a":"Geografija","b":"Kupindo","indeksA":39,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Geografija' and term_b = 'Kupindo' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 6, id, '{"a":"Sokobanja","b":"Kupindo","indeksA":100,"indeksB":44,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Sokobanja' and term_b = 'Kupindo' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 7, id, '{"a":"Sokobanja","b":"Ceca","indeksA":100,"indeksB":65,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Sokobanja' and term_b = 'Ceca' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 8, id, '{"a":"Sokobanja","b":"Zaječar","indeksA":74,"indeksB":100,"period":"14.11.2025 – 14.11.2026","preuzeto":"2026-11-14"}'::jsonb
  from public.trend_pairs where term_a = 'Sokobanja' and term_b = 'Zaječar' and period = '14.11.2025 – 14.11.2026'
  on conflict (quiz_date, segment, position) do nothing;

-- Isto što i migracija 0004: ponovljeno ovde da seed radi i ako ona nije puštena.
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
alter table public.daily_quiz_items add column if not exists film_still_id bigint references public.film_stills (id);
alter table public.daily_quiz_items drop constraint if exists stavka_odgovara_segmentu;
alter table public.daily_quiz_items add constraint stavka_odgovara_segmentu check (
  num_nonnulls(song_id, product_id, trend_pair_id, film_clip_id, film_still_id, rebus_id) = 1
  and ((segment = 1 and song_id is not null) or (segment = 2 and product_id is not null) or (segment = 3 and trend_pair_id is not null)
    or (segment = 4 and (film_clip_id is not null or film_still_id is not null)) or (segment = 5 and rebus_id is not null))
);

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

-- Dnevni kviz: segment 4 (Pogodi domaći film/seriju). Dan koji već ima stavke se ne dira.
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-14', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-14', 4, 1, id, '{"naslov":"Svadba","alias":[],"slika":"/kadrovi/3f44ee5376ac8f.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/3f44ee5376ac8f.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-14', 4, 2, id, '{"naslov":"Varljivo leto ''68","alias":["Varljivo leto"],"slika":"/kadrovi/69d278902e4c57.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/69d278902e4c57.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-14', 4, 3, id, '{"naslov":"Zona Zamfirova","alias":["Zona"],"slika":"/kadrovi/0b6135f7ced4ae.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/0b6135f7ced4ae.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-15', 4, 1, id, '{"naslov":"Mali Budo","alias":[],"slika":"/kadrovi/8d3472b446bb96.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/8d3472b446bb96.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-15', 4, 2, id, '{"naslov":"Parada","alias":[],"slika":"/kadrovi/5d7b9193da21b5.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/5d7b9193da21b5.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-15', 4, 3, id, '{"naslov":"Greh njene majke","alias":[],"slika":"/kadrovi/98c04ce7ffd86f.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/98c04ce7ffd86f.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-16', 4, 1, id, '{"naslov":"Sedam i po","alias":["7 i po"],"slika":"/kadrovi/51593cb69f6231.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/51593cb69f6231.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-16', 4, 2, id, '{"naslov":"Nedelja","alias":[],"slika":"/kadrovi/3a05c0c3d6723a.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/3a05c0c3d6723a.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-16', 4, 3, id, '{"naslov":"Kad porastem biću Kengur","alias":["Kengur"],"slika":"/kadrovi/2342208e45e0d5.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/2342208e45e0d5.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-17', 4, 1, id, '{"naslov":"Ko to tamo peva","alias":[],"slika":"/kadrovi/dfd186e39dc288.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/dfd186e39dc288.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-17', 4, 2, id, '{"naslov":"Ubice mog oca","alias":["Ubice moga oca"],"slika":"/kadrovi/ce43a77331335f.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/ce43a77331335f.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-17', 4, 3, id, '{"naslov":"Maratonci trče počasni krug","alias":["Maratonci"],"slika":"/kadrovi/26fcfdf6ce0b4e.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/26fcfdf6ce0b4e.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-18', 4, 1, id, '{"naslov":"Ranjeni orao","alias":[],"slika":"/kadrovi/051f731cbbfa6a.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/051f731cbbfa6a.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-18', 4, 2, id, '{"naslov":"Lepa sela lepo gore","alias":["Lepa sela"],"slika":"/kadrovi/27aca52c471053.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/27aca52c471053.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-18', 4, 3, id, '{"naslov":"Munje!","alias":[],"slika":"/kadrovi/b78562811e4dfd.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/b78562811e4dfd.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-19', 4, 1, id, '{"naslov":"Apsolutnih sto","alias":["Apsolutnih 100"],"slika":"/kadrovi/d9743ac1239e02.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/d9743ac1239e02.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-19', 4, 2, id, '{"naslov":"Nož","alias":[],"slika":"/kadrovi/0f95a920c25413.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/0f95a920c25413.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-19', 4, 3, id, '{"naslov":"Balkanski špijun","alias":[],"slika":"/kadrovi/266f47b4bf4330.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/266f47b4bf4330.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-20', 4, 1, id, '{"naslov":"Lajanje na zvezde","alias":[],"slika":"/kadrovi/910755bdb2d3ed.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/910755bdb2d3ed.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-20', 4, 2, id, '{"naslov":"Tesna koža","alias":[],"slika":"/kadrovi/3888635e9b8672.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/3888635e9b8672.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-20', 4, 3, id, '{"naslov":"Toma","alias":[],"slika":"/kadrovi/35d341e7bddb04.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/35d341e7bddb04.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-21', 4, 1, id, '{"naslov":"Montevideo, Bog te video!","alias":["Montevideo"],"slika":"/kadrovi/c9bf06d591b178.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/c9bf06d591b178.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-21', 4, 2, id, '{"naslov":"Zlatni dečko","alias":[],"slika":"/kadrovi/e21b6c218911f0.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/e21b6c218911f0.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-21', 4, 3, id, '{"naslov":"Južni vetar","alias":[],"slika":"/kadrovi/b54ac478dd9f9e.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/b54ac478dd9f9e.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-22', 4, 1, id, '{"naslov":"Valter brani Sarajevo","alias":["Valter"],"slika":"/kadrovi/aea6ef7f9e918e.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/aea6ef7f9e918e.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-22', 4, 2, id, '{"naslov":"Senke nad Balkanom","alias":[],"slika":"/kadrovi/99e6fa37dacc76.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/99e6fa37dacc76.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-22', 4, 3, id, '{"naslov":"Ivkova slava","alias":[],"slika":"/kadrovi/64db2b1fcfaceb.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/64db2b1fcfaceb.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-23', 4, 1, id, '{"naslov":"Mrtav ''ladan","alias":["Mrtav hladan"],"slika":"/kadrovi/8cbcf42b3b8c7c.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/8cbcf42b3b8c7c.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-23', 4, 2, id, '{"naslov":"Južni vetar","alias":[],"slika":"/kadrovi/b54ac478dd9f9e.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/b54ac478dd9f9e.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-23', 4, 3, id, '{"naslov":"Zona Zamfirova","alias":["Zona"],"slika":"/kadrovi/0b6135f7ced4ae.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/0b6135f7ced4ae.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-24', 4, 1, id, '{"naslov":"Svadba","alias":[],"slika":"/kadrovi/3f44ee5376ac8f.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/3f44ee5376ac8f.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-24', 4, 2, id, '{"naslov":"Maratonci trče počasni krug","alias":["Maratonci"],"slika":"/kadrovi/26fcfdf6ce0b4e.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/26fcfdf6ce0b4e.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-24', 4, 3, id, '{"naslov":"Ko to tamo peva","alias":[],"slika":"/kadrovi/dfd186e39dc288.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/dfd186e39dc288.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-25', 4, 1, id, '{"naslov":"Ivkova slava","alias":[],"slika":"/kadrovi/64db2b1fcfaceb.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/64db2b1fcfaceb.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-25', 4, 2, id, '{"naslov":"Ranjeni orao","alias":[],"slika":"/kadrovi/051f731cbbfa6a.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/051f731cbbfa6a.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-25', 4, 3, id, '{"naslov":"Lepa sela lepo gore","alias":["Lepa sela"],"slika":"/kadrovi/27aca52c471053.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/27aca52c471053.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-26', 4, 1, id, '{"naslov":"Valter brani Sarajevo","alias":["Valter"],"slika":"/kadrovi/aea6ef7f9e918e.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/aea6ef7f9e918e.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-26', 4, 2, id, '{"naslov":"Kad porastem biću Kengur","alias":["Kengur"],"slika":"/kadrovi/2342208e45e0d5.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/2342208e45e0d5.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-26', 4, 3, id, '{"naslov":"Sedam i po","alias":["7 i po"],"slika":"/kadrovi/51593cb69f6231.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/51593cb69f6231.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-27', 4, 1, id, '{"naslov":"Parada","alias":[],"slika":"/kadrovi/5d7b9193da21b5.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/5d7b9193da21b5.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-27', 4, 2, id, '{"naslov":"Nedelja","alias":[],"slika":"/kadrovi/3a05c0c3d6723a.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/3a05c0c3d6723a.webp'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, film_still_id, snapshot)
  select '2026-11-27', 4, 3, id, '{"naslov":"Lajanje na zvezde","alias":[],"slika":"/kadrovi/910755bdb2d3ed.webp"}'::jsonb
  from public.film_stills where image_url = '/kadrovi/910755bdb2d3ed.webp'
  on conflict (quiz_date, segment, position) do nothing;
