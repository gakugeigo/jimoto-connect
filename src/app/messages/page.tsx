import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import Link from 'next/link';
import { getConversations } from '@/app/actions/message';
import { getAvatarUrl } from '@/lib/avatar';

export default async function MessagesPage() {
  const { userId } = await auth();
  if (!userId) redirect('/sign-in');

  const conversations = await getConversations();

  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800">
      <header className="sticky top-0 z-40 bg-white/90 backdrop-blur border-b border-stone-200/60 shadow-lg shadow-stone-200/20 min-h-[52px] flex items-center justify-between px-4 sm:px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-gradient-to-br from-orange-500 to-orange-600 text-white p-2 rounded-xl font-bold text-xl shadow-lg shadow-orange-200/40 min-h-[44px] min-w-[44px] flex items-center justify-center">
            JC
          </Link>
          <span className="font-bold text-base sm:text-lg text-stone-700">メッセージ</span>
        </div>
        <Link href="/search" className="hidden lg:block text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors py-2">
          検索
        </Link>
      </header>

      <div className="max-w-2xl mx-auto p-4 sm:p-6">
        <div className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 overflow-hidden">
          <div className="p-6 border-b border-stone-100">
            <h1 className="text-xl font-bold text-stone-800 mb-2">メッセージ</h1>
            <p className="text-sm text-stone-500">
              同窓生と個別にメッセージのやり取りができます。
            </p>
          </div>

          <div className="divide-y divide-stone-200/60">
            {conversations.length === 0 ? (
              <div className="p-8 text-center text-stone-500">
                <p className="mb-2">まだメッセージはありません</p>
                <p className="text-sm">
                  <Link href="/search" className="text-orange-600 hover:underline font-semibold">
                    同窓生検索
                  </Link>
                  から相手のプロフィールを開き、「メッセージを送る」から会話を始めましょう
                </p>
              </div>
            ) : (
              conversations.map((c) => (
                <Link
                  key={c.id}
                  href={`/messages/${c.id}`}
                  className="flex items-center gap-4 p-4 hover:bg-stone-50/80 transition"
                >
                  <div className="w-12 h-12 rounded-full bg-stone-200 overflow-hidden flex-shrink-0">
                    <img src={getAvatarUrl(c)} alt="" className="w-full h-full object-cover" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="font-bold text-stone-800">{c.display_name}</p>
                    {c.lastMessage && (
                      <p className="text-sm text-stone-500 truncate">
                        {c.lastMessage.content}
                      </p>
                    )}
                  </div>
                </Link>
              ))
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
