'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { getAlumniByPrefecture, type PrefectureCount } from '@/app/actions/map';
import { getAvatarUrl } from '@/lib/avatar';
import { Spinner } from '@/components/ui/Spinner';

export function ResidentsClient({
  schools,
  years,
}: {
  schools: any[];
  years: number[];
}) {
  const [data, setData] = useState<PrefectureCount[]>([]);
  const [loading, setLoading] = useState(true);
  const [schoolId, setSchoolId] = useState('');
  const [graduationYear, setGraduationYear] = useState<number | ''>('');
  const [expandedPref, setExpandedPref] = useState<string | null>(null);

  useEffect(() => {
    setLoading(true);
    getAlumniByPrefecture({
      schoolId: schoolId || undefined,
      graduationYear: graduationYear || undefined,
    })
      .then(setData)
      .finally(() => setLoading(false));
  }, [schoolId, graduationYear]);

  const withAlumni = data.filter((d) => d.count > 0);
  const totalCount = withAlumni.reduce((sum, d) => sum + d.count, 0);

  return (
    <div className="p-4 md:p-6 space-y-4 md:space-y-6">
      {/* フィルタ */}
      <div className="flex flex-wrap gap-4">
        <div>
          <label className="block text-xs font-bold text-stone-500 mb-1">学校</label>
          <select
            value={schoolId}
            onChange={(e) => setSchoolId(e.target.value)}
            className="px-4 py-2.5 rounded-xl border border-stone-200 text-sm bg-white focus:ring-2 focus:ring-orange-200 focus:border-orange-300 outline-none"
          >
            <option value="">すべて</option>
            {schools.map((s: any) => (
              <option key={s.id} value={s.id}>
                {s.type === 'high' ? '🏫' : '📚'} {s.name}
              </option>
            ))}
          </select>
        </div>
        <div>
          <label className="block text-xs font-bold text-stone-500 mb-1">卒業年</label>
          <select
            value={graduationYear}
            onChange={(e) => setGraduationYear(e.target.value ? parseInt(e.target.value) : '')}
            className="px-4 py-2.5 rounded-xl border border-stone-200 text-sm bg-white focus:ring-2 focus:ring-orange-200 focus:border-orange-300 outline-none"
          >
            <option value="">すべて</option>
            {years.map((y) => (
              <option key={y} value={y}>{y}年</option>
            ))}
          </select>
        </div>
      </div>

      {loading ? (
        <div className="flex justify-center py-16">
          <Spinner className="w-10 h-10" />
        </div>
      ) : (
        <>
          {totalCount === 0 ? (
            <div className="py-12 text-center text-stone-500">
              <p>該当する同級生はいません。</p>
              <p className="text-sm mt-2">学校や卒業年を変えてみてください。</p>
            </div>
          ) : (
            <>
              <p className="text-sm text-stone-600">
                計 <span className="font-bold text-orange-600">{totalCount}人</span> が
                <span className="font-bold">{withAlumni.length}都道府県</span>に在住
              </p>

              <div className="space-y-2">
                {withAlumni.map((item) => {
                  const isExpanded = expandedPref === item.prefecture;
                  return (
                    <div
                      key={item.prefecture}
                      className="rounded-xl border border-stone-200/60 overflow-hidden bg-white shadow-sm"
                    >
                      <button
                        type="button"
                        onClick={() => setExpandedPref(isExpanded ? null : item.prefecture)}
                        className="w-full flex items-center justify-between p-4 text-left hover:bg-stone-50/80 transition"
                      >
                        <span className="font-bold text-stone-800">{item.prefecture}</span>
                        <span className="flex items-center gap-2">
                          <span className="text-orange-600 font-bold">{item.count}人</span>
                          <span className={`text-stone-400 transition-transform ${isExpanded ? 'rotate-180' : ''}`}>
                            ▼
                          </span>
                        </span>
                      </button>

                      {isExpanded && (
                        <div className="border-t border-stone-100 bg-stone-50/50 p-4 space-y-2">
                          {item.users.map((u) => (
                            <Link
                              key={u.id}
                              href={`/users/${u.id}`}
                              className="flex items-center gap-3 p-3 bg-white rounded-xl border border-stone-100 hover:bg-orange-50/80 transition"
                            >
                              <div className="w-10 h-10 rounded-full overflow-hidden flex-shrink-0 bg-stone-100">
                                <img src={getAvatarUrl(u)} alt="" className="w-full h-full object-cover" />
                              </div>
                              <div className="flex-1 min-w-0">
                                <span className="font-bold text-stone-800 block truncate">{u.display_name}</span>
                                {u.current_city && (
                                  <span className="text-xs text-stone-500">{u.current_city}</span>
                                )}
                              </div>
                              {u.is_hometown_visit && (
                                <span className="px-2 py-0.5 bg-green-100 text-green-700 text-xs font-bold rounded-full flex-shrink-0">
                                  帰省中
                                </span>
                              )}
                            </Link>
                          ))}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            </>
          )}
        </>
      )}
    </div>
  );
}
