-- Joker pitanje može da ima fotografiju koja se vidi UZ pitanje („pogodi čoveka sa slike”),
-- pored one koja iskoči tek posle odgovora.

alter table public.joker_questions add column if not exists question_image_url text;
