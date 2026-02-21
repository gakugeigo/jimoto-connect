/** DiceBear のプリセットスタイル */
export const DICEBEAR_PRESETS = [
  { id: 'lorelei', name: 'イラスト' },
  { id: 'notionists', name: 'ミニマル' },
  { id: 'bottts', name: 'ロボット' },
  { id: 'thumbs', name: 'サムネイル' },
  { id: 'avataaars', name: 'アバター' },
  { id: 'micah', name: 'ピクセル' },
  // 女の子向け
  { id: 'lorelei-neutral', name: 'ローレライ' },
  { id: 'adventurer', name: '冒険' },
  { id: 'big-ears', name: 'むっちり' },
  { id: 'big-smile', name: 'スマイル' },
  { id: 'open-peeps', name: 'オープン' },
  { id: 'fun-emoji', name: '絵文字' },
] as const;

/** カスタムアイコン（ノート+鉛筆、5種類の花×5色） */
export const CUSTOM_ICONS = [
  { id: 'icon:notebook-pencil', name: 'ノート', path: '/avatars/notebook-pencil.svg' },
  { id: 'icon:flower-rose', name: 'バラ', path: '/avatars/flower-rose.svg' },
  { id: 'icon:flower-tulip', name: 'チューリップ', path: '/avatars/flower-tulip.svg' },
  { id: 'icon:flower-sunflower', name: 'ひまわり', path: '/avatars/flower-sunflower.svg' },
  { id: 'icon:flower-sakura', name: 'さくら', path: '/avatars/flower-sakura.svg' },
  { id: 'icon:flower-lily', name: 'ユリ', path: '/avatars/flower-lily.svg' },
] as const;

/** 全プリセット（DiceBear + カスタムアイコン） */
export const AVATAR_PRESETS = [...DICEBEAR_PRESETS, ...CUSTOM_ICONS] as const;

export type AvatarPresetId = (typeof AVATAR_PRESETS)[number]['id'];

/** プロフィールからアバター画像URLを取得 */
export function getAvatarUrl(profile: {
  avatar_url?: string | null;
  display_name?: string;
  clerk_user_id?: string;
  id?: string;
}) {
  const seed = profile.display_name || profile.clerk_user_id || profile.id || 'default';
  const encodedSeed = encodeURIComponent(String(seed));

  // カスタム画像（アップロードした写真）
  if (profile.avatar_url && !profile.avatar_url.startsWith('preset:') && !profile.avatar_url.startsWith('icon:')) {
    return profile.avatar_url;
  }

  // カスタムアイコン（ノート、花など）
  if (profile.avatar_url?.startsWith('icon:')) {
    const iconId = profile.avatar_url.replace('icon:', '');
    const icon = CUSTOM_ICONS.find((c) => c.id === profile.avatar_url);
    if (icon) return icon.path;
    return `/avatars/${iconId}.svg`;
  }

  // DiceBear プリセット
  const style = profile.avatar_url?.startsWith('preset:')
    ? profile.avatar_url.replace('preset:', '')
    : 'lorelei';

  return `https://api.dicebear.com/7.x/${style}/svg?seed=${encodedSeed}`;
}
