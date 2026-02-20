import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import Link from 'next/link';
import { ProfileEditForm } from './ProfileEditForm';
import { HometownVisitButton } from './HometownVisitButton';

export default async function ProfilePage() {
  const { userId } = await auth();
  if (!userId) {
    redirect('/sign-in');
  }

  const supabase = await createClient();

  const { data: profile, error } = await supabase
    .from('profiles')
    .select('*')
    .eq('clerk_user_id', userId)
    .single();

  if (error || !profile) {
    redirect('/onboarding');
  }

  return (
    <div className="min-h-screen bg-[#F5F5F0] text-[#333] font-sans">
      <header className="sticky top-0 z-50 bg-white border-b border-[#E0E0E0] shadow-sm h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-orange-600 text-white p-1.5 rounded-lg font-bold text-xl">JC</Link>
          <span className="font-bold text-lg text-stone-700">Jimoto-Connect</span>
        </div>
        <Link href="/dashboard" className="text-sm font-medium text-stone-600 hover:text-orange-600 transition-colors">
          ダッシュボードに戻る
        </Link>
      </header>

      <div className="max-w-2xl mx-auto p-6">
        <div className="bg-white rounded-2xl border border-[#E0E0E0] shadow-sm overflow-hidden">
          <div className="p-6 border-b border-[#E0E0E0]">
            <div className="flex items-center gap-4">
              <div className="w-16 h-16 rounded-full bg-stone-100 overflow-hidden border-2 border-white shadow-sm">
                <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${profile.display_name}`} alt="User" />
              </div>
              <div>
                <h1 className="text-xl font-bold text-stone-800">{profile.display_name}</h1>
                {profile.maiden_name && (
                  <p className="text-sm text-stone-500">(旧姓: {profile.maiden_name})</p>
                )}
                <p className="text-sm text-stone-500 mt-1">@{profile.clerk_user_id.slice(0, 8)}</p>
              </div>
            </div>
          </div>

          <div className="p-6 space-y-6">
            <div>
              <h2 className="font-bold text-stone-700 mb-3">今の状況</h2>
              <HometownVisitButton isHometownVisit={profile.is_hometown_visit ?? false} />
            </div>
            <div>
              <h2 className="font-bold text-stone-700 mb-4">プロフィール編集</h2>
              <ProfileEditForm
                maidenName={profile.maiden_name ?? ''}
                industry={profile.industry ?? ''}
                occupation={profile.occupation ?? ''}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
