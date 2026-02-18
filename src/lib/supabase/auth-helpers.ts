import { auth, currentUser } from '@clerk/nextjs/server'
import { createServiceRoleClient } from './service-role'

export async function getSupabaseUserByClerkId() {
  const { userId } = await auth()
  if (!userId) return null

  const supabase = createServiceRoleClient()
  const { data } = await supabase
    .from('profiles')
    .select('*')
    .eq('clerk_user_id', userId)
    .maybeSingle()

  return data ?? null
}

export async function ensureSupabaseUser() {
  const { userId } = await auth()
  if (!userId) return null

  const user = await currentUser()
  if (!user) return null

  const supabase = createServiceRoleClient()
  const { data, error } = await supabase
    .from('profiles')
    .upsert(
      {
        clerk_user_id: userId,
        email: user.emailAddresses[0].emailAddress,
        display_name: `${user.firstName ?? ''} ${user.lastName ?? ''}`.trim() || 'No Name',
        // 他の必須フィールドはデフォルト値を入れるか、別途プロフィール登録画面で更新させる必要がある
        // ここでは最低限の同期を行う
        home_prefecture: '', // 仮
        home_city: '',       // 仮
        current_prefecture: '', // 仮
        current_city: '',       // 仮
      },
      { onConflict: 'clerk_user_id' }
    )
    .select()
    .single()

  if (error) {
    // 必須フィールドが足りない場合のエラーなどが考えられるが、
    // ここではエラーをログに出して、ユーザー登録フローへ誘導するのが良い
    console.error('Supabase user sync error:', error)
    // throw error // 必要に応じて投げる
  }
  return data
}
