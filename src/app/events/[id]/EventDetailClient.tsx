'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { joinEvent, leaveEvent, deleteEvent } from '@/app/actions/event';
import { ErrorMessage } from '@/components/ui/ErrorMessage';

export function EventDetailClient({
  event,
  participants,
  isOrganizer,
  isAttending,
}: {
  event: any;
  participants: any[];
  isOrganizer: boolean;
  isAttending: boolean;
}) {
  const router = useRouter();
  const [isJoining, setIsJoining] = useState(false);
  const [isLeaving, setIsLeaving] = useState(false);
  const [isDeleting, setIsDeleting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const school = event.schools;
  const organizer = event.profiles ?? {};
  const participantCount = participants.length;
  const isFull =
    event.max_participants != null && participantCount >= event.max_participants;

  const handleJoin = async () => {
    if (isJoining || isAttending || isOrganizer || isFull) return;
    setError(null);
    setIsJoining(true);
    try {
      await joinEvent(event.id);
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : '参加に失敗しました');
    } finally {
      setIsJoining(false);
    }
  };

  const handleLeave = async () => {
    if (isLeaving || !isAttending || isOrganizer) return;
    if (!confirm('参加をキャンセルしますか？')) return;
    setError(null);
    setIsLeaving(true);
    try {
      await leaveEvent(event.id);
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'キャンセルに失敗しました');
    } finally {
      setIsLeaving(false);
    }
  };

  const handleDelete = async () => {
    if (!isOrganizer || isDeleting) return;
    if (!confirm('このイベントを削除しますか？参加者全員に影響します。')) return;
    setError(null);
    setIsDeleting(true);
    try {
      await deleteEvent(event.id);
      router.push('/events');
    } catch (err) {
      setError(err instanceof Error ? err.message : '削除に失敗しました');
    } finally {
      setIsDeleting(false);
    }
  };

  return (
    <div className="space-y-6">
      {error && (
        <ErrorMessage message={error} onDismiss={() => setError(null)} />
      )}
      <div className="bg-white rounded-2xl border border-[#E0E0E0] shadow-sm overflow-hidden">
        <div className="p-6">
          <h1 className="text-xl font-bold text-stone-800">{event.title}</h1>

          {event.description && (
            <p className="text-stone-600 mt-2 whitespace-pre-wrap">{event.description}</p>
          )}

          <div className="mt-4 space-y-2 text-sm">
            <div className="flex items-center gap-2">
              <span className="text-stone-400">📅</span>
              <span>
                {new Date(event.event_date).toLocaleDateString('ja-JP', {
                  year: 'numeric',
                  month: 'long',
                  day: 'numeric',
                  weekday: 'long',
                })}
                {event.event_time && ` ${event.event_time}`}
              </span>
            </div>
            {event.location && (
              <div className="flex items-center gap-2">
                <span className="text-stone-400">📍</span>
                <span>{event.location}</span>
              </div>
            )}
            {school && (
              <div className="flex items-center gap-2">
                <span className="text-stone-400">{school.type === 'high' ? '🏫' : '📚'}</span>
                <Link
                  href={`/search?school=${school.id}`}
                  className="text-orange-600 hover:underline font-medium"
                >
                  {school.name}
                </Link>
              </div>
            )}
            <div className="flex items-center gap-2">
              <span className="text-stone-400">主催</span>
              <Link
                href={`/users/${organizer.id}`}
                className="text-orange-600 hover:underline font-medium"
              >
                {organizer.display_name ?? '?'}
              </Link>
            </div>
          </div>

          {/* 参加ボタン */}
          {!isOrganizer && (
            <div className="mt-6">
              {isAttending ? (
                <button
                  onClick={handleLeave}
                  disabled={isLeaving}
                  className="px-6 py-3 border border-stone-300 text-stone-600 font-bold rounded-xl hover:bg-stone-50 disabled:opacity-50 transition"
                >
                  {isLeaving ? 'キャンセル中...' : '参加をキャンセル'}
                </button>
              ) : (
                <button
                  onClick={handleJoin}
                  disabled={isJoining || isFull}
                  className="px-6 py-3 bg-orange-600 text-white font-bold rounded-xl hover:bg-orange-700 disabled:opacity-50 transition"
                >
                  {isJoining ? '参加中...' : isFull ? '定員に達しています' : '参加する'}
                </button>
              )}
            </div>
          )}

          {isOrganizer && (
            <div className="mt-6">
              <button
                onClick={handleDelete}
                disabled={isDeleting}
                className="px-6 py-2 text-red-600 border border-red-200 font-bold rounded-xl hover:bg-red-50 disabled:opacity-50 transition"
              >
                {isDeleting ? '削除中...' : 'イベントを削除'}
              </button>
            </div>
          )}
        </div>
      </div>

      {/* 参加者一覧 */}
      <div className="bg-white rounded-2xl border border-[#E0E0E0] shadow-sm overflow-hidden">
        <div className="p-6">
          <h2 className="font-bold text-stone-700 mb-4">
            参加者
            {event.max_participants != null && (
              <span className="text-stone-500 font-normal ml-2">
                ({participantCount} / {event.max_participants}人)
              </span>
            )}
          </h2>

          {participants.length === 0 ? (
            <p className="text-stone-500 text-sm">まだ参加者はいません。</p>
          ) : (
            <div className="flex flex-wrap gap-2">
              {participants.map((p: any) => (
                <Link
                  key={p.id}
                  href={`/users/${p.id}`}
                  className="flex items-center gap-2 bg-stone-50 px-3 py-2 rounded-full hover:bg-orange-50 transition"
                >
                  <div className="w-8 h-8 rounded-full bg-stone-200 overflow-hidden">
                    <img
                      src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${p.clerk_user_id ?? p.id}`}
                      alt=""
                    />
                  </div>
                  <span className="text-sm font-bold text-stone-700">{p.display_name ?? '?'}</span>
                </Link>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
