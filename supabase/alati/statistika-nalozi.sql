-- ───────────────────────────────────────────────────────────────
-- KOLIKO IMA NALOGA I KO SE VRAĆA
-- Supabase → SQL Editor → nalepi → Run.
-- ───────────────────────────────────────────────────────────────

select
  (select count(*)::int from public.profiles where username is not null)              as ukupno_naloga,
  (select count(*)::int from public.plays
     where user_id is not null and status = 'finished'
       and quiz_date = (now() at time zone 'Europe/Belgrade')::date)                  as igrali_danas,
  (select count(*)::int from (
      select user_id from public.plays
       where user_id is not null and status = 'finished'
       group by user_id having count(*) >= 2) x)                                      as vratili_se_bar_dvaput,
  (select coalesce(round(avg(dana), 1), 0)::float8 from (
      select user_id, count(*)::int as dana from public.plays
       where user_id is not null and status = 'finished'
       group by user_id) y)                                                           as prosecno_dana_po_igracu;
