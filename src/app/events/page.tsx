import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import Link from 'next/link';

export default async function EventsPage() {
  const { userId } = await auth();
  if (!userId) redirect('/sign-in');

  const supabase = await createClient();

  const { data: profile } = await supabase
    .from('profiles')
    .select('id')
    .eq('clerk_user_id', userId)
    .single();

  if (!profile) redirect('/onboarding');

  const { data: events } = await supabase
    .from('events')
    .select(`
      id,
      title,
      description,
      event_date,
      event_time,
      location,
      max_participants,
      created_at,
      schools (id, name, type),
      profiles!organizer_id (id, display_name, clerk_user_id, avatar_url)
    `)
    .gte('event_date', new Date().toISOString().slice(0, 10))
    .order('event_date', { ascending: true })
    .order('event_time', { ascending: true })
    .limit(50);

  const { data: myAttendances } = await supabase
    .from('event_attendances')
    .select('event_id')
    .eq('profile_id', profile.id);

  const attendingIds = new Set((myAttendances ?? []).map((a: { event_id: string }) => a.event_id));

  return (
    <div className="min-h-screen bg-[#FDF8F5] text-stone-800">
      <header className="sticky top-0 z-50 bg-white/90 backdrop-blur border-b border-stone-200/60 shadow-lg shadow-stone-200/20 h-16 flex items-center justify-between px-6">
        <div className="flex items-center gap-2">
          <Link href="/dashboard" className="bg-gradient-to-br from-orange-500 to-orange-600 text-white p-2 rounded-xl font-bold text-xl shadow-lg shadow-orange-200/40">JC</Link>
          <span className="font-bold text-lg text-stone-700">同窓会イベント</span>
        </div>
        <div className="flex items-center gap-4">
          <Link
            href="/events/new"
            className="px-4 py-2.5 bg-gradient-to-r from-orange-500 to-orange-600 text-white text-sm font-bold rounded-xl hover:from-orange-600 hover:to-orange-700 transition shadow-lg shadow-orange-200/40"
          >
            イベントを作成
          </Link>
          <Link href="/dashboard" className="text-sm font-semibold text-stone-600 hover:text-orange-600 transition-colors">
            ダッシュボードに戻る
          </Link>
        </div>
      </header>

      <div className="max-w-2xl mx-auto p-6">
        <div className="bg-white/90 backdrop-blur rounded-2xl border border-stone-200/60 shadow-xl shadow-stone-200/40 overflow-hidden">
          <div className="p-6 border-b border-stone-100">
            <h1 className="text-xl font-bold text-stone-800 mb-2">同窓会イベント</h1>
            <p className="text-sm text-stone-500">
              学校や地域の仲間とオフラインで会えるイベントを探したり、自分で企画したりできます。
            </p>
          </div>

          <div className="divide-y divide-stone-100">
            {(events ?? []).length === 0 ? (
              <div className="p-8 text-center">
                <p className="text-stone-500 mb-4">開催予定のイベントはまだありません。</p>
                <Link
                  href="/events/new"
                  className="inline-block px-6 py-3 bg-gradient-to-r from-orange-500 to-orange-600 text-white font-bold rounded-xl hover:from-orange-600 hover:to-orange-700 transition shadow-lg shadow-orange-200/40"
                >
                  最初のイベントを作成
                </Link>
              </div>
            ) : (
              (events ?? []).map((event: any) => {
                const school = event.schools;
                const organizer = event.profiles ?? {};
                const isAttending = attendingIds.has(event.id);
                return (
                  <Link
                    key={event.id}
                    href={`/events/${event.id}`}
                    className="block p-6 hover:bg-orange-50/50 transition"
                  >
                    <div className="flex justify-between items-start gap-4">
                      <div>
                        <h2 className="font-bold text-stone-800">{event.title}</h2>
                        {event.description && (
                          <p className="text-sm text-stone-500 mt-1 line-clamp-2">{event.description}</p>
                        )}
                        <div className="flex flex-wrap gap-2 mt-2 text-xs text-stone-500">
                          <span>
                            📅 {new Date(event.event_date).toLocaleDateString('ja-JP', {
                              month: 'long',
                              day: 'numeric',
                              weekday: 'short',
                            })}
                            {event.event_time && ` ${event.event_time}`}
                          </span>
                          {event.location && <span>📍 {event.location}</span>}
                          {school && (
                            <span className="bg-stone-100 px-2 py-0.5 rounded">
                              {school.type === 'high' ? '🏫' : '📚'} {school.name}
                            </span>
                          )}
                        </div>
                        <p className="text-xs text-stone-400 mt-2">
                          主催: {organizer.display_name ?? '?'}
                        </p>
                      </div>
                      {isAttending && (
                        <span className="flex-shrink-0 px-3 py-1 bg-green-100 text-green-700 text-xs font-bold rounded-full">
                          参加予定
                        </span>
                      )}
                    </div>
                  </Link>
                );
              })
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
