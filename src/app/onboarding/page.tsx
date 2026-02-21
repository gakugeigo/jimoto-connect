'use client';

import { useState, useEffect } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { searchSchools, completeOnboarding } from '@/app/actions/onboarding';
import { CLUB_OPTIONS, CLUB_OTHER_VALUE } from '@/lib/constants';
import { ErrorMessage } from '@/components/ui/ErrorMessage';
import { Spinner } from '@/components/ui/Spinner';

// --- Icons ---
const Icons = {
  User: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>,
  School: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m4 6 8-4 8 4"/><path d="m18 10 4 2v8a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2v-8l4-2"/><path d="M14 22v-4a2 2 0 0 0-2-2v0a2 2 0 0 0-2 2v4"/><path d="M18 5v17"/><path d="M6 5v17"/><circle cx="12" cy="9" r="2"/></svg>,
  Check: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round"><path d="M20 6 9 17l-5-5"/></svg>,
  Search: () => <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>,
  Plus: () => <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12h14"/><path d="M12 5v14"/></svg>,
};

const PREFECTURES = [
  "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
  "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
  "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県",
  "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県",
  "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県",
  "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県",
  "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県", "海外"
];

const COUNTRIES = {
  "アジア": [
    "中国", "韓国", "台湾", "香港", "タイ", "ベトナム", "シンガポール", "マレーシア", "インドネシア", "フィリピン", "インド", "カンボジア", "ミャンマー", "モンゴル"
  ],
  "北米": [
    "アメリカ", "カナダ"
  ],
  "中南米": [
    "メキシコ", "ブラジル", "アルゼンチン", "チリ", "ペルー"
  ],
  "オセアニア": [
    "オーストラリア", "ニュージーランド"
  ],
  "ヨーロッパ": [
    "イギリス", "フランス", "ドイツ", "イタリア", "スペイン", "オランダ", "スイス", "ベルギー", "オーストリア", "スウェーデン", "デンマーク", "フィンランド", "ノルウェー", "ポーランド", "ロシア", "トルコ"
  ],
  "中東・アフリカ": [
    "アラブ首長国連邦", "サウジアラビア", "イスラエル", "エジプト", "南アフリカ", "ケニア"
  ]
};

// クラスの選択肢生成
const CLASS_OPTIONS = [
  ...Array.from({ length: 10 }, (_, i) => `${i + 1}組`),
  "分からない",
  "その他 (学科・コース名など)"
];

type SchoolFormState = {
  prefecture: string;
  id: string;
  name: string;
  city: string;
  isNew: boolean;
  graduationYear: string;
  club: string;
  clubOther: string;
  classRoom: string;
  otherClassRoom: string;
};

