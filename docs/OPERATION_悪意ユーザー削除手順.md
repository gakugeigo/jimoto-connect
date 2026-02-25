# 悪意あるユーザー（Aさん）の削除手順

複数メールで複数アカウントを作り、いろんな学校に不正登録しているユーザーを完全に排除する方法です。

---

## 重要な前提

| システム | 役割 |
|----------|------|
| **Clerk** | ログイン認証。メールアドレスごとに別アカウント（別 `clerk_user_id`） |
| **Supabase** | プロフィール・投稿・所属などすべてのデータ |

**両方で対応しないと完全には排除できません。**

- Supabase の profile だけ削除 → その Clerk アカウントで再ログインすると、オンボーディングからやり直せてしまう
- Clerk だけ削除 → Supabase にプロフィール・投稿が残る（表示上は「削除済みユーザー」になる）

---

## 削除手順（1アカウントあたり）

### Step 1: 対象ユーザーを特定する

**方法A: 表示名で検索**

Supabase SQL Editor で実行:

```sql
-- 表示名で検索（Aさんの名前がわかっている場合）
SELECT id, display_name, clerk_user_id, email, created_at
FROM profiles
WHERE display_name ILIKE '%検索したい名前%';
```

**方法B: 学校ごとに投稿者を確認**

```sql
-- 特定の学校の投稿者一覧
SELECT p.id, p.display_name, p.clerk_user_id, COUNT(*) as post_count
FROM profiles p
JOIN posts pst ON pst.author_id = p.id
WHERE pst.school_id = '対象の学校のUUID'
GROUP BY p.id, p.display_name, p.clerk_user_id;
```

**方法C: メールアドレスで検索**（profiles に email があれば）

```sql
SELECT id, display_name, clerk_user_id, email
FROM profiles
WHERE email ILIKE '%@example.com%';
```

---

### Step 2: Supabase で profile を削除

**削除すると連鎖して消えるもの（on delete cascade）:**

- profile_schools（所属学校）
- posts（投稿）
- likes（いいね）
- comments（コメント）
- event_attendances（イベント参加）
- direct_messages（DM）
- group_members（グループ参加）

**SQL で実行:**

```sql
-- 対象の profile_id を指定して削除
DELETE FROM public.profiles
WHERE id = '対象のprofileのUUID';

-- または clerk_user_id で削除
DELETE FROM public.profiles
WHERE clerk_user_id = 'user_2Nxxxxxxxxxxxxxxxx';
```

---

### Step 3: Clerk でアカウントを無効化

**Clerk Dashboard で操作:**

1. [Clerk Dashboard](https://dashboard.clerk.com) にログイン
2. **Users** を開く
3. 対象ユーザーを検索（`clerk_user_id` の `user_2N...` の部分や、メールアドレスで検索）
4. ユーザーを選択 → **Delete user** または **Ban user**

| 操作 | 効果 |
|------|------|
| **Ban user** | ログイン不可。アカウントは残る。後で解除可能 |
| **Delete user** | アカウントを完全削除。復元不可 |

**推奨:** 悪意あるユーザーは **Delete user** で完全削除するのが安全です。

---

## 複数アカウント（同一人物）の場合

Aさんが複数メールで複数アカウントを作っている場合:

1. **表示名が同じ** → 表示名で検索して該当 profile を洗い出す
2. **各アカウントごとに** 上記 Step 1〜3 を繰り返す
3. **Clerk の user_id** はメールごとに異なるため、1アカウントずつ削除する必要がある

**同一人物の複数アカウントをまとめて特定する方法:**

- 現状、IP アドレスやデバイス情報は保存していない
- 表示名・投稿内容・投稿時間などから手動で判断する必要がある
- 将来的には「通報」機能で「このユーザー」を指定できるようにする運用が考えられる

---

## チェックリスト

- [ ] 対象ユーザーを特定（profile_id または clerk_user_id をメモ）
- [ ] Supabase で `DELETE FROM profiles WHERE ...` を実行
- [ ] Clerk Dashboard で該当ユーザーを Delete（または Ban）
- [ ] 複数アカウントの場合は、同じ手順を他のアカウントにも実施

---

## 運営方針（2025年2月21日決定）

**複数からの報告があった場合、その人を削除することを検討する**

- 複数 = 異なる報告者から2件以上
- 詳細は `OPERATION_運営方針ログ.md` を参照

---

## 今後の検討事項

- **通報機能**: 投稿・プロフィールに「通報」ボタンを実装（「このユーザーはこの学校の出身ではない」等を報告）
- **管理画面**: 運営者が profile 一覧・検索・削除できる UI
- **Clerk Webhook**: ユーザー削除時に Supabase の profile も自動削除
- **メール認証の強化**: 同一メールの複数アカウントを制限する運用
