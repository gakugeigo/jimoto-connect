/**
 * デザイン候補2: レトロ × モダン
 * PDF (Jimoto_Connect.pdf) ベースの別デザイン
 * 紙っぽい背景 #FDF8F5、温かみのあるベージュ/ブラウン、懐かしさ
 */
export default function V2Layout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="v2-theme min-h-screen bg-[#FDF8F5] text-[#3d2c1a]">
      {children}
    </div>
  );
}
