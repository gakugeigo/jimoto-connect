'use client';

import { useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import { updateProfileAvatar, updateProfileAvatarPreset } from '@/app/actions/profile';
import { getAvatarUrl, DICEBEAR_PRESETS, CUSTOM_ICONS } from '@/lib/avatar';
import { ErrorMessage } from '@/components/ui/ErrorMessage';
import { Spinner } from '@/components/ui/Spinner';

export function ProfileAvatarEditor({ profile }: { profile: { avatar_url?: string | null; display_name?: string; clerk_user_id?: string } }) {
  const router = useRouter();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [isUploading, setIsUploading] = useState(false);
  const [isSelectingPreset, setIsSelectingPreset] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const avatarUrl = getAvatarUrl(profile);
  const currentPreset = profile.avatar_url?.startsWith('preset:')
    ? profile.avatar_url.replace('preset:', '')
    : profile.avatar_url?.startsWith('icon:')
      ? profile.avatar_url
      : null;
  const hasCustomPhoto = profile.avatar_url && !profile.avatar_url.startsWith('preset:') && !profile.avatar_url.startsWith('icon:');

  const handleFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setError(null);
    setIsUploading(true);
    try {
      const formData = new FormData();
      formData.append('avatar', file);
      await updateProfileAvatar(formData);
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : '画像の変更に失敗しました');
    } finally {
      setIsUploading(false);
      e.target.value = '';
    }
  };

  const handlePresetSelect = async (style: string) => {
    setError(null);
    setIsSelectingPreset(style);
    try {
      await updateProfileAvatarPreset(style);
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : '選択に失敗しました');
    } finally {
      setIsSelectingPreset(null);
    }
  };

  const getPresetImageUrl = (preset: { id: string; name: string; path?: string }) => {
    if ('path' in preset && preset.path) return preset.path;
    const seed = profile.display_name || profile.clerk_user_id || 'default';
    return `https://api.dicebear.com/7.x/${preset.id}/svg?seed=${encodeURIComponent(seed)}`;
  };

  const isSelected = (presetId: string) => {
    if (hasCustomPhoto) return false;
    if (currentPreset === presetId) return true;
    if (!profile.avatar_url && presetId === 'lorelei') return true;
    return false;
  };

  return (
    <div className="space-y-6">
      <h3 className="text-sm font-bold text-stone-600 flex items-center gap-2">
        <span className="w-1 h-4 bg-orange-500 rounded-full" />
        プロフィール画像を変更
      </h3>

      <div className="flex flex-col items-center gap-4">
        <div className="relative">
          <div className="w-28 h-28 rounded-2xl overflow-hidden ring-2 ring-stone-200 shadow-lg bg-white">
            <img src={avatarUrl} alt="現在の画像" className="w-full h-full object-cover" />
          </div>
          <div className="absolute -bottom-2 -right-2 w-10 h-10 bg-orange-500 rounded-xl flex items-center justify-center shadow-lg text-white">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <path d="M14.5 4h-5L7 7H4a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-3l-2.5-3z"/>
              <circle cx="12" cy="13" r="3"/>
            </svg>
          </div>
        </div>

        <button
          type="button"
          onClick={() => fileInputRef.current?.click()}
          disabled={isUploading}
          className="w-full max-w-xs py-3 px-4 bg-orange-500 hover:bg-orange-600 text-white font-bold rounded-xl flex items-center justify-center gap-2 shadow-lg shadow-orange-200/40 disabled:opacity-70 transition"
        >
          {isUploading ? (
            <>
              <Spinner className="w-5 h-5" />
              アップロード中...
            </>
          ) : (
            <>
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                <polyline points="17 8 12 3 7 8"/>
                <line x1="12" x2="12" y1="3" y2="15"/>
              </svg>
              自分の写真をアップロード
            </>
          )}
        </button>
        <input ref={fileInputRef} type="file" accept="image/jpeg,image/png,image/webp,image/gif" onChange={handleFileChange} className="hidden" />
        <p className="text-xs text-stone-500">JPEG, PNG, WebP, GIF（5MB以下）</p>
      </div>

      <div className="flex items-center gap-3">
        <div className="flex-1 h-px bg-stone-200" />
        <span className="text-xs text-stone-400 font-medium">または</span>
        <div className="flex-1 h-px bg-stone-200" />
      </div>

      <div>
        <p className="text-sm font-bold text-stone-600 mb-3">アイコンから選ぶ</p>

        {/* ノート+鉛筆 */}
        <div className="mb-4">
          <div className="flex flex-wrap gap-2">
            {CUSTOM_ICONS.filter((c) => c.id === 'icon:notebook-pencil').map((preset) => (
              <button
                key={preset.id}
                type="button"
                onClick={() => handlePresetSelect(preset.id)}
                disabled={!!isSelectingPreset}
                className={`flex flex-col items-center gap-1 p-2 rounded-xl border-2 transition-all ${
                  isSelected(preset.id) ? 'border-orange-500 bg-orange-50 ring-2 ring-orange-200' : 'border-stone-200 hover:border-orange-300 hover:bg-orange-50/50'
                }`}
                title={preset.name}
              >
                {isSelectingPreset === preset.id ? (
                  <div className="w-12 h-12 rounded-lg bg-stone-100 flex items-center justify-center">
                    <Spinner className="w-5 h-5" />
                  </div>
                ) : (
                  <img src={preset.path} alt={preset.name} className="w-12 h-12 rounded-lg object-contain p-1" />
                )}
              </button>
            ))}
          </div>
        </div>

        {/* 5種類の花 */}
        <div>
          <p className="text-xs font-bold text-stone-500 mb-2">花（5種類・5色）</p>
          <div className="flex flex-wrap gap-2">
            {CUSTOM_ICONS.filter((c) => c.id !== 'icon:notebook-pencil').map((preset) => (
              <button
                key={preset.id}
                type="button"
                onClick={() => handlePresetSelect(preset.id)}
                disabled={!!isSelectingPreset}
                className={`flex flex-col items-center gap-1 p-2 rounded-xl border-2 transition-all ${
                  isSelected(preset.id) ? 'border-orange-500 bg-orange-50 ring-2 ring-orange-200' : 'border-stone-200 hover:border-orange-300 hover:bg-orange-50/50'
                }`}
                title={preset.name}
              >
                {isSelectingPreset === preset.id ? (
                  <div className="w-12 h-12 rounded-lg bg-stone-100 flex items-center justify-center">
                    <Spinner className="w-5 h-5" />
                  </div>
                ) : (
                  <img src={preset.path} alt={preset.name} className="w-12 h-12 rounded-lg object-contain p-1" />
                )}
                <span className="text-xs font-medium text-stone-600">{preset.name}</span>
              </button>
            ))}
          </div>
        </div>

        {/* DiceBear スタイル */}
        <div className="mt-4">
          <div className="flex flex-wrap gap-2">
            {DICEBEAR_PRESETS.map((preset) => (
              <button
                key={preset.id}
                type="button"
                onClick={() => handlePresetSelect(preset.id)}
                disabled={!!isSelectingPreset}
                className={`flex flex-col items-center gap-1 p-2 rounded-xl border-2 transition-all ${
                  isSelected(preset.id) ? 'border-orange-500 bg-orange-50 ring-2 ring-orange-200' : 'border-stone-200 hover:border-orange-300 hover:bg-orange-50/50'
                }`}
                title={preset.name}
              >
                {isSelectingPreset === preset.id ? (
                  <div className="w-12 h-12 rounded-lg bg-stone-100 flex items-center justify-center">
                    <Spinner className="w-5 h-5" />
                  </div>
                ) : (
                  <img src={getPresetImageUrl(preset)} alt={preset.name} className="w-12 h-12 rounded-lg object-cover" />
                )}
              </button>
            ))}
          </div>
        </div>
      </div>

      {error && <ErrorMessage message={error} onDismiss={() => setError(null)} />}
    </div>
  );
}
