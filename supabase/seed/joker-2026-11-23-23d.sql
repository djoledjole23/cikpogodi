-- Joker pitanja za 23.11–15.12.2026 (iz data/joker.json). Dan koji već ima Jokera se ne dira.
begin;
-- Dnevni kviz: segment 5 (Joker pitanje). Dan koji već ima Jokera se ne dira.
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji fudbaler je ugrizao protivnika na Svetskom prvenstvu 2014. godine?', 'Luis Suárez', array['Suarez', 'Luis Suarez', 'Suares', 'Luis Suares']::text[], null, null, '2014', 'Suárez ugrizao Kjelinija')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-23', 5, 1, id, '{"pitanje":"Koji fudbaler je ugrizao protivnika na Svetskom prvenstvu 2014. godine?","odgovor":"Luis Suárez","alias":["Suarez","Luis Suarez","Suares","Luis Suares"],"slika":null,"slikaPitanja":null,"broj":"2014","natpis":"Suárez ugrizao Kjelinija"}'::jsonb
  from public.joker_questions where question = 'Koji fudbaler je ugrizao protivnika na Svetskom prvenstvu 2014. godine?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove splav koji je potonuo tokom dočeka Nove 2023. godine u Beogradu?', 'Freestyler', array['Fristajler', 'Free styler', 'Fri stajler']::text[], null, null, '400+', 'gostiju na splavu za 220')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-24', 5, 1, id, '{"pitanje":"Kako se zove splav koji je potonuo tokom dočeka Nove 2023. godine u Beogradu?","odgovor":"Freestyler","alias":["Fristajler","Free styler","Fri stajler"],"slika":null,"slikaPitanja":null,"broj":"400+","natpis":"gostiju na splavu za 220"}'::jsonb
  from public.joker_questions where question = 'Kako se zove splav koji je potonuo tokom dočeka Nove 2023. godine u Beogradu?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji glumac je poznat po memu da ostavi devojku čim ona napuni 25 godina?', 'Leonardo DiCaprio', array['DiCaprio', 'Dikaprio', 'Leonardo Dikaprio', 'Leo']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-25', 5, 1, id, '{"pitanje":"Koji glumac je poznat po memu da ostavi devojku čim ona napuni 25 godina?","odgovor":"Leonardo DiCaprio","alias":["DiCaprio","Dikaprio","Leonardo Dikaprio","Leo"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koji glumac je poznat po memu da ostavi devojku čim ona napuni 25 godina?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zvala stranka Ljubiše Preletačevića Belog?', 'Sarmu probo nisi', array['SPN', 'Sarmu probo nisi (SPN)', 'Sarmu proba nisi']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-26', 5, 1, id, '{"pitanje":"Kako se zvala stranka Ljubiše Preletačevića Belog?","odgovor":"Sarmu probo nisi","alias":["SPN","Sarmu probo nisi (SPN)","Sarmu proba nisi"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zvala stranka Ljubiše Preletačevića Belog?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Na čijem koncertu je kiss cam 2025. godine otkrio jednu od najpraćenijih ljubavnih afera godine?', 'Coldplay', array['Koldplej', 'Cold play']::text[], null, null, '2025', 'godina skandala')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-27', 5, 1, id, '{"pitanje":"Na čijem koncertu je kiss cam 2025. godine otkrio jednu od najpraćenijih ljubavnih afera godine?","odgovor":"Coldplay","alias":["Koldplej","Cold play"],"slika":null,"slikaPitanja":null,"broj":"2025","natpis":"godina skandala"}'::jsonb
  from public.joker_questions where question = 'Na čijem koncertu je kiss cam 2025. godine otkrio jednu od najpraćenijih ljubavnih afera godine?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji poznati milijarder je kupio društvenu mrežu Twitter i promenio joj naziv u X?', 'Elon Musk', array['Musk', 'Ilon Mask', 'Elon Mask', 'Mask']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-28', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-28', 5, 1, id, '{"pitanje":"Koji poznati milijarder je kupio društvenu mrežu Twitter i promenio joj naziv u X?","odgovor":"Elon Musk","alias":["Musk","Ilon Mask","Elon Mask","Mask"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koji poznati milijarder je kupio društvenu mrežu Twitter i promenio joj naziv u X?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove maskota McDonald''s-a, klovn crvene kose?', 'Ronald McDonald', array['Ronald', 'Ronald Mekdonald', 'Ronald MekDonald']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-29', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-29', 5, 1, id, '{"pitanje":"Kako se zove maskota McDonald''s-a, klovn crvene kose?","odgovor":"Ronald McDonald","alias":["Ronald","Ronald Mekdonald","Ronald MekDonald"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zove maskota McDonald''s-a, klovn crvene kose?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koja pevačica je izjavila: „Ja sam poliglota, volim životinje”?', 'Zorica Marković', array['Zorica Markovic', 'Marković']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-30', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-11-30', 5, 1, id, '{"pitanje":"Koja pevačica je izjavila: „Ja sam poliglota, volim životinje”?","odgovor":"Zorica Marković","alias":["Zorica Markovic","Marković"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koja pevačica je izjavila: „Ja sam poliglota, volim životinje”?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove bokser kome je Majk Tajson odgrizao deo uva?', 'Evander Holyfield', array['Holyfield', 'Holifild', 'Evander Holifild', 'Evander']::text[], null, null, '1997', 'godina meča')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-01', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-01', 5, 1, id, '{"pitanje":"Kako se zove bokser kome je Majk Tajson odgrizao deo uva?","odgovor":"Evander Holyfield","alias":["Holyfield","Holifild","Evander Holifild","Evander"],"slika":null,"slikaPitanja":null,"broj":"1997","natpis":"godina meča"}'::jsonb
  from public.joker_questions where question = 'Kako se zove bokser kome je Majk Tajson odgrizao deo uva?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji poznati glumac se potukao sa navijačem oko mesta na utakmici Crvene zvezde?', 'Milan Kalinić', array['Kalinić', 'Kalinic', 'Milan Kalinic']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-02', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-02', 5, 1, id, '{"pitanje":"Koji poznati glumac se potukao sa navijačem oko mesta na utakmici Crvene zvezde?","odgovor":"Milan Kalinić","alias":["Kalinić","Kalinic","Milan Kalinic"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koji poznati glumac se potukao sa navijačem oko mesta na utakmici Crvene zvezde?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji teniser je diskvalifikovan sa US Opena 2020. pošto je lopticom pogodio linijsku sudiju?', 'Novak Đoković', array['Đoković', 'Djokovic', 'Đokovic', 'Novak', 'Nole', 'Novak Djokovic']::text[], null, null, '2020', 'US Open')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-03', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-03', 5, 1, id, '{"pitanje":"Koji teniser je diskvalifikovan sa US Opena 2020. pošto je lopticom pogodio linijsku sudiju?","odgovor":"Novak Đoković","alias":["Đoković","Djokovic","Đokovic","Novak","Nole","Novak Djokovic"],"slika":null,"slikaPitanja":null,"broj":"2020","natpis":"US Open"}'::jsonb
  from public.joker_questions where question = 'Koji teniser je diskvalifikovan sa US Opena 2020. pošto je lopticom pogodio linijsku sudiju?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove glavna junakinja igrice GTA 6?', 'Lucia', array['Lusija', 'Lućija', 'Lucija', 'Lucia Caminos']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-04', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-04', 5, 1, id, '{"pitanje":"Kako se zove glavna junakinja igrice GTA 6?","odgovor":"Lucia","alias":["Lusija","Lućija","Lucija","Lucia Caminos"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zove glavna junakinja igrice GTA 6?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('I miris i ukus – slogan je kog domaćeg brenda?', 'Grand kafa', array['Grand', 'Grand kafe']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-05', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-05', 5, 1, id, '{"pitanje":"I miris i ukus – slogan je kog domaćeg brenda?","odgovor":"Grand kafa","alias":["Grand","Grand kafe"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'I miris i ukus – slogan je kog domaćeg brenda?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji glumac je na dodeli Oskara 2022. ošamario Krisa Roka?', 'Will Smith', array['Vil Smit', 'Smith', 'Smit', 'Will Smit']::text[], null, null, '2022', 'Oskar')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-06', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-06', 5, 1, id, '{"pitanje":"Koji glumac je na dodeli Oskara 2022. ošamario Krisa Roka?","odgovor":"Will Smith","alias":["Vil Smit","Smith","Smit","Will Smit"],"slika":null,"slikaPitanja":null,"broj":"2022","natpis":"Oskar"}'::jsonb
  from public.joker_questions where question = 'Koji glumac je na dodeli Oskara 2022. ošamario Krisa Roka?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Po kom nadimku je poznat Gašper, finalista Love Island Adria?', 'Širo', array['Siro', 'Šira']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-07', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-07', 5, 1, id, '{"pitanje":"Po kom nadimku je poznat Gašper, finalista Love Island Adria?","odgovor":"Širo","alias":["Siro","Šira"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Po kom nadimku je poznat Gašper, finalista Love Island Adria?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji poznati reper je kupio NFT majmuna (Bored Ape) koji liči na njega, za skoro pola miliona dolara?', 'Eminem', array['Eminen', 'Slim Shady', 'Marshall Mathers']::text[], null, null, '462.000 $', 'toliko je platio majmuna')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-08', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-08', 5, 1, id, '{"pitanje":"Koji poznati reper je kupio NFT majmuna (Bored Ape) koji liči na njega, za skoro pola miliona dolara?","odgovor":"Eminem","alias":["Eminen","Slim Shady","Marshall Mathers"],"slika":null,"slikaPitanja":null,"broj":"462.000 $","natpis":"toliko je platio majmuna"}'::jsonb
  from public.joker_questions where question = 'Koji poznati reper je kupio NFT majmuna (Bored Ape) koji liči na njega, za skoro pola miliona dolara?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji fudbaler je 2006. u finalu Svetskog prvenstva glavom udario Materacija u grudi?', 'Zinedine Zidane', array['Zidane', 'Zidan', 'Zinedin', 'Zinedine', 'Zinedin Zidan']::text[], null, null, '2006', 'finale SP, Berlin')
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-09', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-09', 5, 1, id, '{"pitanje":"Koji fudbaler je 2006. u finalu Svetskog prvenstva glavom udario Materacija u grudi?","odgovor":"Zinedine Zidane","alias":["Zidane","Zidan","Zinedin","Zinedine","Zinedin Zidan"],"slika":null,"slikaPitanja":null,"broj":"2006","natpis":"finale SP, Berlin"}'::jsonb
  from public.joker_questions where question = 'Koji fudbaler je 2006. u finalu Svetskog prvenstva glavom udario Materacija u grudi?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zvao poznati majmun iz jagodinskog zoološkog vrta?', 'Žika', array['Zika']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-10', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-10', 5, 1, id, '{"pitanje":"Kako se zvao poznati majmun iz jagodinskog zoološkog vrta?","odgovor":"Žika","alias":["Zika"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zvao poznati majmun iz jagodinskog zoološkog vrta?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove direktor koji je dao ostavku posle kiss cam snimka sa koncerta Coldplay-a?', 'Andy Byron', array['Byron', 'Endi Bajron', 'Bajron', 'Andi Bajron']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-11', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-11', 5, 1, id, '{"pitanje":"Kako se zove direktor koji je dao ostavku posle kiss cam snimka sa koncerta Coldplay-a?","odgovor":"Andy Byron","alias":["Byron","Endi Bajron","Bajron","Andi Bajron"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zove direktor koji je dao ostavku posle kiss cam snimka sa koncerta Coldplay-a?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Dara Bubamara se pohvalila da je vodila ljubav od 4 do...?', 'pola 7', array['pola sedam', '6 i 30', 'šest i trideset', 'sest i trideset', '18:30', '6:30']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-12', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-12', 5, 1, id, '{"pitanje":"Dara Bubamara se pohvalila da je vodila ljubav od 4 do...?","odgovor":"pola 7","alias":["pola sedam","6 i 30","šest i trideset","sest i trideset","18:30","6:30"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Dara Bubamara se pohvalila da je vodila ljubav od 4 do...?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji bokser glumi samog sebe u filmu Mamurluk (The Hangover)?', 'Mike Tyson', array['Tyson', 'Tajson', 'Majk Tajson', 'Mike Tajson']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-13', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-13', 5, 1, id, '{"pitanje":"Koji bokser glumi samog sebe u filmu Mamurluk (The Hangover)?","odgovor":"Mike Tyson","alias":["Tyson","Tajson","Majk Tajson","Mike Tajson"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koji bokser glumi samog sebe u filmu Mamurluk (The Hangover)?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Koji reper, pored Wiz Khalife, glumi u filmu „Mac & Devin Go to High School”?', 'Snoop Dogg', array['Snoop', 'Snup Dog', 'Snoop Dog', 'Snup']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-14', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-14', 5, 1, id, '{"pitanje":"Koji reper, pored Wiz Khalife, glumi u filmu „Mac & Devin Go to High School”?","odgovor":"Snoop Dogg","alias":["Snoop","Snup Dog","Snoop Dog","Snup"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Koji reper, pored Wiz Khalife, glumi u filmu „Mac & Devin Go to High School”?'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.joker_questions (question, answer, aliases, image_url, question_image_url, reveal_number, reveal_label)
  values ('Kako se zove metalni jezičak na limenci koji povučeš da je otvoriš?', 'sntntn', array['sntntn', 'sntnt', 'sntntntn']::text[], null, null, null, null)
  on conflict (question) do update set answer = excluded.answer, aliases = excluded.aliases, image_url = excluded.image_url,
    question_image_url = excluded.question_image_url, reveal_number = excluded.reveal_number, reveal_label = excluded.reveal_label;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-12-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, joker_id, snapshot)
  select '2026-12-15', 5, 1, id, '{"pitanje":"Kako se zove metalni jezičak na limenci koji povučeš da je otvoriš?","odgovor":"sntntn","alias":["sntntn","sntnt","sntntntn"],"slika":null,"slikaPitanja":null,"broj":null,"natpis":null}'::jsonb
  from public.joker_questions where question = 'Kako se zove metalni jezičak na limenci koji povučeš da je otvoriš?'
  on conflict (quiz_date, segment, position) do nothing;
commit;
