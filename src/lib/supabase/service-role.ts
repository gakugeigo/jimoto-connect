import { createClient } from '@supabase/supabase-js'

export function createServiceRoleClient() {
  // 注意: SUPABASE_SERVICE_ROLE_KEY はまだ .env.local に設定されていない可能性があります。
  // 必要に応じて Supabase Dashboard から取得して .env.local に追加してください。
  // とりあえず開発を進めるために、ない場合はエラーを投げます。
  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    console.warn('SUPABASE_SERVICE_ROLE_KEY is not set. Service role operations will fail.')
  }

  return createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY || '',
    {
      auth: {
        autoRefreshToken: false,
        persistSession: false,
      },
    }
  )
}
