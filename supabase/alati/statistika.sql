-- ───────────────────────────────────────────────────────────────
-- KOLIKO LJUDI IGRA
-- Supabase → SQL Editor → nalepi → Run. Pusti koliko god puta hoćeš, ništa ne menja.
-- ───────────────────────────────────────────────────────────────

select
  coalesce(quiz_date::text, 'UKUPNO (14 dana)')          as dan,
  count(*)::int                                          as pokrenuto,
  count(*) filter (where status = 'finished')::int       as odigrano_do_kraja,
  count(*) filter (where user_id is not null)::int       as sa_nalogom,
  count(*) filter (where user_id is null)::int           as gosti,
  count(distinct device_id)::int                         as razlicitih_uredjaja,
  coalesce(round(avg(score) filter (where status = 'finished')), 0)::int as prosecan_rezultat,
  coalesce(max(score), 0)::int                           as najbolji_rezultat
from public.plays
where quiz_date >= (now() at time zone 'Europe/Belgrade')::date - 13
group by rollup (quiz_date)
order by quiz_date desc nulls last;
