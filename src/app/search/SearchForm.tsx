'use client';

import { useState } from 'react';
import { searchAlumni } from '@/app/actions/search';
import Link from 'next/link';

export function SearchForm({ schools, prefectures }: { schools: any[]; prefectures: string[] }) {
  const [schoolId, setSchoolId] = useState('');
  const [graduationYear, setGraduationYear] = useState('');
  const [club, setClub] = useState('');
  const [currentPrefecture, setCurrentPrefecture] = useState('');
  const [hometownVisitOnly, setHometownVisitOnly] = useState(false);
  const [results, setResults] = useState<any[]>([]);
  const [isSearching, setIsSearching] = useState(false);
  const [hasSearched, setHasSearched] = useState(false);

  const years = Array.from({ length: 30 }, (_, i) => 2025 - i);

  const handleSearch = async () => {
    setIsSearching(true);
    setHasSearched(true);
    try {
      const data = await searchAlumni({
        schoolId: schoolId || undefined,
        graduationYear: graduationYear ? parseInt(graduationYear) : undefined,
        club: club || undefined,
        currentPrefecture: currentPrefecture || undefined,
        hometownVisitOnly: hometownVisitOnly || undefined,
      });
      setResults(data);
    } finally {
      setIsSearching(false);
    }
  };

  return (
    <div className="space-y-6">
      <div className="grid gap-4">
        <div>
          <label className="block text-sm font-bold text-stone-700 mb-2">学校</label>
          <select
            value={schoolId}
            onChange={(e) => setSchoolId(e.target.value)}
            className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none bg-white"
          >
            <option value="">指定しない</option>
            {schools.map((s) => (
              <option key={s.id} value={s.id}>
                {s.type === 'high' ? '🏫' : '📚'} {s.name}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label className="block text-sm font-bold text-stone-700 mb-2">卒業年</label>
          <select
            value={graduationYear}
            onChange={(e) => setGraduationYear(e.target.value)}
            className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none bg-white"
          >
            <option value="">指定しない</option>
            {years.map((y) => (
              <option key={y} value={y}>{y}年</option>
            ))}
          </select>
        </div>

        <div>
          <label className="block text-sm font-bold text-stone-700 mb-2">部活</label>
          <input
            type="text"
            value={club}
            onChange={(e) => setClub(e.target.value)}
            placeholder="例: 野球部"
            className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none"
          />
        </div>

        <div>
          <label className="block text-sm font-bold text-stone-700 mb-2">現在の居住地</label>
          <select
            value={currentPrefecture}
            onChange={(e) => setCurrentPrefecture(e.target.value)}
            className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:ring-2 focus:ring-orange-200 outline-none bg-white"
          >
            <option value="">指定しない</option>
            {prefectures.map((p) => (
              <option key={p} value={p}>{p}</option>
            ))}
          </select>
        </div>

        <div className="flex items-center gap-2">
          <input
            type="checkbox"
            id="hometownVisitOnly"
            checked={hometownVisitOnly}
            onChange={(e) => setHometownVisitOnly(e.target.checked)}
            className="rounded border-stone-300 text-orange-600 focus:ring-orange-500"
          />
          <label htmlFor="hometownVisitOnly" className="text-sm font-bold text-stone-700">
            🏠 帰省中のみ表示
          </label>
        </div>
      </div>

      <button
        onClick={handleSearch}
        disabled={isSearching}
        className="w-full py-3 bg-orange-600 text-white font-bold rounded-xl hover:bg-orange-700 disabled:opacity-50 transition"
      >
        {isSearching ? '検索中...' : '検索する'}
      </button>

      {results.length > 0 && (
        <div className="mt-8 pt-6 border-t border-stone-200">
          <h2 className="font-bold text-stone-700 mb-4">検索結果 ({results.length}件)</h2>
          <div className="space-y-3">
            {results.map((p) => (
              <Link
                key={p.id}
                href={`/users/${p.id}`}
                className="block p-4 bg-stone-50 rounded-xl hover:bg-orange-50 transition border border-stone-100"
              >
                <div className="flex items-center gap-3">
                  <div className="w-12 h-12 rounded-full bg-stone-200 overflow-hidden flex-shrink-0">
                    <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${p.display_name}`} alt="" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 flex-wrap">
                      <p className="font-bold text-stone-800">{p.display_name}</p>
                      {p.is_hometown_visit && (
                        <span className="px-2 py-0.5 bg-green-100 text-green-700 text-xs font-bold rounded-full">
                          帰省中
                        </span>
                      )}
                    </div>
                    {p.maiden_name && <p className="text-xs text-stone-500">旧姓: {p.maiden_name}</p>}
                    <p className="text-sm text-stone-600">{p.current_prefecture} {p.current_city}在住</p>
                    {(p.industry || p.occupation) && (
                      <p className="text-xs text-stone-500">💼 {[p.industry, p.occupation].filter(Boolean).join(' ・ ')}</p>
                    )}
                    {p.profile_schools?.[0] && (
                      <p className="text-xs text-stone-500 mt-1">
                        {p.profile_schools[0].schools?.name} {p.profile_schools[0].graduation_year}年卒
                        {p.profile_schools[0].club_activities?.[0] && ` ・ ${p.profile_schools[0].club_activities[0]}`}
                      </p>
                    )}
                  </div>
                </div>
              </Link>
            ))}
          </div>
        </div>
      )}

      {results.length === 0 && !isSearching && (
        <div className="text-center mt-4 space-y-2">
          {hasSearched ? (
            <p className="text-stone-500 text-sm">該当する同窓生はいませんでした。</p>
          ) : (
            <p className="text-stone-500 text-sm">条件を入力して「検索する」をクリックしてください。</p>
          )}
          <p className="text-stone-400 text-xs">
            💡 登録者がいない場合: Supabase SQL Editor で <code className="bg-stone-100 px-1 rounded">supabase/seeds/dev_test_profiles.sql</code> を実行するとテストデータが入ります
          </p>
        </div>
      )}
    </div>
  );
}
