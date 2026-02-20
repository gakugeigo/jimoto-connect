'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { createGroupPost } from '@/app/actions/group';
import { ErrorMessage } from '@/components/ui/ErrorMessage';

function formatRelativeTime(dateStr: string) {
  const d = new Date(dateStr);
  const now = new Date();
  const diffMs = now.getTime() - d.getTime();
  const diffM = Math.floor(diffMs / 60000);
  const diffH = Math.floor(diffMs / 3600000);
  const diffD = Math.floor(diffMs / 86400000);
  if (diffM < 1) return 'たった今';
  if (diffM < 60) return `${diffM}分前`;
  if (diffH < 24) return `${diffH}時間前`;
  if (diffD < 7) return `${diffD}日前`;
  return d.toLocaleDateString('ja-JP', { month: 'short', day: 'numeric' });
}

export function GroupDetailClient({ group, posts, members, isAdmin }: any) {
  const router = useRouter();
  const [content, setContent] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [showInvite, setShowInvite] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [copySuccess, setCopySuccess] = useState(false);

  const inviteUrl = typeof window !== 'undefined'
    ? `${window.location.origin}/groups/join/${group.invite_token}`
    : '';

  const handlePost = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!content.trim() || isSubmitting) return;

    setError(null);
    setIsSubmitting(true);
    try {
      await createGroupPost(group.id, content);
      setContent('');
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : '投稿に失敗しました');
    } finally {
      setIsSubmitting(false);
    }
  };

  const copyInviteLink = () => {
    navigator.clipboard.writeText(inviteUrl);
    setCopySuccess(true);
    setTimeout(() => setCopySuccess(false), 2000);
  };

  return (
    <div className="space-y-6">
      {error && (
        <ErrorMessage message={error} onDismiss={() => setError(null)} />
      )}
      {copySuccess && (
        <div className="px-4 py-3 rounded-xl bg-green-50 border border-green-200 text-green-800 text-sm">
          招待リンクをコピーしました
        </div>
      )}
      <div className="bg-white rounded-2xl border border-[#E0E0E0] shadow-sm overflow-hidden">
        <div className="p-6">
          <h1 className="text-xl font-bold text-stone-800">{group.name}</h1>
          {group.description && <p className="text-stone-500 text-sm mt-1">{group.description}</p>}

          {isAdmin && (
            <div className="mt-4">
              <button
                onClick={() => setShowInvite(!showInvite)}
                className="text-sm font-bold text-orange-600 hover:text-orange-700"
              >
                {showInvite ? '招待リンクを隠す' : '招待リンクを表示'}
              </button>
              {showInvite && (
                <div className="mt-2 p-3 bg-stone-50 rounded-lg">
                  <p className="text-xs text-stone-500 mb-2">このリンクを友達に送ると参加できます</p>
                  <div className="flex gap-2">
                    <input
                      type="text"
                      value={inviteUrl}
                      readOnly
                      className="flex-1 px-3 py-2 text-sm rounded border border-stone-200 bg-white"
                    />
                    <button
                      onClick={copyInviteLink}
                      className="px-4 py-2 bg-orange-600 text-white text-sm font-bold rounded-lg hover:bg-orange-700"
                    >
                      コピー
                    </button>
                  </div>
                </div>
              )}
            </div>
          )}

          <div className="mt-4 flex gap-2 flex-wrap">
            {members.map((m: any) => (
              <div key={m.profiles?.id} className="flex items-center gap-2 bg-stone-50 px-3 py-1.5 rounded-full">
                <div className="w-6 h-6 rounded-full bg-stone-200 overflow-hidden">
                  <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${m.profiles?.clerk_user_id ?? m.profiles?.id}`} alt="" />
                </div>
                <span className="text-sm font-bold text-stone-700">{m.profiles?.display_name ?? '?'}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="bg-white rounded-2xl border border-[#E0E0E0] shadow-sm overflow-hidden">
        <div className="p-6">
          <h2 className="font-bold text-stone-700 mb-4">グループの投稿</h2>

          <form onSubmit={handlePost} className="mb-6">
            <textarea
              value={content}
              onChange={(e) => setContent(e.target.value)}
              placeholder="メッセージを入力..."
              className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none resize-none"
              rows={3}
            />
            <button
              type="submit"
              disabled={!content.trim() || isSubmitting}
              className="mt-2 px-6 py-2 bg-orange-600 text-white font-bold rounded-xl hover:bg-orange-700 disabled:opacity-50 transition"
            >
              {isSubmitting ? '送信中...' : '投稿'}
            </button>
          </form>

          <div className="space-y-4">
            {posts.length === 0 ? (
              <p className="text-stone-500 text-sm">まだ投稿がありません。最初のメッセージを送ってみましょう！</p>
            ) : (
              posts.map((post: any) => {
                const author = post.profiles ?? {};
                return (
                  <div key={post.id} className="border-b border-stone-100 pb-4 last:border-0">
                    <div className="flex gap-3">
                      <div className="w-10 h-10 rounded-full bg-stone-200 overflow-hidden flex-shrink-0">
                        <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${author.clerk_user_id ?? post.id}`} alt="" />
                      </div>
                      <div>
                        <p className="font-bold text-stone-800">{author.display_name ?? '匿名'}</p>
                        <p className="text-xs text-stone-400">{formatRelativeTime(post.created_at)}</p>
                        <p className="text-stone-700 mt-1 whitespace-pre-wrap">{post.content}</p>
                      </div>
                    </div>
                  </div>
                );
              })
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
