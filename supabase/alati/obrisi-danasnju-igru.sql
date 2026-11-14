-- SAMO ZA PROBU: briše današnje odigrane igre, da sajt može ponovo da se odigra.
-- Nalepi u Supabase → SQL Editor → Run.
-- Odgovori se brišu sami (vezani su za igru), pitanja i nalozi ostaju netaknuti.

delete from public.plays
where quiz_date = (now() at time zone 'Europe/Belgrade')::date;
