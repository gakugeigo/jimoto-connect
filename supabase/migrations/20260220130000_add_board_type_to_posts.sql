-- 投稿の掲示板種別（全体 / 同級生 / 部活OB）
alter table public.posts add column if not exists board_type text default 'all' check (board_type in ('all', 'classmates', 'club'));
comment on column public.posts.board_type is '掲示板種別: all=全体, classmates=同級生, club=部活OB';
