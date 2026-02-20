'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { joinGroupByToken } from '@/app/actions/group';

export function JoinGroupButton({ token }: { token: string }) {
  const router = useRouter();
  const [isJoining, setIsJoining] = useState(false);

  const handleJoin = async () => {
    setIsJoining(true);
    try {
      const result = await joinGroupByToken(token);
      if (result?.groupId) {
        router.push(`/groups/${result.groupId}`);
      }
    } catch (err) {
      alert(err instanceof Error ? err.message : '参加に失敗しました');
    } finally {
      setIsJoining(false);
    }
  };

  return (
    <button
      onClick={handleJoin}
      disabled={isJoining}
      className="w-full py-3 bg-orange-600 text-white font-bold rounded-xl hover:bg-orange-700 disabled:opacity-50 transition"
    >
      {isJoining ? '参加中...' : '参加する'}
    </button>
  );
}
