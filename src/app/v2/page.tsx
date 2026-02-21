import { redirect } from 'next/navigation';

// ルートがデザイン2になったため、/v2 は / へリダイレクト
export default function V2Page() {
  redirect('/');
}
