-- ───────────────────────────────────────────────────────────────
-- BRISANJE PROBNIH NALOGA (neobavezno, ali preporučeno)
--
-- Nalozi napravljeni dok je prijava išla preko mejla više ne mogu da se prijave
-- (sada se ulazi nadimkom i šifrom), a njihovi nadimci stoje zauzeti.
-- Ovo briše SVE naloge, profile i rezultate. Pitanja ostaju.
--
-- Kako: Supabase → SQL Editor → New query → nalepi → Run.
-- ───────────────────────────────────────────────────────────────

delete from auth.users;
