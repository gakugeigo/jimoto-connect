'use client';

import { useState, useRef, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { sendMessage } from '@/app/actions/message';
import { getAvatarUrl } from '@/lib/avatar';

type Message = {
  id: string;
  sender_id: string;
  receiver_id: string;
  content: string;
  created_at: string;
};

type OtherUser = {
  id: string;
  display_name: string;
  avatar_url: string | null;
};

export function MessageThreadClient({
  initialMessages,
  otherUser,
  otherUserId,
}: {
  initialMessages: Message[];
  otherUser: OtherUser;
  otherUserId: string;
}) {
  const [messages, setMessages] = useState(initialMessages);
  const [input, setInput] = useState('');
  const [sending, setSending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const scrollRef = useRef<HTMLDivElement>(null);
  const router = useRouter();

  useEffect(() => {
    setMessages(initialMessages);
  }, [initialMessages]);

  useEffect(() => {
    scrollRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  const handleSend = async () => {
    const trimmed = input.trim();
    if (!trimmed || sending) return;

    setSending(true);
    setError(null);
    setInput('');

    try {
      await sendMessage(otherUserId, trimmed);
      router.refresh();
    } catch (e) {
      setError(e instanceof Error ? e.message : '送信に失敗しました');
      setInput(trimmed);
    } finally {
      setSending(false);
    }
  };

  return (
    <div className="flex-1 flex flex-col bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 m-4 overflow-hidden">
      <div className="flex-1 overflow-y-auto p-4 space-y-4 min-h-[200px]">
        {messages.length === 0 ? (
          <p className="text-center text-stone-500 text-sm py-8">
            まだメッセージはありません。メッセージを送って会話を始めましょう。
          </p>
        ) : (
          messages.map((m) => {
            const fromMe = m.sender_id !== otherUserId;
            return (
              <div
                key={m.id}
                className={`flex gap-3 ${fromMe ? 'flex-row-reverse' : ''}`}
              >
                {!fromMe && (
                  <div className="w-8 h-8 rounded-full bg-stone-200 overflow-hidden flex-shrink-0">
                    <img src={getAvatarUrl(otherUser)} alt="" className="w-full h-full object-cover" />
                  </div>
                )}
                <div
                  className={`max-w-[75%] px-4 py-2 rounded-2xl ${
                    fromMe
                      ? 'bg-orange-500 text-white rounded-br-sm'
                      : 'bg-stone-100 text-stone-800 rounded-bl-sm'
                  }`}
                >
                  <p className="text-sm whitespace-pre-wrap break-words">{m.content}</p>
                  <p className={`text-xs mt-1 ${fromMe ? 'text-orange-100' : 'text-stone-400'}`}>
                    {new Date(m.created_at).toLocaleString('ja-JP', {
                      month: 'numeric',
                      day: 'numeric',
                      hour: '2-digit',
                      minute: '2-digit',
                    })}
                  </p>
                </div>
              </div>
            );
          })
        )}
        <div ref={scrollRef} />
      </div>

      {error && (
        <p className="px-4 py-2 text-sm text-red-600 bg-red-50">{error}</p>
      )}

      <div className="p-4 border-t border-stone-200/60">
        <form
          onSubmit={(e) => {
            e.preventDefault();
            handleSend();
          }}
          className="flex gap-2"
        >
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            placeholder="メッセージを入力..."
            className="flex-1 px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none"
            disabled={sending}
          />
          <button
            type="submit"
            disabled={sending || !input.trim()}
            className="px-6 py-3 bg-orange-500 text-white font-bold rounded-xl hover:bg-orange-600 disabled:opacity-50 disabled:cursor-not-allowed transition"
          >
            {sending ? '送信中...' : '送信'}
          </button>
        </form>
      </div>
    </div>
  );
}
