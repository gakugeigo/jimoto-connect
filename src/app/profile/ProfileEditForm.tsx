'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { updateProfileDetails } from '@/app/actions/profile';

const INDUSTRY_OPTIONS = [
  'IT・通信', '製造業', '金融・保険', '小売・卸売', 'サービス', '建設・不動産',
  '医療・福祉', '教育', '公務', 'メディア・広告', 'その他'
];

const OCCUPATION_OPTIONS = [
  'エンジニア', '営業', 'マーケティング', 'デザイナー', '企画', '経理・財務',
  '人事', '事務', '医療従事者', '教員', '公務員', 'その他'
];

const OTHER_VALUE = '__OTHER__';

function getSelectValue(val: string, options: string[]) {
  if (!val) return '';
  if (val === 'その他' || !options.includes(val)) return OTHER_VALUE;
  return val;
}

function getOtherValue(val: string, options: string[]) {
  if (!val) return '';
  if (options.includes(val) && val !== 'その他') return '';
  return val;
}

export function ProfileEditForm({
  maidenName,
  industry,
  occupation,
}: {
  maidenName: string;
  industry: string;
  occupation: string;
}) {
  const [maidenNameVal, setMaidenNameVal] = useState(maidenName);
  const [industrySelect, setIndustrySelect] = useState(getSelectValue(industry, INDUSTRY_OPTIONS));
  const [industryOther, setIndustryOther] = useState(getOtherValue(industry, INDUSTRY_OPTIONS));
  const [occupationSelect, setOccupationSelect] = useState(getSelectValue(occupation, OCCUPATION_OPTIONS));
  const [occupationOther, setOccupationOther] = useState(getOtherValue(occupation, OCCUPATION_OPTIONS));
  const router = useRouter();
  const [isLoading, setIsLoading] = useState(false);
  const [message, setMessage] = useState<'success' | 'error' | null>(null);

  const industryVal = industrySelect === OTHER_VALUE ? industryOther.trim() : industrySelect;
  const occupationVal = occupationSelect === OTHER_VALUE ? occupationOther.trim() : occupationSelect;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setMessage(null);
    try {
      await updateProfileDetails(maidenNameVal, industryVal, occupationVal);
      router.push('/dashboard');
    } catch (err) {
      console.error(err);
      setMessage('error');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div>
        <label className="block text-sm font-bold text-stone-800 mb-2">旧姓 (任意)</label>
        <p className="text-xs text-stone-500 mb-2">
          結婚などで姓が変わった場合、同級生に探してもらいやすくするため旧姓を登録できます。
        </p>
        <input
          type="text"
          value={maidenNameVal}
          onChange={(e) => setMaidenNameVal(e.target.value)}
          placeholder="例: 佐藤"
          className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition"
        />
      </div>

      <div>
        <label className="block text-sm font-bold text-stone-800 mb-2">業界 (任意)</label>
        <p className="text-xs text-stone-500 mb-2">会社名は表示されません。業界のみ同級生に共有されます。</p>
        <select
          value={industrySelect}
          onChange={(e) => setIndustrySelect(e.target.value)}
          className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition bg-white"
        >
          <option value="">選択しない</option>
          {INDUSTRY_OPTIONS.map((opt) => (
            <option key={opt} value={opt === 'その他' ? OTHER_VALUE : opt}>{opt}</option>
          ))}
        </select>
        {industrySelect === OTHER_VALUE && (
          <input
            type="text"
            value={industryOther}
            onChange={(e) => setIndustryOther(e.target.value)}
            placeholder="業界を入力（例: 飲食業）"
            className="mt-2 w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition placeholder:text-stone-700"
          />
        )}
      </div>

      <div>
        <label className="block text-sm font-bold text-stone-800 mb-2">職種 (任意)</label>
        <select
          value={occupationSelect}
          onChange={(e) => setOccupationSelect(e.target.value)}
          className="w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition bg-white"
        >
          <option value="">選択しない</option>
          {OCCUPATION_OPTIONS.map((opt) => (
            <option key={opt} value={opt === 'その他' ? OTHER_VALUE : opt}>{opt}</option>
          ))}
        </select>
        {occupationSelect === OTHER_VALUE && (
          <input
            type="text"
            value={occupationOther}
            onChange={(e) => setOccupationOther(e.target.value)}
            placeholder="職種を入力（例: コンサルタント）"
            className="mt-2 w-full px-4 py-3 rounded-xl border border-stone-200 focus:border-orange-500 focus:ring-2 focus:ring-orange-200 outline-none transition placeholder:text-stone-700"
          />
        )}
      </div>

      {message === 'success' && (
        <p className="text-sm text-green-600 font-medium">保存しました。</p>
      )}
      {message === 'error' && (
        <p className="text-sm text-red-600 font-medium">保存に失敗しました。もう一度お試しください。</p>
      )}

      <button
        type="submit"
        disabled={isLoading}
        className="px-6 py-2.5 bg-orange-600 text-white font-bold rounded-xl hover:bg-orange-700 disabled:opacity-50 transition"
      >
        {isLoading ? '保存中...' : '保存'}
      </button>
    </form>
  );
}
