'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { joinGroupByToken } from '@/app/actions/group';
import { ErrorMessage } from '@/components/ui/ErrorMessage';

export function JoinGroupButton({ token }: { token: string }) {
  const router = useRouter();
  const [isJoining, setIsJoining] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleJoin = async () => {
    setError(null);
    setIsJoining(true);
    try {
      const result = await joinGroupByToken(token);
      if (result?.groupId) {
        router.push(`/groups/${result.groupId}`);
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : '参加に失敗しました');
    } finally {
      setIsJoining(false);
    }
  };

  return (
    <div className="space-y-3">
      {error && (
        <ErrorMessage message={error} onDismiss={() => setError(null)} />
      )}
      <button
        onClick={handleJoin}
        disabled={isJoining}
        className="w-full py-3 bg-orange-600 text-white font-bold rounded-xl hover:bg-orange-700 disabled:opacity-50 transition"
      >
        {isJoining ? '参加中...' : '参加する'}
      </button>
    </div>
  );
}
