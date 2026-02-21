import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import Link from 'next/link';
import { JoinGroupButton } from './JoinGroupButton';

export default async function JoinGroupPage({ params }: { params: Promise<{ token: string }> }) {
  const { token } = await params;
  const { userId } = await auth();

  if (!userId) {
    redirect('/sign-in');
  }

  return (
    <div className="min-h-screen bg-[#FDF8F5] flex items-center justify-center p-6">
      <div className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 p-8 max-w-md w-full text-center">
        <h1 className="text-xl font-bold text-stone-800 mb-2">グループに参加</h1>
        <p className="text-stone-500 text-sm mb-6">
          招待リンクからグループに参加します。
        </p>
        <JoinGroupButton token={token} />
        <Link href="/groups" className="block mt-4 text-sm text-stone-500 hover:text-orange-600">
          キャンセル
        </Link>
      </div>
    </div>
  );
}
