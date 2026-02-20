'use client';

export function ErrorMessage({
  message,
  onDismiss,
  className = '',
}: {
  message: string;
  onDismiss?: () => void;
  className?: string;
}) {
  return (
    <div
      role="alert"
      className={`flex items-center justify-between gap-3 px-4 py-3 rounded-xl bg-red-50 border border-red-200 text-red-800 text-sm ${className}`}
    >
      <span>{message}</span>
      {onDismiss && (
        <button
          type="button"
          onClick={onDismiss}
          className="shrink-0 text-red-600 hover:text-red-800 font-bold"
          aria-label="閉じる"
        >
          ×
        </button>
      )}
    </div>
  );
}
