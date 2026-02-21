'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { getAlumniByPrefecture, type PrefectureCount } from '@/app/actions/map';
import { getAvatarUrl } from '@/lib/avatar';
import { Spinner } from '@/components/ui/Spinner';

// 都道府県の短縮表示名（北海道・京都を正しく表示）
function getPrefShortName(pref: string): string {
  if (pref === '北海道') return '北海道';
  if (pref === '京都府') return '京都';
  if (pref === '東京都') return '東京';
  if (pref === '大阪府') return '大阪';
  return pref.replace(/県|府|都|道$/, '');
}

// 都道府県の表示順（北から南・日本地図の配置順）
const PREFECTURE_ORDER = [
  '北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県',
  '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', '神奈川県',
  '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県',
  '静岡県', '愛知県', '三重県', '滋賀県', '京都府', '大阪府', '兵庫県',
  '奈良県', '和歌山県', '鳥取県', '島根県', '岡山県', '広島県', '山口県',
  '徳島県', '香川県', '愛媛県', '高知県', '福岡県', '佐賀県', '長崎県',
  '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県', '海外'
];

// 日本地図風グリッド配置（shinagaki/css-grid-japan-map 準拠・隣接関係正しい・海外は沖縄の左）
const GRID_POSITIONS: Record<string, { col: string; row: string }> = {
  '北海道': { col: '13/14', row: '2/3' },
  '青森県': { col: '13/14', row: '3/4' },
  '岩手県': { col: '13/14', row: '4/5' },
  '宮城県': { col: '12/13', row: '4/5' },
  '秋田県': { col: '12/13', row: '1/2' },
  '山形県': { col: '12/13', row: '2/3' },
  '福島県': { col: '12/13', row: '3/4' },
  '茨城県': { col: '11/12', row: '3/4' },
  '栃木県': { col: '11/12', row: '2/3' },
  '群馬県': { col: '11/12', row: '1/2' },
  '埼玉県': { col: '10/11', row: '2/3' },
  '千葉県': { col: '11/12', row: '4/5' },
  '東京都': { col: '10/11', row: '3/4' },
  '神奈川県': { col: '10/11', row: '4/5' },
  '新潟県': { col: '10/11', row: '1/2' },
  '富山県': { col: '9/10', row: '1/2' },
  '石川県': { col: '8/9', row: '1/2' },
  '福井県': { col: '8/9', row: '2/3' },
  '山梨県': { col: '9/10', row: '3/4' },
  '長野県': { col: '9/10', row: '2/3' },
  '岐阜県': { col: '8/9', row: '3/4' },
  '静岡県': { col: '9/10', row: '4/5' },
  '愛知県': { col: '8/9', row: '4/5' },
  '三重県': { col: '7/8', row: '4/5' },
  '滋賀県': { col: '7/8', row: '2/3' },
  '京都府': { col: '7/8', row: '1/2' },
  '大阪府': { col: '6/7', row: '3/4' },
  '兵庫県': { col: '6/7', row: '2/3' },
  '奈良県': { col: '7/8', row: '3/4' },
  '和歌山県': { col: '6/7', row: '4/5' },
  '鳥取県': { col: '6/7', row: '1/2' },
  '島根県': { col: '5/6', row: '1/2' },
  '岡山県': { col: '5/6', row: '2/3' },
  '広島県': { col: '4/5', row: '2/3' },
  '山口県': { col: '4/5', row: '1/2' },
  '徳島県': { col: '5/6', row: '4/5' },
  '香川県': { col: '5/6', row: '3/4' },
  '愛媛県': { col: '4/5', row: '3/4' },
  '高知県': { col: '4/5', row: '4/5' },
  '福岡県': { col: '3/4', row: '1/2' },
  '佐賀県': { col: '2/3', row: '2/3' },
  '長崎県': { col: '2/3', row: '1/2' },
  '熊本県': { col: '2/3', row: '3/4' },
  '大分県': { col: '3/4', row: '2/3' },
  '宮崎県': { col: '3/4', row: '3/4' },
  '鹿児島県': { col: '3/4', row: '4/5' },
  '沖縄県': { col: '2/3', row: '4/5' },
  '海外': { col: '1/2', row: '4/5' },
};

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
          {/* マップグリッド（画面サイズに合わせて大きく表示） */}
          <div
            className="grid gap-1.5 md:gap-2 w-full min-w-0 mx-auto p-4 md:p-6 bg-stone-50 rounded-2xl border border-stone-200 shadow-sm"
            style={{
              gridTemplateColumns: 'repeat(14, 1fr)',
              gridTemplateRows: 'repeat(5, minmax(52px, 1fr))',
              aspectRatio: '14/5',
              minHeight: 320,
            }}
          >
            {PREFECTURE_ORDER.map((pref) => {
              const item = dataMap.get(pref) ?? { prefecture: pref, count: 0, users: [] };
              const count = item.count;
              const isClickable = count > 0;
              const pos = GRID_POSITIONS[pref];

              return (
                <button
                  key={pref}
                  type="button"
                  onClick={() => isClickable && setSelectedPref(item)}
                  disabled={!isClickable}
                  className={`
                    text-left px-2 py-1.5 rounded-lg text-xs md:text-sm font-bold transition min-h-0 flex flex-col justify-center leading-tight
                    ${count === 0 ? 'text-stone-500 bg-stone-200/80 cursor-default' : ''}
                    ${count > 0 ? 'text-orange-900 bg-orange-100 hover:bg-orange-200 hover:ring-2 hover:ring-orange-300/60 cursor-pointer shadow-sm' : ''}
                  `}
                  style={pos ? { gridColumn: pos.col, gridRow: pos.row } : undefined}
                >
                  <span className="block truncate leading-tight">{getPrefShortName(pref)}</span>
                  {count > 0 && <span className="text-orange-600 text-xs mt-0.5">{count}人</span>}
                </button>
              );
            })}
          </div>

          {/* 凡例 */}
          <div className="flex items-center gap-4 text-sm text-stone-500">
            <span>■ 同級生がいる</span>
            <span>■ 0人</span>
          </div>

          {/* 選択した都道府県の一覧 */}
          {selectedPref && selectedPref.users.length > 0 && (
            <div className="mt-6 p-5 bg-stone-50/80 rounded-2xl border border-stone-200/60 shadow-lg">
              <div className="flex justify-between items-center mb-3">
                <h3 className="font-bold text-stone-800">
                  {selectedPref.prefecture} の同級生 ({selectedPref.users.length}人)
                </h3>
                <button
                  type="button"
                  onClick={() => setSelectedPref(null)}
                  className="text-stone-400 hover:text-stone-600 font-bold p-1 rounded-lg hover:bg-stone-200/50 transition"
                >
                  ×
                </button>
              </div>
              <div className="space-y-2">
                {selectedPref.users.map((u) => (
                  <Link
                    key={u.id}
                    href={`/users/${u.id}`}
                    className="flex items-center gap-3 p-3 bg-white/90 rounded-xl border border-stone-100 hover:bg-orange-50/80 transition shadow-sm"
                  >
                    <div className="w-10 h-10 rounded-full overflow-hidden flex-shrink-0 bg-stone-100">
                      <img src={getAvatarUrl(u)} alt="" className="w-full h-full object-cover" />
                    </div>
                    <span className="font-bold text-stone-800 flex-1">{u.display_name}</span>
                    <span className="text-sm text-stone-500">
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
