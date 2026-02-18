-- ============================================
-- Migration: 初期スキーマ作成
-- Purpose: Jimoto-Connect の基本テーブル構造を作成
-- Tables: profiles, schools, profile_schools, posts, likes, comments
-- ============================================

-- 1. profiles (ユーザープロフィール)
create table public.profiles (
  id uuid primary key references auth.users(id), -- ClerkではなくSupabase Authと紐付ける場合はこれだが、Clerkの場合はテキストIDを保存するカラムが必要
  -- Clerk連携のため、idはSupabase Authのidと一致させるか、別途clerk_user_idを持つか。
  -- 今回はClerkのJWTでSupabaseにアクセスするため、auth.uid() はClerkのsub (user_id) になるはずだが、
  -- Clerkのsubはテキスト形式（例: user_2N...）であり、Supabaseのauth.users.idはUUID。
  -- したがって、auth.usersとは紐付けず、独自のprofilesテーブルとして管理し、clerk_user_idをPKにするのが一般的だが、
  -- Promptの指示では `id uuid primary key default gen_random_uuid()` と `clerk_user_id text unique` を分けている。
  -- ここではPromptの指示に従い、clerk_user_id を持つ形にする。
  -- ただし、SupabaseのRLSで `auth.jwt() ->> 'sub'` と比較するため、clerk_user_id は必須。
  
  -- 修正: Supabase Authを使わずClerkのみの場合、usersテーブル（profiles）のIDはUUIDで自動生成し、
  -- clerk_user_id で紐付けるのが良い。
  
  id uuid primary key default gen_random_uuid(),
  clerk_user_id text unique not null,
  email text not null,
  display_name text not null,
  avatar_url text,
  bio text,
  birth_year integer,
  home_prefecture text not null,
  home_city text not null,
  current_prefecture text not null,
  current_city text not null,
  current_station text,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);
comment on table public.profiles is 'ユーザープロフィール情報';

-- RLS
alter table public.profiles enable row level security;

create policy "profiles_select_policy" on public.profiles
  for select to authenticated, anon
  using (true); -- 全員閲覧可能（必要に応じて制限）

create policy "profiles_insert_own_data" on public.profiles
  for insert to authenticated
  with check (clerk_user_id = auth.jwt() ->> 'sub'); -- 自分のデータのみ作成可（Clerk IDが一致）
  -- 注意: auth.jwt() ->> 'sub' が正しく取れる前提。

create policy "profiles_update_own_data" on public.profiles
  for update to authenticated
  using (clerk_user_id = auth.jwt() ->> 'sub')
  with check (clerk_user_id = auth.jwt() ->> 'sub');

-- 2. schools (学校マスタ)
create table public.schools (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  type text not null check (type in ('junior_high', 'high')),
  prefecture text not null,
  city text not null,
  created_at timestamptz default now() not null
);
comment on table public.schools is '学校マスタデータ';

-- RLS
alter table public.schools enable row level security;

create policy "schools_select_policy" on public.schools
  for select to authenticated, anon
  using (true);

create policy "schools_insert_policy" on public.schools
  for insert to authenticated
  with check (true); -- 認証ユーザーなら学校追加OK（運用に合わせて調整）

-- 3. profile_schools (出身校・部活情報)
create table public.profile_schools (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references public.profiles(id) on delete cascade not null,
  school_id uuid references public.schools(id) on delete cascade not null,
  graduation_year integer,
  club_activities text[], -- 配列で保存
  created_at timestamptz default now() not null
);
comment on table public.profile_schools is 'ユーザーの出身校と部活動';

-- RLS
alter table public.profile_schools enable row level security;

create policy "profile_schools_select_policy" on public.profile_schools
  for select to authenticated, anon
  using (true);

create policy "profile_schools_insert_policy" on public.profile_schools
  for insert to authenticated
  with check (
    exists (
      select 1 from public.profiles
      where id = profile_id
      and clerk_user_id = auth.jwt() ->> 'sub'
    )
  ); -- 自分のプロフィールに対してのみ追加可

create policy "profile_schools_update_policy" on public.profile_schools
  for update to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = profile_id
      and clerk_user_id = auth.jwt() ->> 'sub'
    )
  );

create policy "profile_schools_delete_policy" on public.profile_schools
  for delete to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = profile_id
      and clerk_user_id = auth.jwt() ->> 'sub'
    )
  );

-- 4. posts (投稿・掲示板)
create table public.posts (
  id uuid primary key default gen_random_uuid(),
  author_id uuid references public.profiles(id) on delete cascade not null,
  school_id uuid references public.schools(id) on delete cascade,
  region_id text, -- 例: 'okinawa-tokyo'
  content text not null,
  image_url text,
  created_at timestamptz default now() not null
);
comment on table public.posts is '掲示板への投稿';

-- RLS
alter table public.posts enable row level security;

create policy "posts_select_policy" on public.posts
  for select to authenticated, anon
  using (true);

create policy "posts_insert_policy" on public.posts
  for insert to authenticated
  with check (
    exists (
      select 1 from public.profiles
      where id = author_id
      and clerk_user_id = auth.jwt() ->> 'sub'
    )
  );

create policy "posts_update_policy" on public.posts
  for update to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = author_id
      and clerk_user_id = auth.jwt() ->> 'sub'
    )
  );

create policy "posts_delete_policy" on public.posts
  for delete to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = author_id
      and clerk_user_id = auth.jwt() ->> 'sub'
    )
  );

-- 5. likes (いいね)
create table public.likes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  post_id uuid references public.posts(id) on delete cascade not null,
  created_at timestamptz default now() not null,
  unique(user_id, post_id) -- 重複いいね防止
);
comment on table public.likes is '投稿へのいいね';

-- RLS
alter table public.likes enable row level security;

create policy "likes_select_policy" on public.likes
  for select to authenticated, anon
  using (true);

create policy "likes_insert_policy" on public.likes
  for insert to authenticated
  with check (
    exists (
      select 1 from public.profiles
      where id = user_id
      and clerk_user_id = auth.jwt() ->> 'sub'
    )
  );

create policy "likes_delete_policy" on public.likes
  for delete to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = user_id
      and clerk_user_id = auth.jwt() ->> 'sub'
    )
  );

-- 6. comments (コメント)
create table public.comments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  post_id uuid references public.posts(id) on delete cascade not null,
  content text not null,
  created_at timestamptz default now() not null
);
comment on table public.comments is '投稿へのコメント';

-- RLS
alter table public.comments enable row level security;

create policy "comments_select_policy" on public.comments
  for select to authenticated, anon
  using (true);

create policy "comments_insert_policy" on public.comments
  for insert to authenticated
  with check (
    exists (
      select 1 from public.profiles
      where id = user_id
      and clerk_user_id = auth.jwt() ->> 'sub'
    )
  );

create policy "comments_delete_policy" on public.comments
  for delete to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = user_id
      and clerk_user_id = auth.jwt() ->> 'sub'
    )
  );

-- Indexes
create index idx_profiles_clerk_user_id on public.profiles(clerk_user_id);
create index idx_profiles_home_prefecture on public.profiles(home_prefecture);
create index idx_profiles_current_prefecture on public.profiles(current_prefecture);
create index idx_profiles_birth_year on public.profiles(birth_year);

create index idx_profile_schools_school_id on public.profile_schools(school_id);
create index idx_profile_schools_club_activities on public.profile_schools using gin(club_activities);

create index idx_posts_school_id on public.posts(school_id);
create index idx_posts_region_id on public.posts(region_id);
create index idx_posts_created_at on public.posts(created_at);