export default function OnboardingPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const redirectUrl = searchParams.get('redirect_url') || '/dashboard';
  const [step, setStep] = useState(1);
  const [isLoading, setIsLoading] = useState(false);
  const [onboardingError, setOnboardingError] = useState<string | null>(null);

  // Basic Info
  const [basicInfo, setBasicInfo] = useState({
    lastName: '', // 姓
    firstName: '', // 名
    maidenName: '',
    currentPrefecture: '東京都',
    currentCountry: 'アメリカ', 
    otherCountry: '',
  });

  // School Info
  const [juniorHigh, setJuniorHigh] = useState<SchoolFormState>({
    prefecture: '東京都', // デフォルトを東京に
    id: '',
    name: '',
    city: '',
    isNew: false,
    graduationYear: '2012',
    club: '帰宅部',
    clubOther: '',
    classRoom: '1組',
    otherClassRoom: '',
  });

  const [highSchool, setHighSchool] = useState<SchoolFormState>({
    prefecture: '東京都', // デフォルトを東京に
    id: '',
    name: '',
    city: '',
    isNew: false,
    graduationYear: '2015',
    club: '帰宅部',
    clubOther: '',
    classRoom: '1組',
    otherClassRoom: '',
  });

  // Search State
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState<any[]>([]);
  const [isSearching, setIsSearching] = useState(false);
  const [activeSearchType, setActiveSearchType] = useState<'junior_high' | 'high' | null>(null);

  // リアルタイム検索
  useEffect(() => {
    const delayDebounceFn = setTimeout(async () => {
      if (searchQuery.length >= 2 && activeSearchType) {
        setIsSearching(true);
        const targetPrefecture = activeSearchType === 'junior_high' ? juniorHigh.prefecture : highSchool.prefecture;
        const results = await searchSchools(searchQuery, targetPrefecture, activeSearchType);
        setSearchResults(results);
        setIsSearching(false);
      } else {
        setSearchResults([]);
      }
    }, 500);

    return () => clearTimeout(delayDebounceFn);
  }, [searchQuery, activeSearchType, juniorHigh.prefecture, highSchool.prefecture]);

  const handleSelectSchool = (school: any) => {
    if (activeSearchType === 'junior_high') {
      setJuniorHigh({ ...juniorHigh, id: school.id, name: school.name, isNew: false });
    } else {
      setHighSchool({ ...highSchool, id: school.id, name: school.name, isNew: false });
    }
    setSearchQuery('');
    setSearchResults([]);
    setActiveSearchType(null);
  };

  const handleCreateNewSchool = () => {
    if (activeSearchType === 'junior_high') {
      setJuniorHigh({ ...juniorHigh, id: '', name: searchQuery, isNew: true });
    } else {
      setHighSchool({ ...highSchool, id: '', name: searchQuery, isNew: true });
    }
    setSearchQuery('');
    setSearchResults([]);
    setActiveSearchType(null);
  };

  const handleSubmit = async () => {
    setIsLoading(true);
    try {
      const finalCountry = basicInfo.currentPrefecture === '海外' 
        ? (basicInfo.currentCountry === 'その他' ? basicInfo.otherCountry : basicInfo.currentCountry)
        : undefined;

      const getFinalClassRoom = (state: SchoolFormState) => {
        if (state.classRoom === 'その他 (学科・コース名など)') return state.otherClassRoom;
        if (state.classRoom === '分からない') return ''; // DBには空で保存（ダッシュボードで「クラス不明」表示）
        return state.classRoom;
      };

      const getClubValue = (state: SchoolFormState) =>
        state.club === CLUB_OTHER_VALUE ? state.clubOther.trim() : state.club;

      // 姓と名を結合して displayName にする
      const displayName = `${basicInfo.lastName} ${basicInfo.firstName}`;

      const result = await completeOnboarding({
        displayName: displayName,
        maidenName: basicInfo.maidenName,
        currentPrefecture: basicInfo.currentPrefecture,
        currentCountry: finalCountry,
        juniorHigh: juniorHigh.name ? {
          schoolId: juniorHigh.id,
          schoolName: juniorHigh.name,
          prefecture: juniorHigh.prefecture,
          city: juniorHigh.city,
          graduationYear: parseInt(juniorHigh.graduationYear),
          club: getClubValue(juniorHigh),
          classRoom: getFinalClassRoom(juniorHigh),
        } : undefined,
        highSchool: highSchool.name ? {
          schoolId: highSchool.id,
          schoolName: highSchool.name,
          prefecture: highSchool.prefecture,
          city: highSchool.city,
          graduationYear: parseInt(highSchool.graduationYear),
          club: getClubValue(highSchool),
          classRoom: getFinalClassRoom(highSchool),
        } : undefined,
      });
      if (result?.success) {
        router.push(redirectUrl);
        return;
      }
    } catch (error) {
      console.error('Error:', error);
      const msg = error instanceof Error ? error.message : '登録に失敗しました';
      setOnboardingError(`登録に失敗しました。${msg}`);
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#FDF8F5] flex items-center justify-center p-4 font-sans text-stone-800">
      
      <div className="w-full max-w-2xl bg-white/95 backdrop-blur rounded-3xl shadow-xl shadow-stone-200/40 border border-stone-200/60 overflow-hidden">
        
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

              <div className="space-y-6 max-w-md mx-auto">
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-bold text-stone-700 mb-2">姓 (漢字)</label>
                    <input 
                      type="text" 
                      value={basicInfo.lastName}
                      onChange={(e) => setBasicInfo({...basicInfo, lastName: e.target.value})}
                      placeholder="例: 山田"
                      className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-bold text-stone-700 mb-2">名 (漢字)</label>
                    <input 
                      type="text" 
                      value={basicInfo.firstName}
                      onChange={(e) => setBasicInfo({...basicInfo, firstName: e.target.value})}
                      placeholder="例: 太郎"
                      className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition"
                    />
                  </div>
                </div>

                <div>
                  <label className="block text-sm font-bold text-stone-700 mb-2">旧姓 (任意)</label>
                  <input 
                    type="text" 
                    value={basicInfo.maidenName}
                    onChange={(e) => setBasicInfo({...basicInfo, maidenName: e.target.value})}
                    placeholder="例: 佐藤"
                    className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition"
                  />
                </div>

                <div>
                  <label className="block text-sm font-bold text-stone-700 mb-2">現在の居住地</label>
                  <select 
                    value={basicInfo.currentPrefecture}
                    onChange={(e) => setBasicInfo({...basicInfo, currentPrefecture: e.target.value})}
                    className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 outline-none bg-white"
                  >
                    {PREFECTURES.map(pref => (
                      <option key={pref} value={pref}>{pref}</option>
                    ))}
                  </select>
                </div>

                {basicInfo.currentPrefecture === '海外' && (
                  <div className="animate-fade-in space-y-4">
                    <div>
                      <label className="block text-sm font-bold text-stone-700 mb-2">国・地域名</label>
                      <select 
                        value={basicInfo.currentCountry}
                        onChange={(e) => setBasicInfo({...basicInfo, currentCountry: e.target.value})}
                        className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 outline-none bg-white"
                      >
                        {Object.entries(COUNTRIES).map(([region, countries]) => (
                          <optgroup key={region} label={region}>
                            {countries.map(country => (
                              <option key={country} value={country}>{country}</option>
                            ))}
                          </optgroup>
                        ))}
                        <option value="その他">その他</option>
                      </select>
                    </div>
                    
                    {basicInfo.currentCountry === 'その他' && (
                      <div className="animate-fade-in">
                        <label className="block text-sm font-bold text-stone-700 mb-2">具体的な国名を入力</label>
                        <input 
                          type="text" 
                          value={basicInfo.otherCountry}
                          onChange={(e) => setBasicInfo({...basicInfo, otherCountry: e.target.value})}
                          placeholder="例: ポルトガル"
                          className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition"
                        />
                      </div>
                    )}
                  </div>
                )}

                <button 
                  onClick={() => setStep(2)}
                  disabled={!basicInfo.lastName || !basicInfo.firstName || (basicInfo.currentPrefecture === '海外' && basicInfo.currentCountry === 'その他' && !basicInfo.otherCountry)}
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
              {onboardingError && (
                <ErrorMessage
                  message={onboardingError}
                  onDismiss={() => setOnboardingError(null)}
                  className="mb-6"
                />
              )}
              <div className="text-center mb-8">
                <div className="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4 text-blue-600">
                  <Icons.School />
                </div>
                <h2 className="text-2xl font-bold mb-2">学校・部活の登録</h2>
                <p className="text-stone-500 text-sm">つながりたいコミュニティを選びましょう。</p>
              </div>

              <div className="space-y-10">
                
                {/* Junior High Section */}
                <div className="bg-stone-50 p-6 rounded-2xl border border-stone-100">
                  <h3 className="font-bold text-lg mb-4 flex items-center gap-2 text-stone-700">
                    <span className="bg-blue-600 text-white text-xs px-2 py-1 rounded">中学校</span>
                    出身中学
                  </h3>
                  
                  <div className="space-y-4">
                    <div className="grid grid-cols-3 gap-4">
                      <div className="col-span-1">
                        <label className="block text-xs font-bold text-stone-500 mb-1">所在地</label>
                        <select 
                          value={juniorHigh.prefecture}
                          onChange={(e) => setJuniorHigh({...juniorHigh, prefecture: e.target.value, id: '', name: '', isNew: false})}
                          className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm"
                        >
                          {PREFECTURES.filter(p => p !== '海外').map(pref => <option key={pref} value={pref}>{pref}</option>)}
                        </select>
                      </div>
                      <div className="col-span-2 relative">
                        <label className="block text-xs font-bold text-stone-500 mb-1">学校名</label>
                        {juniorHigh.name ? (
                          <div className="space-y-2">
                            <div className="flex items-center justify-between px-3 py-2 bg-white rounded-lg border border-blue-200 text-blue-700 font-bold text-sm">
                              {juniorHigh.name} {juniorHigh.isNew && <span className="text-xs bg-blue-100 px-1 rounded ml-2">新規</span>}
                              <button onClick={() => setJuniorHigh({...juniorHigh, id: '', name: '', isNew: false})} className="text-stone-400 hover:text-red-500">×</button>
                            </div>
                            {juniorHigh.isNew && (
                              <div>
                                <label className="block text-xs font-bold text-stone-500 mb-1">市区町村 (例: 横浜市青葉区)</label>
                                <input 
                                  type="text" 
                                  placeholder="市区町村を入力"
                                  value={juniorHigh.city}
                                  onChange={(e) => setJuniorHigh({...juniorHigh, city: e.target.value})}
                                  className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm"
                                />
                              </div>
                            )}
                          </div>
                        ) : (
                          <div className="relative">
                            <input 
                              type="text" 
                              placeholder="学校名で検索"
                              className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm focus:ring-2 focus:ring-blue-200 outline-none"
                              onFocus={() => setActiveSearchType('junior_high')}
                              value={activeSearchType === 'junior_high' ? searchQuery : ''}
                              onChange={(e) => setSearchQuery(e.target.value)}
                            />
                            {activeSearchType === 'junior_high' && searchQuery.length >= 2 && (
                              <div className="absolute z-10 w-full mt-1 bg-white rounded-lg shadow-lg border border-stone-100 max-h-60 overflow-y-auto">
                                {searchResults.map(s => (
                                  <button key={s.id} onClick={() => handleSelectSchool(s)} className="w-full text-left px-3 py-2 text-sm hover:bg-stone-50 block">{s.name}</button>
                                ))}
                                <button 
                                  onClick={handleCreateNewSchool}
                                  className="w-full text-left px-3 py-3 text-sm hover:bg-blue-50 text-blue-600 font-bold border-t border-stone-100 flex items-center gap-2"
                                >
                                  <Icons.Plus />
                                  "{searchQuery}" を新規登録する
                                </button>
                              </div>
                            )}
                          </div>
                        )}
                      </div>
                    </div>

                    <div className="grid grid-cols-3 gap-4">
                      <div>
                        <label className="block text-xs font-bold text-stone-500 mb-1">卒業年</label>
                        <input type="number" value={juniorHigh.graduationYear} onChange={(e) => setJuniorHigh({...juniorHigh, graduationYear: e.target.value})} className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm" />
                      </div>
                      <div>
                        <label className="block text-xs font-bold text-stone-500 mb-1">部活</label>
                        <select
                          value={juniorHigh.club}
                          onChange={(e) => setJuniorHigh({...juniorHigh, club: e.target.value})}
                          className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm"
                        >
                          {CLUB_OPTIONS.map((opt) => (
                            <option key={opt} value={opt === 'その他' ? CLUB_OTHER_VALUE : opt}>{opt}</option>
                          ))}
                        </select>
                        {juniorHigh.club === CLUB_OTHER_VALUE && (
                          <input
                            type="text"
                            placeholder="部活名を入力"
                            value={juniorHigh.clubOther}
                            onChange={(e) => setJuniorHigh({...juniorHigh, clubOther: e.target.value})}
                            className="w-full px-3 py-2 mt-2 rounded-lg border border-stone-200 text-sm"
                          />
                        )}
                      </div>
                      <div>
                        <label className="block text-xs font-bold text-stone-500 mb-1">3年時のクラス</label>
                        <select 
                          value={juniorHigh.classRoom} 
                          onChange={(e) => setJuniorHigh({...juniorHigh, classRoom: e.target.value})} 
                          className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm"
                        >
                          {CLASS_OPTIONS.map(opt => <option key={opt} value={opt}>{opt}</option>)}
                        </select>
                        {juniorHigh.classRoom === 'その他 (学科・コース名など)' && (
                          <input 
                            type="text" 
                            placeholder="学科・コース名" 
                            value={juniorHigh.otherClassRoom} 
                            onChange={(e) => setJuniorHigh({...juniorHigh, otherClassRoom: e.target.value})} 
                            className="w-full px-3 py-2 mt-2 rounded-lg border border-stone-200 text-sm" 
                          />
                        )}
                      </div>
                    </div>
                  </div>
                </div>

                {/* High School Section */}
                <div className="bg-stone-50 p-6 rounded-2xl border border-stone-100">
                  <h3 className="font-bold text-lg mb-4 flex items-center gap-2 text-stone-700">
                    <span className="bg-orange-600 text-white text-xs px-2 py-1 rounded">高校</span>
                    出身高校
                  </h3>
                  
                  <div className="space-y-4">
                    <div className="grid grid-cols-3 gap-4">
                      <div className="col-span-1">
                        <label className="block text-xs font-bold text-stone-500 mb-1">所在地</label>
                        <select 
                          value={highSchool.prefecture}
                          onChange={(e) => setHighSchool({...highSchool, prefecture: e.target.value, id: '', name: '', isNew: false})}
                          className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm"
                        >
                          {PREFECTURES.filter(p => p !== '海外').map(pref => <option key={pref} value={pref}>{pref}</option>)}
                        </select>
                      </div>
                      <div className="col-span-2 relative">
                        <label className="block text-xs font-bold text-stone-500 mb-1">学校名</label>
                        {highSchool.name ? (
                          <div className="space-y-2">
                            <div className="flex items-center justify-between px-3 py-2 bg-white rounded-lg border border-orange-200 text-orange-700 font-bold text-sm">
                              {highSchool.name} {highSchool.isNew && <span className="text-xs bg-orange-100 px-1 rounded ml-2">新規</span>}
                              <button onClick={() => setHighSchool({...highSchool, id: '', name: '', isNew: false})} className="text-stone-400 hover:text-red-500">×</button>
                            </div>
                            {highSchool.isNew && (
                              <div>
                                <label className="block text-xs font-bold text-stone-500 mb-1">市区町村 (例: 横浜市青葉区)</label>
                                <input 
                                  type="text" 
                                  placeholder="市区町村を入力"
                                  value={highSchool.city}
                                  onChange={(e) => setHighSchool({...highSchool, city: e.target.value})}
                                  className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm"
                                />
                              </div>
                            )}
                          </div>
                        ) : (
                          <div className="relative">
                            <input 
                              type="text" 
                              placeholder="学校名で検索"
                              className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm focus:ring-2 focus:ring-orange-200 outline-none"
                              onFocus={() => setActiveSearchType('high')}
                              value={activeSearchType === 'high' ? searchQuery : ''}
                              onChange={(e) => setSearchQuery(e.target.value)}
                            />
                            {activeSearchType === 'high' && searchQuery.length >= 2 && (
                              <div className="absolute z-10 w-full mt-1 bg-white rounded-lg shadow-lg border border-stone-100 max-h-60 overflow-y-auto">
                                {searchResults.map(s => (
                                  <button key={s.id} onClick={() => handleSelectSchool(s)} className="w-full text-left px-3 py-2 text-sm hover:bg-stone-50 block">{s.name}</button>
                                ))}
                                <button 
                                  onClick={handleCreateNewSchool}
                                  className="w-full text-left px-3 py-3 text-sm hover:bg-orange-50 text-orange-600 font-bold border-t border-stone-100 flex items-center gap-2"
                                >
                                  <Icons.Plus />
                                  "{searchQuery}" を新規登録する
                                </button>
                              </div>
                            )}
                          </div>
                        )}
                      </div>
                    </div>

                    <div className="grid grid-cols-3 gap-4">
                      <div>
                        <label className="block text-xs font-bold text-stone-500 mb-1">卒業年</label>
                        <input type="number" value={highSchool.graduationYear} onChange={(e) => setHighSchool({...highSchool, graduationYear: e.target.value})} className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm" />
                      </div>
                      <div>
                        <label className="block text-xs font-bold text-stone-500 mb-1">部活</label>
                        <select
                          value={highSchool.club}
                          onChange={(e) => setHighSchool({...highSchool, club: e.target.value})}
                          className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm"
                        >
                          {CLUB_OPTIONS.map((opt) => (
                            <option key={opt} value={opt === 'その他' ? CLUB_OTHER_VALUE : opt}>{opt}</option>
                          ))}
                        </select>
                        {highSchool.club === CLUB_OTHER_VALUE && (
                          <input
                            type="text"
                            placeholder="部活名を入力"
                            value={highSchool.clubOther}
                            onChange={(e) => setHighSchool({...highSchool, clubOther: e.target.value})}
                            className="w-full px-3 py-2 mt-2 rounded-lg border border-stone-200 text-sm"
                          />
                        )}
                      </div>
                      <div>
                        <label className="block text-xs font-bold text-stone-500 mb-1">3年時のクラス</label>
                        <select 
                          value={highSchool.classRoom} 
                          onChange={(e) => setHighSchool({...highSchool, classRoom: e.target.value})} 
                          className="w-full px-3 py-2 rounded-lg border border-stone-200 text-sm"
                        >
                          {CLASS_OPTIONS.map(opt => <option key={opt} value={opt}>{opt}</option>)}
                        </select>
                        {highSchool.classRoom === 'その他 (学科・コース名など)' && (
                          <input 
                            type="text" 
                            placeholder="学科・コース名" 
                            value={highSchool.otherClassRoom} 
                            onChange={(e) => setHighSchool({...highSchool, otherClassRoom: e.target.value})} 
                            className="w-full px-3 py-2 mt-2 rounded-lg border border-stone-200 text-sm" 
                          />
                        )}
                      </div>
                    </div>
                  </div>
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
                    disabled={(!juniorHigh.name && !highSchool.name) || isLoading}
                    className="flex-[2] bg-orange-600 text-white font-bold py-4 rounded-xl shadow-lg hover:bg-orange-700 transition disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                  >
                    {isLoading ? (
                      <>
                        <Spinner className="w-5 h-5" />
                        登録中...
                      </>
                    ) : (
                      <>
                        はじめる
                        <Icons.Check />
                      </>
                    )}
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
