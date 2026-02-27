# デモデイ提出物を GitHub にプッシュする手順

GitHub に「デモデイ提出物チェックリスト」のコミットが反映されていない場合、以下を実行してください。

---

## 手順

### 1. ターミナルを開く

Cursor で `Ctrl + `` を押す

### 2. プロジェクトフォルダに移動

```
cd c:\Users\hidey\projects\sns-app
```

### 3. 状態を確認

```
git status
```

- `docs/DEMO_DAY_提出物チェックリスト.md` が表示されていれば、未コミットの変更あり

### 4. 追加・コミット・プッシュ

```
git add docs/
git commit -m "docs: デモデイ提出物チェックリスト追加"
git push origin main
```

### 5. 確認

GitHub (https://github.com/gakugeigo/jimoto-connect) を開き、最新のコミットに「デモデイ提出物チェックリスト」が表示されていれば OK

---

## エラーが出た場合

| エラー | 対処 |
|--------|------|
| `nothing to commit` | すでにコミット済み。`git push origin main` だけ実行 |
| `rejected` | 先に `git pull origin main` を実行してから再度 `git push` |
| `Permission denied` | GitHub の認証（SSH または Personal Access Token）を確認 |
