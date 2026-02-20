-- ============================================
-- Storage: 画像保存用バケットの作成
-- ============================================

-- 1. バケットの作成 (post-images)
insert into storage.buckets (id, name, public)
values ('post-images', 'post-images', true)
on conflict (id) do nothing;

-- 2. RLSポリシーの設定

-- 誰でも閲覧可能
create policy "Public Access"
  on storage.objects for select
  using ( bucket_id = 'post-images' );

-- 認証済みユーザーのみアップロード可能
create policy "Authenticated users can upload"
  on storage.objects for insert
  to authenticated
  with check ( bucket_id = 'post-images' );

-- 自分のアップロードした画像のみ削除可能
create policy "Users can delete own images"
  on storage.objects for delete
  to authenticated
  using ( bucket_id = 'post-images' and auth.uid() = owner );
