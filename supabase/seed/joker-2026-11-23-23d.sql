-- Joker pitanja za 23.11–15.12.2026 (iz data/joker.json). Dan koji već ima Jokera se ne dira.
begin;
-- Dnevni kviz: segment 5 (Joker pitanje). Dan koji već ima Jokera se ne dira.
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
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove maskota McDonald''s-a, klovn crvene kose?', 'Ronald McDonald', array['Ronald', 'Ronald Mekdonald', 'Ronald MekDonald']::text[], '/joker/73238b594460c7.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-29', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-29', 5, 1, id, '{"pitanje":"Kako se zove maskota McDonald''s-a, klovn crvene kose?","odgovor":"Ronald McDonald","alias":["Ronald","Ronald Mekdonald","Ronald MekDonald"],"slika":"/joker/73238b594460c7.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zove maskota McDonald''s-a, klovn crvene kose?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koja pevačica je izjavila: „Ja sam poliglota, volim životinje”?', 'Zorica Marković', array['Zorica Markovic', 'Marković']::text[], '/joker/fab5bb51fc6dd0.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-30', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-30', 5, 1, id, '{"pitanje":"Koja pevačica je izjavila: „Ja sam poliglota, volim životinje”?","odgovor":"Zorica Marković","alias":["Zorica Markovic","Marković"],"slika":"/joker/fab5bb51fc6dd0.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koja pevačica je izjavila: „Ja sam poliglota, volim životinje”?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove bokser kome je Majk Tajson odgrizao deo uva?', 'Evander Holyfield', array['Holyfield', 'Holifild', 'Evander Holifild', 'Evander']::text[], '/joker/64593f1ba64521.webp', null, '1997', 'godina meča')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-01', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-01', 5, 1, id, '{"pitanje":"Kako se zove bokser kome je Majk Tajson odgrizao deo uva?","odgovor":"Evander Holyfield","alias":["Holyfield","Holifild","Evander Holifild","Evander"],"slika":"/joker/64593f1ba64521.webp","slikaPitanja":null,"broj":"1997","natpis":"godina meča"}'::jsonb
  from public.joker_questions where question = 'Kako se zove bokser kome je Majk Tajson odgrizao deo uva?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji poznati glumac se potukao sa navijačem oko mesta na utakmici Crvene zvezde?', 'Milan Kalinić', array['Kalinić', 'Kalinic', 'Milan Kalinic']::text[], '/joker/9355fa02096e27.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-02', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-02', 5, 1, id, '{"pitanje":"Koji poznati glumac se potukao sa navijačem oko mesta na utakmici Crvene zvezde?","odgovor":"Milan Kalinić","alias":["Kalinić","Kalinic","Milan Kalinic"],"slika":"/joker/9355fa02096e27.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koji poznati glumac se potukao sa navijačem oko mesta na utakmici Crvene zvezde?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji teniser je diskvalifikovan sa US Opena 2020. pošto je lopticom pogodio linijsku sudiju?', 'Novak Đoković', array['Đoković', 'Djokovic', 'Đokovic', 'Novak', 'Nole', 'Novak Djokovic']::text[], '/joker/f537b6016ee371.webp', null, '2020', 'US Open')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-03', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-03', 5, 1, id, '{"pitanje":"Koji teniser je diskvalifikovan sa US Opena 2020. pošto je lopticom pogodio linijsku sudiju?","odgovor":"Novak Đoković","alias":["Đoković","Djokovic","Đokovic","Novak","Nole","Novak Djokovic"],"slika":"/joker/f537b6016ee371.webp","slikaPitanja":null,"broj":"2020","natpis":"US Open"}'::jsonb
  from public.joker_questions where question = 'Koji teniser je diskvalifikovan sa US Opena 2020. pošto je lopticom pogodio linijsku sudiju?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove glavna junakinja igrice GTA 6?', 'Lucia', array['Lusija', 'Lućija', 'Lucija', 'Lucia Caminos']::text[], '/joker/5f4bbd01065f02.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-04', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-04', 5, 1, id, '{"pitanje":"Kako se zove glavna junakinja igrice GTA 6?","odgovor":"Lucia","alias":["Lusija","Lućija","Lucija","Lucia Caminos"],"slika":"/joker/5f4bbd01065f02.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zove glavna junakinja igrice GTA 6?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('I miris i ukus – slogan je kog domaćeg brenda?', 'Grand kafa', array['Grand', 'Grand kafe']::text[], '/joker/35d7d52cab8444.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-05', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-05', 5, 1, id, '{"pitanje":"I miris i ukus – slogan je kog domaćeg brenda?","odgovor":"Grand kafa","alias":["Grand","Grand kafe"],"slika":"/joker/35d7d52cab8444.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'I miris i ukus – slogan je kog domaćeg brenda?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji glumac je na dodeli Oskara 2022. ošamario Krisa Roka?', 'Will Smith', array['Vil Smit', 'Smith', 'Smit', 'Will Smit']::text[], '/joker/d50b800f18e1d1.webp', null, '2022', 'Oskar')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-06', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-06', 5, 1, id, '{"pitanje":"Koji glumac je na dodeli Oskara 2022. ošamario Krisa Roka?","odgovor":"Will Smith","alias":["Vil Smit","Smith","Smit","Will Smit"],"slika":"/joker/d50b800f18e1d1.webp","slikaPitanja":null,"broj":"2022","natpis":"Oskar"}'::jsonb
  from public.joker_questions where question = 'Koji glumac je na dodeli Oskara 2022. ošamario Krisa Roka?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Po kom nadimku je poznat Gašper, finalista Love Island Adria?', 'Širo', array['Siro', 'Šira']::text[], '/joker/6f441c3564e9c8.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-07', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-07', 5, 1, id, '{"pitanje":"Po kom nadimku je poznat Gašper, finalista Love Island Adria?","odgovor":"Širo","alias":["Siro","Šira"],"slika":"/joker/6f441c3564e9c8.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Po kom nadimku je poznat Gašper, finalista Love Island Adria?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji poznati reper je kupio NFT majmuna (Bored Ape) koji liči na njega, za skoro pola miliona dolara?', 'Eminem', array['Eminen', 'Slim Shady', 'Marshall Mathers']::text[], '/joker/3c87a2bcb003a2.webp', null, '462.000 $', 'toliko je platio majmuna')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-08', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-08', 5, 1, id, '{"pitanje":"Koji poznati reper je kupio NFT majmuna (Bored Ape) koji liči na njega, za skoro pola miliona dolara?","odgovor":"Eminem","alias":["Eminen","Slim Shady","Marshall Mathers"],"slika":"/joker/3c87a2bcb003a2.webp","slikaPitanja":null,"broj":"462.000 $","natpis":"toliko je platio majmuna"}'::jsonb
  from public.joker_questions where question = 'Koji poznati reper je kupio NFT majmuna (Bored Ape) koji liči na njega, za skoro pola miliona dolara?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji fudbaler je 2006. u finalu Svetskog prvenstva glavom udario Materacija u grudi?', 'Zinedine Zidane', array['Zidane', 'Zidan', 'Zinedin', 'Zinedine', 'Zinedin Zidan']::text[], '/joker/ec01e119429921.webp', null, '2006', 'finale SP, Berlin')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-09', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-09', 5, 1, id, '{"pitanje":"Koji fudbaler je 2006. u finalu Svetskog prvenstva glavom udario Materacija u grudi?","odgovor":"Zinedine Zidane","alias":["Zidane","Zidan","Zinedin","Zinedine","Zinedin Zidan"],"slika":"/joker/ec01e119429921.webp","slikaPitanja":null,"broj":"2006","natpis":"finale SP, Berlin"}'::jsonb
  from public.joker_questions where question = 'Koji fudbaler je 2006. u finalu Svetskog prvenstva glavom udario Materacija u grudi?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zvao poznati majmun iz jagodinskog zoološkog vrta?', 'Žika', array['Zika']::text[], '/joker/e41b87db4732a3.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-10', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-10', 5, 1, id, '{"pitanje":"Kako se zvao poznati majmun iz jagodinskog zoološkog vrta?","odgovor":"Žika","alias":["Zika"],"slika":"/joker/e41b87db4732a3.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zvao poznati majmun iz jagodinskog zoološkog vrta?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove bivši direktor NVIDIE koji je u novembru 2026. otišao sa čela kompanije posle skandala sa vanbračnim aferama?', 'Jensen Huang', array['Huang', 'Džensen Huang', 'Jensen', 'Dzensen Huang', 'Hjuang', 'Džensen']::text[], '/joker/d327eaa422980e.webp', null, '33', 'godine na čelu NVIDIE')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-11', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-11', 5, 1, id, '{"pitanje":"Kako se zove bivši direktor NVIDIE koji je u novembru 2026. otišao sa čela kompanije posle skandala sa vanbračnim aferama?","odgovor":"Jensen Huang","alias":["Huang","Džensen Huang","Jensen","Dzensen Huang","Hjuang","Džensen"],"slika":"/joker/d327eaa422980e.webp","slikaPitanja":null,"broj":"33","natpis":"godine na čelu NVIDIE"}'::jsonb
  from public.joker_questions where question = 'Kako se zove bivši direktor NVIDIE koji je u novembru 2026. otišao sa čela kompanije posle skandala sa vanbračnim aferama?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Dara Bubamara se pohvalila da je vodila ljubav od 4 do...?', 'pola 7', array['pola sedam', '6 i 30', 'šest i trideset', 'sest i trideset', '18:30', '6:30']::text[], '/joker/4aa7e7f7206ef5.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-12', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-12', 5, 1, id, '{"pitanje":"Dara Bubamara se pohvalila da je vodila ljubav od 4 do...?","odgovor":"pola 7","alias":["pola sedam","6 i 30","šest i trideset","sest i trideset","18:30","6:30"],"slika":"/joker/4aa7e7f7206ef5.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Dara Bubamara se pohvalila da je vodila ljubav od 4 do...?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji bokser glumi samog sebe u filmu Mamurluk (The Hangover)?', 'Mike Tyson', array['Tyson', 'Tajson', 'Majk Tajson', 'Mike Tajson']::text[], '/joker/06065e7fd60edf.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-13', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-13', 5, 1, id, '{"pitanje":"Koji bokser glumi samog sebe u filmu Mamurluk (The Hangover)?","odgovor":"Mike Tyson","alias":["Tyson","Tajson","Majk Tajson","Mike Tajson"],"slika":"/joker/06065e7fd60edf.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koji bokser glumi samog sebe u filmu Mamurluk (The Hangover)?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji reper, pored Wiz Khalife, glumi u filmu „Mac & Devin Go to High School”?', 'Snoop Dogg', array['Snoop', 'Snup Dog', 'Snoop Dog', 'Snup']::text[], '/joker/b71a4517b13608.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-14', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-14', 5, 1, id, '{"pitanje":"Koji reper, pored Wiz Khalife, glumi u filmu „Mac & Devin Go to High School”?","odgovor":"Snoop Dogg","alias":["Snoop","Snup Dog","Snoop Dog","Snup"],"slika":"/joker/b71a4517b13608.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koji reper, pored Wiz Khalife, glumi u filmu „Mac & Devin Go to High School”?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove metalni jezičak na limenci koji povučeš da je otvoriš?', 'sntntn', array['sntntn', 'sntnt', 'sntntntn']::text[], '/joker/d6290dfaad4d3a.webp', null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-15', 5, 1, id, '{"pitanje":"Kako se zove metalni jezičak na limenci koji povučeš da je otvoriš?","odgovor":"sntntn","alias":["sntntn","sntnt","sntntntn"],"slika":"/joker/d6290dfaad4d3a.webp","slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zove metalni jezičak na limenci koji povučeš da je otvoriš?'
  on conflict (quiz_date, segment, position) do nothing;
commit;
