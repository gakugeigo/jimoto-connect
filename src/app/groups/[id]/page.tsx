import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect, notFound } from 'next/navigation';
import Link from 'next/link';
import { GroupDetailClient } from './GroupDetailClient';

export default async function GroupDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const { userId } = await auth();
  if (!userId) redirect('/sign-in');

  const supabase = await createClient();

  const { data: profile } = await supabase
    .from('profiles')
    .select('id')
    .eq('clerk_user_id', userId)
    .single();

  if (!profile) redirect('/onboarding');

  const { data: group } = await supabase
    .from('groups')
    .select('id, name, description, invite_token, created_by')
    .eq('id', id)
    .single();

  if (!group) notFound();

  const { data: membership } = await supabase
    .from('group_members')
    .select('role')
    .eq('group_id', id)
    .eq('profile_id', profile.id)
    .single();

  if (!membership) redirect('/groups');

  const { data: members } = await supabase
    .from('group_members')
    .select(`
      profiles (id, display_name, clerk_user_id, avatar_url)
    `)
    .eq('group_id', id);

  const { data: posts } = await supabase
    .from('posts')
    .select(`
      id,
      content,
      image_url,
      created_at,
      profiles!author_id (id, display_name, clerk_user_id, avatar_url)
    `)
    .eq('group_id', id)
    .order('created_at', { ascending: false })
    .limit(50);

  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800">
      <header className="sticky top-0 z-50 bg-white/90 backdrop-blur border-b border-stone-200/60 shadow-lg shadow-stone-200/20 h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/groups" className="bg-gradient-to-br from-orange-500 to-orange-600 text-white p-2 rounded-xl font-bold text-xl shadow-lg shadow-orange-200/40">JC</Link>
          <span className="font-bold text-lg text-stone-700 truncate max-w-[200px]">{group.name}</span>
        </div>
        <Link href="/groups" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors">
          ← グループ一覧
        </Link>
      </header>

      <div className="max-w-2xl mx-auto p-6">
        <GroupDetailClient
          group={group}
          posts={posts ?? []}
          members={members ?? []}
          isAdmin={membership.role === 'admin'}
        />
      </div>
    </div>
  );
}
