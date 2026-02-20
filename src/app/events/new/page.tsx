import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import Link from 'next/link';
import { CreateEventForm } from './CreateEventForm';

export default async function NewEventPage() {
  const { userId } = await auth();
  if (!userId) redirect('/sign-in');

  const supabase = await createClient();

  const { data: profile } = await supabase
    .from('profiles')
    .select(`
      id,
      profile_schools (
        school_id,
        graduation_year,
        schools (id, name, type)
      )
    `)
    .eq('clerk_user_id', userId)
    .single();

  if (!profile) redirect('/onboarding');

  const schools = (profile.profile_schools ?? []).map((ps: any) => ps.schools).filter(Boolean);

  return (
    <div className="min-h-screen bg-[#F5F5F0] text-[#333] font-sans">
      <header className="sticky top-0 z-50 bg-white border-b border-[#E0E0E0] shadow-sm h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-orange-600 text-white p-1.5 rounded-lg font-bold text-xl">JC</Link>
          <span className="font-bold text-lg text-stone-700">イベント作成</span>
        </div>
        <Link href="/events" className="text-sm font-medium text-stone-600 hover:text-orange-600 transition-colors">
          ← イベント一覧
        </Link>
      </header>

      <div className="max-w-2xl mx-auto p-6">
        <div className="bg-white rounded-2xl border border-[#E0E0E0] shadow-sm overflow-hidden">
          <div className="p-6">
            <CreateEventForm schools={schools} />
          </div>
        </div>
      </div>
    </div>
  );
}
