import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import Link from 'next/link';
import { CreateGroupForm } from './CreateGroupForm';

export default async function GroupsPage() {
  const { userId } = await auth();
  if (!userId) redirect('/sign-in');

  const supabase = await createClient();

  const { data: profile } = await supabase
    .from('profiles')
    .select('id')
    .eq('clerk_user_id', userId)
    .single();

  if (!profile) redirect('/onboarding');

  const { data: memberships } = await supabase
    .from('group_members')
    .select(`
      group_id,
      role,
      groups (
        id,
        name,
        description,
        invite_token,
        created_by
      )
    `)
    .eq('profile_id', profile.id);

  const groups = (memberships ?? []).map((m: any) => ({ ...m.groups, role: m.role })).filter((g: any) => g.id);

  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800">
      <header className="sticky top-0 z-50 bg-white/90 backdrop-blur border-b border-stone-200/60 shadow-lg shadow-stone-200/20 h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-gradient-to-br from-orange-500 to-orange-600 text-white p-2 rounded-xl font-bold text-xl shadow-lg shadow-orange-200/40">JC</Link>
          <span className="font-bold text-lg text-stone-700">マイグループ</span>
        </div>
        <Link href="/dashboard" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors">
          ダッシュボードに戻る
        </Link>
      </header>

      <div className="max-w-2xl mx-auto p-6">
        <div className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 overflow-hidden">
          <div className="p-6 border-b border-stone-100">
            <h1 className="text-xl font-bold text-stone-800 mb-2">マイグループ</h1>
            <p className="text-sm text-stone-500">
              部活以外の仲間とつながるグループを作れます。招待リンクで友達を追加しましょう。
            </p>
          </div>

          <div className="p-6">
            <CreateGroupForm />

            <div className="mt-8">
              <h2 className="font-bold text-stone-700 mb-4">参加中のグループ</h2>
              {groups.length === 0 ? (
                <p className="text-stone-500 text-sm">まだグループに参加していません。上で新規作成するか、招待リンクから参加してください。</p>
              ) : (
                <div className="space-y-3">
                  {groups.map((g: any) => (
                    <Link
                      key={g.id}
                      href={`/groups/${g.id}`}
                      className="block p-4 bg-white/80 rounded-2xl hover:bg-orange-50/80 transition border border-stone-200/60 shadow-sm hover:shadow-md"
                    >
                      <p className="font-bold text-stone-800">{g.name}</p>
                      {g.description && <p className="text-sm text-stone-500 mt-1">{g.description}</p>}
                      <p className="text-xs text-stone-400 mt-2">{g.role === 'admin' ? '管理者' : 'メンバー'}</p>
                    </Link>
                  ))}
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
