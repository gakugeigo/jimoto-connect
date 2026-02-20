'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { toggleHometownVisit } from '@/app/actions/profile';

export function HometownVisitButton({ isHometownVisit }: { isHometownVisit: boolean }) {
  const router = useRouter();
  const [isToggling, setIsToggling] = useState(false);

  return (
    <div className={`rounded-xl overflow-hidden ${isHometownVisit ? 'bg-green-50 ring-1 ring-green-200' : 'bg-stone-50'}`}>
      {isHometownVisit ? (
        <>
          <div className="px-3 py-2 text-center text-sm font-bold text-green-700 bg-green-100">
            🏠 帰省中！
          </div>
          <button
            onClick={async () => {
              if (isToggling) return;
              setIsToggling(true);
              try {
                await toggleHometownVisit();
                router.refresh();
              } catch (e) {
                alert(e instanceof Error ? e.message : '更新に失敗しました');
              } finally {
                setIsToggling(false);
              }
            }}
            disabled={isToggling}
            className="w-full px-3 py-2 text-sm font-bold text-stone-600 hover:bg-stone-100 transition border-t border-green-200"
          >
            帰省が終わりました → クリックして解除
          </button>
        </>
      ) : (
        <button
          onClick={async () => {
            if (isToggling) return;
            setIsToggling(true);
            try {
              await toggleHometownVisit();
              router.refresh();
            } catch (e) {
              alert(e instanceof Error ? e.message : '更新に失敗しました');
            } finally {
              setIsToggling(false);
            }
          }}
          disabled={isToggling}
          className="w-full flex flex-col items-center gap-0.5 py-3 px-3 text-sm font-bold text-stone-700 hover:bg-stone-100 transition"
        >
          <span className="text-xs font-normal text-stone-500">帰省中の人はこちらをクリック</span>
          <span>🏠 今地元に帰省中</span>
        </button>
      )}
    </div>
  );
}
