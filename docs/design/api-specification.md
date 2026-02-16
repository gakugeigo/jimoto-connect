# API仕様書：Jimoto-Connect

## 1. 概要
Next.js App RouterのServer Actionsを中心に実装する。
クライアントサイドから直接呼ぶAPI Routesは最小限にする。

## 2. Server Actions 一覧

### 2.1 ユーザー関連 (User Actions)

#### `updateProfile(formData: FormData)`
- **説明**: プロフィール情報の更新（オンボーディング含む）。
- **引数**:
  - `displayName`, `bio`, `birthYear`
  - `homePrefecture`, `homeCity`
  - `currentPrefecture`, `currentCity`, `currentStation`
  - `schoolHistory` (JSON: 学校ID, 卒業年, 部活)
- **戻り値**: 更新されたProfileオブジェクト

#### `getProfile(userId: string)`
- **説明**: 指定したユーザーのプロフィール詳細を取得。
- **戻り値**: Profileオブジェクト（学校情報含む）

### 2.2 検索関連 (Search Actions)

#### `searchUsers(params: SearchParams)`
- **説明**: 条件に基づいてユーザーを検索する。
- **引数**:
  - `homePrefecture`, `homeCity`
  - `currentPrefecture`, `currentCity`
  - `schoolId`
  - `clubActivity`
  - `birthYearRange` (start, end)
- **戻り値**: UserProfileの配列

#### `searchSchools(query: string)`
- **説明**: 学校名をキーワード検索する（オートコンプリート用）。
- **引数**: `query` (学校名の一部)
- **戻り値**: Schoolオブジェクトの配列

### 2.3 投稿関連 (Post Actions)

#### `createPost(data: PostData)`
- **説明**: 掲示板に新しい投稿を作成する。
- **引数**:
  - `content`
  - `schoolId` (Optional)
  - `regionId` (Optional)
  - `imageUrl` (Optional)
- **戻り値**: 作成されたPostオブジェクト

#### `getPosts(filter: PostFilter, page: number)`
- **説明**: 掲示板の投稿一覧を取得する（無限スクロール対応）。
- **引数**:
  - `schoolId` or `regionId`
  - `page` (ページネーション)
- **戻り値**: Postオブジェクトの配列（Author情報含む）

#### `toggleLike(postId: string)`
- **説明**: 投稿へのいいねをトグルする。
- **戻り値**: 現在のいいね数, 状態

#### `addComment(postId: string, content: string)`
- **説明**: 投稿にコメントを追加する。
- **戻り値**: 作成されたCommentオブジェクト

## 3. 外部連携・Webhook

### 3.1 Clerk Webhook
- **Endpoint**: `/api/webhooks/clerk`
- **Method**: `POST`
- **説明**: Clerkでユーザーが作成・更新・削除された際に、Supabaseの`profiles`テーブルを同期する。
- **Events**:
  - `user.created` -> `INSERT INTO profiles`
  - `user.updated` -> `UPDATE profiles`
  - `user.deleted` -> `DELETE FROM profiles`

## 4. エラーハンドリング
- Server Actionsは `Result<T, E>` 型のようなラッパーを返し、成功・失敗をクライアントで判別できるようにする。
- 認証エラー、バリデーションエラーは適切なメッセージを返す。
