import type { Metadata } from "next";
import { ClerkProvider } from "@clerk/nextjs";
import { jaJP } from "@clerk/localizations";
import "./globals.css";
import { MobileBottomNav } from "@/components/MobileBottomNav";

export const metadata: Metadata = {
  title: "Jimoto-Connect",
  description: "地元の仲間と再会しよう",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <ClerkProvider
      localization={jaJP}
      appearance={{
        variables: {
          colorPrimary: "#ea580c", // orange-600
          colorTextOnPrimaryBackground: "white",
          colorInputBackground: "white",
          colorInputText: "#1c1917", // stone-900
        },
        elements: {
          card: "shadow-xl border border-orange-100 rounded-3xl",
          headerTitle: "text-2xl font-bold text-stone-800",
          headerSubtitle: "text-stone-500",
          formButtonPrimary: "bg-orange-600 hover:bg-orange-700 text-white font-bold py-3 rounded-xl shadow-md transition-all active:scale-95",
          // 入力枠をはっきりさせる (border-stone-300, bg-stone-50)
          formFieldInput: "rounded-xl border border-stone-300 bg-stone-50 focus:bg-white focus:border-orange-500 focus:ring-2 focus:ring-orange-200 transition-all",
          footerActionLink: "text-orange-600 hover:text-orange-700 font-bold",
        },
        layout: {
          socialButtonsPlacement: "bottom", // Googleボタンを下へ
          socialButtonsVariant: "blockButton",
        }
      }}
    >
      <html lang="ja">
        <body className="pb-20 lg:pb-0">
          {children}
          <MobileBottomNav />
        </body>
      </html>
    </ClerkProvider>
  );
}
