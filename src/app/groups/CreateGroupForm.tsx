'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { createGroup } from '@/app/actions/group';

export function CreateGroupForm() {
  const router = useRouter();
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!name.trim() || isSubmitting) return;

    setIsSubmitting(true);
    try {
      const result = await createGroup(name, description);
      if (result?.groupId) {
        router.push(`/groups/${result.groupId}`);
      }
    } catch (err) {
      alert(err instanceof Error ? err.message : '作成に失敗しました');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <h2 className="font-bold text-stone-700">新規グループ作成</h2>
      <div>
        <label className="block text-sm font-bold text-stone-700 mb-2">グループ名</label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="例: 高校の仲良し5人"
          className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none"
          required
        />
      </div>
      <div>
        <label className="block text-sm font-bold text-stone-700 mb-2">説明（任意）</label>
        <input
          type="text"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          placeholder="例: クラスメートの連絡用"
          className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none"
        />
      </div>
      <button
        type="submit"
        disabled={!name.trim() || isSubmitting}
        className="w-full py-3 bg-orange-600 text-white font-bold rounded-xl hover:bg-orange-700 disabled:opacity-50 transition"
      >
        {isSubmitting ? '作成中...' : 'グループを作成'}
      </button>
    </form>
  );
}
