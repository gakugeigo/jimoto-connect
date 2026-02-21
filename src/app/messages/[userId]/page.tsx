import { auth } from '@clerk/nextjs/server';
import { redirect, notFound } from 'next/navigation';
import Link from 'next/link';
import { getConversationWithUser } from '@/app/actions/message';
import { MessageThreadClient } from './MessageThreadClient';

export default async function ConversationPage({
  params,
}: {
  params: Promise<{ userId: string }>;
}) {
  const { userId } = await auth();
  if (!userId) redirect('/sign-in');

  const { userId: otherUserId } = await params;
  const { messages, otherUser } = await getConversationWithUser(otherUserId);

  if (!otherUser) notFound();

  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800 flex flex-col">
      <header className="sticky top-0 z-50 bg-white/90 backdrop-blur border-b border-stone-200/60 shadow-lg shadow-stone-200/20 h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/messages" className="text-stone-600 hover:text-orange-600">
            ←
          </Link>
          <span className="font-bold text-lg text-stone-700">{otherUser.display_name}</span>
        </div>
        <Link href="/messages" className="text-sm font-semibold text-stone-600 hover:text-orange-600">
          メッセージ一覧
        </Link>
      </header>

      <div className="max-w-2xl mx-auto w-full flex-1 flex flex-col">
        <MessageThreadClient
          initialMessages={messages}
          otherUser={otherUser}
          otherUserId={otherUserId}
        />
      </div>
    </div>
  );
}
