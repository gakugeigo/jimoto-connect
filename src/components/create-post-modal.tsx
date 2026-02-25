'use client';

import { useState, useRef } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { createPost } from '@/app/actions/post';
import { ErrorMessage } from '@/components/ui/ErrorMessage';

// --- Icons ---
const Icons = {
  X: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>,
  Image: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect width="18" height="18" x="3" y="3" rx="2" ry="2"/><circle cx="9" cy="9" r="2"/><path d="m21 15-3.086-3.086a2 2 0 0 0-2.828 0L6 21"/></svg>,
  Send: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m22 2-7 20-4-9-9-4Z"/><path d="M22 2 11 13"/></svg>,
};

type Props = {
  isOpen: boolean;
  onClose: () => void;
  schoolId: string;
  schoolName: string;
  schoolType?: 'high' | 'university';
  boardType: 'all' | 'classmates' | 'club'; // 投稿先の掲示板
  suggestType?: 'event_consultation'; // イベント相談用のプレースホルダー・案内を表示
};

export function CreatePostModal({ isOpen, onClose, schoolId, schoolName, schoolType = 'high', boardType, suggestType }: Props) {
  const router = useRouter();
  const [content, setContent] = useState('');
  const [image, setImage] = useState<File | null>(null);
  const [previewUrl, setPreviewUrl] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  if (!isOpen) return null;

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setImage(file);
      setPreviewUrl(URL.createObjectURL(file));
    }
  };

  const handleSubmit = async () => {
    if (!content && !image) return;

    setError(null);
    setIsSubmitting(true);
    try {
      const formData = new FormData();
      formData.append('content', content);
      formData.append('schoolId', schoolId);
      formData.append('boardType', boardType);
      if (image) {
        formData.append('image', image);
      }

      await createPost(formData);
      
      // Reset & Close & 一覧を更新
      setContent('');
      setImage(null);
      setPreviewUrl(null);
      setError(null);
      onClose();
      router.refresh(); // Server Component の再取得をトリガー
    } catch (err) {
      console.error('Failed to post:', err);
      setError('投稿に失敗しました。');
    } finally {
      setIsSubmitting(false);
    }
  };

  const headerGradient = schoolType === 'high' 
    ? 'bg-gradient-to-r from-orange-500 to-orange-600' 
    : 'bg-gradient-to-r from-emerald-600 to-teal-600';

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
      <div className="bg-white w-full max-w-lg rounded-3xl shadow-2xl shadow-stone-300/50 overflow-hidden animate-scale-in border border-stone-200/60">
        
        {/* Header */}
        <div className={`${headerGradient} p-4 flex justify-between items-center text-white`}>
          <h3 className="font-bold flex items-center gap-2">
            <span>{suggestType === 'event_consultation' ? '📝' : '🏫'}</span>
            {suggestType === 'event_consultation' ? 'イベント企画の相談' : `${schoolName} ${boardType === 'all' ? '全体掲示板' : boardType === 'classmates' ? '同級生' : '部活OB'} へ投稿`}
          </h3>
          <button onClick={onClose} className="p-1 hover:bg-white/20 rounded-full transition">
            <Icons.X />
          </button>
        </div>

        {/* Body */}
        <div className="p-6">
          {error && (
            <ErrorMessage message={error} onDismiss={() => setError(null)} className="mb-4" />
          )}
          <textarea
            value={content}
            onChange={(e) => setContent(e.target.value)}
            placeholder={suggestType === 'event_consultation' 
              ? '例: 〇〇の同窓会やりたい！日程・場所どうする？コメントで議論してください' 
              : '懐かしい思い出や、近況を書き込んでみよう...'}
            className="w-full h-32 text-lg placeholder-stone-400 outline-none resize-none rounded-xl border border-stone-200 p-3 focus:ring-2 focus:ring-orange-200 focus:border-orange-300"
            autoFocus
          />
            {suggestType === 'event_consultation' && (
            <p className="mt-3 text-sm text-amber-700 bg-amber-50 rounded-lg px-3 py-2 border border-amber-200/60">
              💡 話がまとまったら → <Link href="/events/new" className="font-bold underline hover:text-amber-800" onClick={onClose}>イベントを作成</Link>
            </p>
          )}

          {/* Image Preview */}
          {previewUrl && (
            <div className="relative mt-4 rounded-xl overflow-hidden border border-stone-200">
              <img src={previewUrl} alt="Preview" className="w-full h-48 object-cover" />
              <button 
                onClick={() => { setImage(null); setPreviewUrl(null); }}
                className="absolute top-2 right-2 bg-black/50 text-white p-1 rounded-full hover:bg-black/70"
              >
                <Icons.X />
              </button>
            </div>
          )}

          {/* Footer Actions */}
          <div className="flex justify-between items-center mt-6 pt-4 border-t border-dashed border-stone-200">
            <div>
              <input 
                type="file" 
                ref={fileInputRef}
                onChange={handleImageChange}
                accept="image/*"
                className="hidden"
              />
              <button 
                onClick={() => fileInputRef.current?.click()}
                className="p-2 text-stone-500 hover:bg-stone-100 rounded-full transition flex items-center gap-2"
              >
                <Icons.Image />
                <span className="text-sm font-bold">写真を追加</span>
              </button>
            </div>

            <button
              onClick={handleSubmit}
              disabled={(!content && !image) || isSubmitting}
              className={`text-white px-6 py-2.5 rounded-xl font-bold shadow-lg transition disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2 ${schoolType === 'high' ? 'bg-orange-500 hover:bg-orange-600 shadow-orange-200/40' : 'bg-emerald-600 hover:bg-emerald-700 shadow-emerald-200/40'}`}
            >
              {isSubmitting ? '送信中...' : '書き込む'}
              {!isSubmitting && <Icons.Send />}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
