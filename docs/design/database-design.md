# データベース設計書：Jimoto-Connect

## 1. 概要
Supabase (PostgreSQL) を使用したデータベース設計。
認証はClerkを使用するが、ユーザー情報はSupabaseの `profiles` テーブルに同期・拡張して管理する。

## 2. テーブル定義

### 2.1 profiles (ユーザープロフィール)
ユーザーの基本情報、出身地、現在地を管理する。

| カラム名 | データ型 | 制約 | 説明 |
|---|---|---|---|
| id | UUID | PK | ClerkのUser IDと一致させる (または別途紐付け) |
| email | TEXT | UNIQUE, NOT NULL | メールアドレス |
| display_name | TEXT | NOT NULL | 表示名（ニックネーム） |
| avatar_url | TEXT | | プロフィール画像のURL |
| bio | TEXT | | 自己紹介文 |
| birth_year | INTEGER | | 生まれ年（検索用） |
| home_prefecture | TEXT | NOT NULL | 出身都道府県 |
| home_city | TEXT | NOT NULL | 出身市区町村 |
| current_prefecture | TEXT | NOT NULL | 現在の都道府県 |
| current_city | TEXT | NOT NULL | 現在の市区町村 |
| current_station | TEXT | | 現在の最寄り駅（任意） |
| created_at | TIMESTAMPTZ | DEFAULT now() | 作成日時 |
| updated_at | TIMESTAMPTZ | DEFAULT now() | 更新日時 |

### 2.2 schools (学校マスタ)
中学校・高校のマスタデータ。
※初期データとして主要な学校をインポートするか、ユーザー登録時に不足分を追加する運用を想定。

| カラム名 | データ型 | 制約 | 説明 |
|---|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() | 学校ID |
| name | TEXT | NOT NULL | 学校名 |
| type | TEXT | NOT NULL | 'junior_high' (中学) or 'high' (高校) |
| prefecture | TEXT | NOT NULL | 都道府県 |
| city | TEXT | NOT NULL | 市区町村 |
| created_at | TIMESTAMPTZ | DEFAULT now() | 作成日時 |

### 2.3 profile_schools (出身校・部活情報)
ユーザーと学校の多対多リレーション。部活動情報もここで管理する。

| カラム名 | データ型 | 制約 | 説明 |
|---|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() | ID |
| profile_id | UUID | FK -> profiles.id | ユーザーID |
| school_id | UUID | FK -> schools.id | 学校ID |
| graduation_year | INTEGER | | 卒業年（任意） |
| club_activities | TEXT[] | | 所属部活の配列 (例: ['baseball', 'band']) |
| created_at | TIMESTAMPTZ | DEFAULT now() | 作成日時 |

### 2.4 posts (投稿・掲示板)
学校別や地域別の掲示板への投稿。

| カラム名 | データ型 | 制約 | 説明 |
|---|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() | 投稿ID |
| author_id | UUID | FK -> profiles.id | 投稿者ID |
| school_id | UUID | FK -> schools.id | 学校掲示板への投稿の場合にセット |
| region_id | TEXT | | 地域掲示板への投稿の場合にセット (例: 'okinawa-tokyo') |
| content | TEXT | NOT NULL | 投稿内容 |
| image_url | TEXT | | 画像URL (任意) |
| created_at | TIMESTAMPTZ | DEFAULT now() | 作成日時 |

### 2.5 likes (いいね)
投稿へのいいね。

| カラム名 | データ型 | 制約 | 説明 |
|---|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() | ID |
| user_id | UUID | FK -> profiles.id | いいねしたユーザー |
| post_id | UUID | FK -> posts.id | 対象の投稿 |
| created_at | TIMESTAMPTZ | DEFAULT now() | 作成日時 |

### 2.6 comments (コメント)
投稿へのコメント（返信）。

| カラム名 | データ型 | 制約 | 説明 |
|---|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() | コメントID |
| user_id | UUID | FK -> profiles.id | コメントしたユーザー |
| post_id | UUID | FK -> posts.id | 対象の投稿 |
| content | TEXT | NOT NULL | コメント内容 |
| created_at | TIMESTAMPTZ | DEFAULT now() | 作成日時 |

## 3. RLS (Row Level Security) ポリシー設計

### profiles
- **SELECT**: 認証済みユーザーは全員閲覧可能。
- **INSERT/UPDATE**: `auth.uid() = id` の場合のみ許可（自分のデータのみ）。

### posts / comments
- **SELECT**: 認証済みユーザーは全員閲覧可能。
- **INSERT**: 認証済みユーザーなら許可。
- **UPDATE/DELETE**: `auth.uid() = author_id` の場合のみ許可（自分の投稿のみ）。

### schools
- **SELECT**: 全員閲覧可能。
- **INSERT**: 認証済みユーザーなら許可（学校が見つからない場合の追加登録用）。

## 4. インデックス設計
検索パフォーマンス向上のため、以下のカラムにインデックスを作成する。

- `profiles`: `home_prefecture`, `current_prefecture`, `birth_year`
- `profile_schools`: `school_id`, `club_activities` (GINインデックス)
- `posts`: `school_id`, `region_id`, `created_at`
