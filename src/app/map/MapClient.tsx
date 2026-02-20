'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { getAlumniByPrefecture, type PrefectureCount } from '@/app/actions/map';
import { Spinner } from '@/components/ui/Spinner';

// 都道府県の表示順（北から南）
const PREFECTURE_ORDER = [
  '北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県',
  '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', '神奈川県',
  '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県',
  '静岡県', '愛知県', '三重県', '滋賀県', '京都府', '大阪府', '兵庫県',
  '奈良県', '和歌山県', '鳥取県', '島根県', '岡山県', '広島県', '山口県',
  '徳島県', '香川県', '愛媛県', '高知県', '福岡県', '佐賀県', '長崎県',
  '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県', '海外'
];

export function MapClient({
  schools,
  years,
  prefectures,
}: {
  schools: any[];
  years: number[];
  prefectures: string[];
}) {
  const [data, setData] = useState<PrefectureCount[]>([]);
  const [loading, setLoading] = useState(true);
  const [schoolId, setSchoolId] = useState('');
  const [graduationYear, setGraduationYear] = useState<number | ''>('');
  const [selectedPref, setSelectedPref] = useState<PrefectureCount | null>(null);

  useEffect(() => {
    setLoading(true);
    getAlumniByPrefecture({
      schoolId: schoolId || undefined,
      graduationYear: graduationYear || undefined,
    })
      .then(setData)
      .finally(() => setLoading(false));
  }, [schoolId, graduationYear]);

  const dataMap = new Map(data.map((d) => [d.prefecture, d]));

  return (
    <div className="p-6 space-y-6">
      {/* フィルタ */}
      <div className="flex flex-wrap gap-4">
        <div>
          <label className="block text-xs font-bold text-stone-500 mb-1">学校</label>
          <select
            value={schoolId}
            onChange={(e) => setSchoolId(e.target.value)}
            className="px-3 py-2 rounded-lg border border-stone-200 text-sm bg-white"
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
            className="px-3 py-2 rounded-lg border border-stone-200 text-sm bg-white"
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
          {/* マップグリッド（都道府県をタイル表示） */}
          <div className="grid grid-cols-4 sm:grid-cols-6 md:grid-cols-8 gap-2">
            {PREFECTURE_ORDER.map((pref) => {
              const item = dataMap.get(pref) ?? { prefecture: pref, count: 0, users: [] };
              const count = item.count;
              const isClickable = count > 0;

              return (
                <button
                  key={pref}
                  type="button"
                  onClick={() => isClickable && setSelectedPref(item)}
                  disabled={!isClickable}
                  className={`
                    text-left px-3 py-2.5 rounded-lg text-sm font-bold transition min-h-[52px] flex flex-col justify-center
                    ${count === 0 ? 'text-stone-400 bg-stone-100 cursor-default' : ''}
                    ${count > 0 ? 'text-orange-900 bg-orange-100 hover:bg-orange-200 hover:ring-2 hover:ring-orange-300 cursor-pointer' : ''}
                  `}
                >
                  <span className="block truncate">{pref.replace('県', '').replace('府', '').replace('都', '').replace('道', '')}</span>
                  {count > 0 && <span className="text-orange-600 text-xs mt-0.5">{count}人</span>}
                </button>
              );
            })}
          </div>

          {/* 凡例 */}
          <div className="flex items-center gap-4 text-xs text-stone-500">
            <span>■ 同級生がいる</span>
            <span>■ 0人</span>
          </div>

          {/* 選択した都道府県の一覧 */}
          {selectedPref && selectedPref.users.length > 0 && (
            <div className="mt-6 p-4 bg-stone-50 rounded-xl border border-stone-200">
              <div className="flex justify-between items-center mb-3">
                <h3 className="font-bold text-stone-800">
                  {selectedPref.prefecture} の同級生 ({selectedPref.users.length}人)
                </h3>
                <button
                  type="button"
                  onClick={() => setSelectedPref(null)}
                  className="text-stone-400 hover:text-stone-600 font-bold"
                >
                  ×
                </button>
              </div>
              <div className="space-y-2">
                {selectedPref.users.map((u) => (
                  <Link
                    key={u.id}
                    href={`/users/${u.id}`}
                    className="flex items-center justify-between p-3 bg-white rounded-lg border border-stone-100 hover:bg-orange-50 transition"
                  >
                    <span className="font-bold text-stone-800">{u.display_name}</span>
                    <span className="text-sm text-stone-500">
                      {u.current_city && `${u.current_city} `}
                      {u.is_hometown_visit && (
                        <span className="px-2 py-0.5 bg-green-100 text-green-700 text-xs font-bold rounded-full">
                          帰省中
                        </span>
                      )}
                    </span>
                  </Link>
                ))}
              </div>
            </div>
          )}
        </>
      )}
    </div>
  );
}
