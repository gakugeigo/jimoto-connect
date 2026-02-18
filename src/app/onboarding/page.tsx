'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { searchSchools, completeOnboarding } from '@/app/actions/onboarding';

// --- Icons ---
const Icons = {
  User: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>,
  School: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m4 6 8-4 8 4"/><path d="m18 10 4 2v8a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2v-8l4-2"/><path d="M14 22v-4a2 2 0 0 0-2-2v0a2 2 0 0 0-2 2v4"/><path d="M18 5v17"/><path d="M6 5v17"/><circle cx="12" cy="9" r="2"/></svg>,
  Check: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round"><path d="M20 6 9 17l-5-5"/></svg>,
  Search: () => <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>,
};

const PREFECTURES = [
  "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
  "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
  "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県",
  "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県",
  "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県",
  "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県",
  "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"
];

export default function OnboardingPage() {
  const router = useRouter();
  const [step, setStep] = useState(1);
  const [isLoading, setIsLoading] = useState(false);

  // Form State
  const [formData, setFormData] = useState({
    displayName: '',
    homePrefecture: '沖縄県',
    currentPrefecture: '東京都',
    schoolPrefecture: '沖縄県',
    schoolId: '',
    schoolName: '',
    graduationYear: '2015',
    club: '',
    classRoom: '', // 追加
  });

  // School Search State
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState<any[]>([]);
  const [isSearching, setIsSearching] = useState(false);

  // リアルタイム検索 (Debounce)
  useEffect(() => {
    const delayDebounceFn = setTimeout(async () => {
      if (searchQuery.length >= 2) {
        setIsSearching(true);
        const results = await searchSchools(searchQuery, formData.schoolPrefecture);
        setSearchResults(results);
        setIsSearching(false);
      } else {
        setSearchResults([]);
      }
    }, 500);

    return () => clearTimeout(delayDebounceFn);
  }, [searchQuery, formData.schoolPrefecture]);

  const handleSelectSchool = (school: any) => {
    setFormData({ ...formData, schoolId: school.id, schoolName: school.name });
    setSearchQuery(school.name);
    setSearchResults([]);
  };

  const handleSubmit = async () => {
    setIsLoading(true);
    try {
      await completeOnboarding({
        displayName: formData.displayName,
        homePrefecture: formData.homePrefecture,
        currentPrefecture: formData.currentPrefecture,
        schoolId: formData.schoolId,
        graduationYear: parseInt(formData.graduationYear),
        club: formData.club,
        classRoom: formData.classRoom, // 追加
      });
    } catch (error) {
      console.error('Error:', error);
      alert('登録に失敗しました。もう一度お試しください。');
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#FDF8F5] flex items-center justify-center p-4 font-sans text-stone-800">
      
      <div className="w-full max-w-lg bg-white rounded-3xl shadow-xl border border-orange-100 overflow-hidden">
        
        {/* Progress Bar */}
        <div className="h-2 bg-stone-100 w-full">
          <div 
            className="h-full bg-orange-500 transition-all duration-500 ease-out"
            style={{ width: step === 1 ? '50%' : '100%' }}
          />
        </div>

        <div className="p-8 md:p-12">
          
          {/* --- Step 1: Basic Info --- */}
          {step === 1 && (
            <div className="animate-fade-in">
              <div className="text-center mb-8">
                <div className="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4 text-orange-600">
                  <Icons.User />
                </div>
                <h2 className="text-2xl font-bold mb-2">プロフィール作成</h2>
                <p className="text-stone-500 text-sm">まずは基本情報を教えてください。</p>
              </div>

              <div className="space-y-6">
                <div>
                  <label className="block text-sm font-bold text-stone-700 mb-2">お名前 (ニックネーム可)</label>
                  <input 
                    type="text" 
                    value={formData.displayName}
                    onChange={(e) => setFormData({...formData, displayName: e.target.value})}
                    placeholder="例: 山田 太郎"
                    className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition"
                  />
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-bold text-stone-700 mb-2">出身地</label>
                    <select 
                      value={formData.homePrefecture}
                      onChange={(e) => setFormData({...formData, homePrefecture: e.target.value})}
                      className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 outline-none bg-white"
                    >
                      {PREFECTURES.map(pref => (
                        <option key={pref} value={pref}>{pref}</option>
                      ))}
                    </select>
                  </div>
                  <div>
                    <label className="block text-sm font-bold text-stone-700 mb-2">現在の居住地</label>
                    <select 
                      value={formData.currentPrefecture}
                      onChange={(e) => setFormData({...formData, currentPrefecture: e.target.value})}
                      className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 outline-none bg-white"
                    >
                      {PREFECTURES.map(pref => (
                        <option key={pref} value={pref}>{pref}</option>
                      ))}
                    </select>
                  </div>
                </div>

                <button 
                  onClick={() => setStep(2)}
                  disabled={!formData.displayName}
                  className="w-full bg-stone-800 text-white font-bold py-4 rounded-xl shadow-lg hover:bg-stone-900 transition disabled:opacity-50 disabled:cursor-not-allowed mt-4"
                >
                  次へ進む
                </button>
              </div>
            </div>
          )}

          {/* --- Step 2: School Info --- */}
          {step === 2 && (
            <div className="animate-fade-in">
              <div className="text-center mb-8">
                <div className="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4 text-blue-600">
                  <Icons.School />
                </div>
                <h2 className="text-2xl font-bold mb-2">学校・部活の登録</h2>
                <p className="text-stone-500 text-sm">つながりたいコミュニティを選びましょう。</p>
              </div>

              <div className="space-y-6">
                
                {/* School Prefecture Select */}
                <div>
                  <label className="block text-sm font-bold text-stone-700 mb-2">学校の所在地</label>
                  <select 
                    value={formData.schoolPrefecture}
                    onChange={(e) => setFormData({...formData, schoolPrefecture: e.target.value, schoolId: '', schoolName: ''})}
                    className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 outline-none bg-white"
                  >
                    {PREFECTURES.map(pref => (
                      <option key={pref} value={pref}>{pref}</option>
                    ))}
                  </select>
                </div>

                {/* School Search */}
                <div className="relative">
                  <label className="block text-sm font-bold text-stone-700 mb-2">学校名 (中学または高校)</label>
                  <div className="relative">
                    <div className="absolute left-4 top-3.5 text-stone-400">
                      <Icons.Search />
                    </div>
                    <input 
                      type="text" 
                      value={searchQuery}
                      onChange={(e) => setSearchQuery(e.target.value)}
                      placeholder="学校名を入力 (例: 那覇)"
                      className="w-full pl-12 pr-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition"
                    />
                    {isSearching && (
                      <div className="absolute right-4 top-3.5 text-stone-400 animate-spin">
                        ⌛
                      </div>
                    )}
                  </div>
                  
                  {/* Search Results Dropdown */}
                  {searchResults.length > 0 && (
                    <div className="absolute z-10 w-full mt-2 bg-white rounded-xl shadow-xl border border-stone-100 max-h-60 overflow-y-auto">
                      {searchResults.map(school => (
                        <button
                          key={school.id}
                          onClick={() => handleSelectSchool(school)}
                          className="w-full text-left px-4 py-3 hover:bg-orange-50 transition border-b border-stone-50 last:border-0"
                        >
                          <div className="font-bold text-stone-800">{school.name}</div>
                          <div className="text-xs text-stone-400">{school.prefecture} • {school.type === 'high' ? '高校' : '中学校'}</div>
                        </button>
                      ))}
                    </div>
                  )}
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-bold text-stone-700 mb-2">卒業年 (西暦)</label>
                    <input 
                      type="number" 
                      value={formData.graduationYear}
                      onChange={(e) => setFormData({...formData, graduationYear: e.target.value})}
                      placeholder="2015"
                      className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 outline-none"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-bold text-stone-700 mb-2">3年時のクラス</label>
                    <input 
                      type="text" 
                      value={formData.classRoom}
                      onChange={(e) => setFormData({...formData, classRoom: e.target.value})}
                      placeholder="例: 3年2組"
                      className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 outline-none"
                    />
                  </div>
                </div>

                <div>
                  <label className="block text-sm font-bold text-stone-700 mb-2">所属していた部活</label>
                  <input 
                    type="text" 
                    value={formData.club}
                    onChange={(e) => setFormData({...formData, club: e.target.value})}
                    placeholder="例: 野球部"
                    className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 outline-none"
                  />
                </div>

                <div className="flex gap-3 mt-8">
                  <button 
                    onClick={() => setStep(1)}
                    className="flex-1 bg-stone-100 text-stone-600 font-bold py-4 rounded-xl hover:bg-stone-200 transition"
                  >
                    戻る
                  </button>
                  <button 
                    onClick={handleSubmit}
                    disabled={!formData.schoolId || isLoading}
                    className="flex-[2] bg-orange-600 text-white font-bold py-4 rounded-xl shadow-lg hover:bg-orange-700 transition disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                  >
                    {isLoading ? '登録中...' : 'はじめる'}
                    {!isLoading && <Icons.Check />}
                  </button>
                </div>
              </div>
            </div>
          )}

        </div>
      </div>
    </div>
  );
}
