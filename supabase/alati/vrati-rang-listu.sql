-- Vraća rang listu na original: samo pravi igrači iz plays + profiles.
-- Nalepi u Supabase → SQL Editor → Run.

-- Vraća prvih p_limit mesta i, ako je zadat, red igrača p_user čak i kad nije u vrhu.
-- Kod istog broja poena bolji je onaj ko je ukupno brže odgovarao.
create or replace function public.leaderboard(
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


grant execute on function public.leaderboard(date, date, integer, uuid) to anon, authenticated;
