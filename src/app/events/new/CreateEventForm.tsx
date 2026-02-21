'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { createEvent } from '@/app/actions/event';
import { ErrorMessage } from '@/components/ui/ErrorMessage';

export function CreateEventForm({ schools }: { schools: any[] }) {
  const router = useRouter();
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [eventDate, setEventDate] = useState('');
  const [eventTime, setEventTime] = useState('');
  const [location, setLocation] = useState('');
  const [schoolId, setSchoolId] = useState('');
  const [maxParticipants, setMaxParticipants] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!title.trim() || !eventDate || isSubmitting) return;

    setError(null);
    setIsSubmitting(true);
    try {
      const result = await createEvent({
        title,
        description: description || undefined,
        eventDate,
        eventTime: eventTime || undefined,
        location: location || undefined,
        schoolId: schoolId || undefined,
        maxParticipants: maxParticipants ? parseInt(maxParticipants, 10) : undefined,
      });
      if (result?.eventId) {
        router.push(`/events/${result.eventId}`);
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : '作成に失敗しました');
    } finally {
      setIsSubmitting(false);
    }
  };

  const today = new Date().toISOString().slice(0, 10);

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <h2 className="font-bold text-stone-700">新規イベント作成</h2>
      {error && (
        <ErrorMessage message={error} onDismiss={() => setError(null)} />
      )}
      <div>
        <label className="block text-sm font-bold text-stone-700 mb-2">タイトル *</label>
        <input
          type="text"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="例: 〇〇高校 10期生 同窓会"
          className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none"
          required
        />
      </div>

      <div>
        <label className="block text-sm font-bold text-stone-700 mb-2">説明（任意）</label>
        <textarea
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          placeholder="イベントの詳細を入力"
          className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none resize-none"
          rows={3}
        />
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-bold text-stone-700 mb-2">日付 *</label>
          <input
            type="date"
            value={eventDate}
            onChange={(e) => setEventDate(e.target.value)}
            min={today}
            className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none"
            required
          />
        </div>
        <div>
          <label className="block text-sm font-bold text-stone-700 mb-2">時間（任意）</label>
          <input
            type="time"
            value={eventTime}
            onChange={(e) => setEventTime(e.target.value)}
            className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none"
          />
        </div>
      </div>

      <div>
        <label className="block text-sm font-bold text-stone-700 mb-2">場所（任意）</label>
        <input
          type="text"
          value={location}
          onChange={(e) => setLocation(e.target.value)}
          placeholder="例: 渋谷 〇〇居酒屋"
          className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none"
        />
      </div>

      {schools.length > 0 && (
        <div>
          <label className="block text-sm font-bold text-stone-700 mb-2">関連する学校（任意）</label>
          <select
            value={schoolId}
            onChange={(e) => setSchoolId(e.target.value)}
            className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none"
          >
            <option value="">選択しない</option>
            {schools.map((s: any) => (
              <option key={s.id} value={s.id}>
                {s.type === 'high' ? '🏫' : '📚'} {s.name}
              </option>
            ))}
          </select>
        </div>
      )}

      <div>
        <label className="block text-sm font-bold text-stone-700 mb-2">定員（任意）</label>
        <input
          type="number"
          value={maxParticipants}
          onChange={(e) => setMaxParticipants(e.target.value)}
          placeholder="例: 20"
          min={1}
          className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none"
        />
      </div>

      <button
        type="submit"
        disabled={!title.trim() || !eventDate || isSubmitting}
        className="w-full py-3.5 bg-gradient-to-r from-orange-500 to-orange-600 text-white font-bold rounded-xl hover:from-orange-600 hover:to-orange-700 disabled:opacity-50 transition shadow-lg shadow-orange-200/40"
      >
        {isSubmitting ? '作成中...' : 'イベントを作成'}
      </button>
    </form>
  );
}
