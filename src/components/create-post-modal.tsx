'use client';

import { useState, useRef } from 'react';
import { useRouter } from 'next/navigation';
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
};

export function CreatePostModal({ isOpen, onClose, schoolId, schoolName }: Props) {
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
      router.refresh();
    } catch (err) {
      console.error('Failed to post:', err);
      setError('投稿に失敗しました。');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
      <div className="bg-white w-full max-w-lg rounded-3xl shadow-2xl overflow-hidden animate-scale-in">
        
        {/* Header */}
        <div className="bg-[#2E6B52] p-4 flex justify-between items-center text-white">
          <h3 className="font-bold flex items-center gap-2">
            <span>🏫</span> {schoolName} 掲示板
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
            placeholder="懐かしい思い出や、近況を書き込んでみよう..."
            className="w-full h-32 text-lg placeholder-stone-400 outline-none resize-none"
            autoFocus
          />

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
              className="bg-orange-600 text-white px-6 py-2.5 rounded-full font-bold shadow-md hover:bg-orange-700 transition disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
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
