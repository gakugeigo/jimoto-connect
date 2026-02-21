/** 部活の選択肢（選択式＋その他で自由入力） */
export const CLUB_OPTIONS = [
  '帰宅部',
  '野球部',
  'サッカー部',
  'バスケットボール部',
  'バレーボール部',
  'テニス部',
  '陸上部',
  '水泳部',
  '卓球部',
  '剣道部',
  '柔道部',
  '吹奏楽部',
  '合唱部',
  '美術部',
  '書道部',
  '演劇部',
  'その他',
] as const;

export const CLUB_OTHER_VALUE = '__OTHER__';

/** 業界の選択肢（選択式＋その他で自由入力） */
export const INDUSTRY_OPTIONS = [
  'IT・通信', '製造業', '金融・保険', '小売・卸売', 'サービス', '建設・不動産',
  '医療・福祉', '教育', '公務', 'メディア・広告', 'その他',
] as const;

export const INDUSTRY_OTHER_VALUE = '__OTHER__';

/** 職種の選択肢（選択式＋その他で自由入力） */
export const OCCUPATION_OPTIONS = [
  'エンジニア', '営業', 'マーケティング', 'デザイナー', '企画', '経理・財務',
  '人事', '事務', '医療従事者', '教員', '公務員', 'その他',
] as const;

export const OCCUPATION_OTHER_VALUE = '__OTHER__';
