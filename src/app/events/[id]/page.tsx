import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect, notFound } from 'next/navigation';
import Link from 'next/link';
import { EventDetailClient } from './EventDetailClient';

export default async function EventDetailPage({ params }: { params: Promise<{ id: string }> }) {
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

  const { data: event } = await supabase
    .from('events')
    .select(`
      id,
      title,
      description,
      event_date,
      event_time,
      location,
      max_participants,
      organizer_id,
      created_at,
      schools (id, name, type),
      profiles!organizer_id (id, display_name, clerk_user_id, avatar_url)
    `)
    .eq('id', id)
    .single();

  if (!event) notFound();

  const { data: attendances } = await supabase
    .from('event_attendances')
    .select(`
      profiles (id, display_name, clerk_user_id, avatar_url)
    `)
    .eq('event_id', id);

  const { data: myAttendance } = await supabase
    .from('event_attendances')
    .select('id')
    .eq('event_id', id)
    .eq('profile_id', profile.id)
    .single();

  const participants = (attendances ?? []).map((a: any) => a.profiles).filter(Boolean);
  const isOrganizer = event.organizer_id === profile.id;
  const isAttending = !!myAttendance;

  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800">
      <header className="sticky top-0 z-50 bg-white/90 backdrop-blur border-b border-stone-200/60 shadow-lg shadow-stone-200/20 h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-gradient-to-br from-orange-500 to-orange-600 text-white p-2 rounded-xl font-bold text-xl shadow-lg shadow-orange-200/40">JC</Link>
          <span className="font-bold text-lg text-stone-700 truncate max-w-[200px]">{event.title}</span>
        </div>
        <Link href="/events" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors">
          ← イベント一覧
        </Link>
      </header>

      <div className="max-w-2xl mx-auto p-6">
        <EventDetailClient
          event={event}
          participants={participants}
          isOrganizer={isOrganizer}
          isAttending={isAttending}
        />
      </div>
    </div>
  );
}
