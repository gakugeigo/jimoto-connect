/**
 * v2 ダッシュボード - レトロ×モダンデザイン
 * メインの dashboard と同じデータ・ロジックを使用
 */
import { createClient } from '@/lib/supabase/server';
import { createServiceRoleClient } from '@/lib/supabase/service-role';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import { unstable_noStore } from 'next/cache';
import { DashboardClient } from '@/components/dashboard-client';

export default async function V2DashboardPage() {
  unstable_noStore();
  const { userId } = await auth();
  if (!userId) redirect('/sign-in?redirect_url=/v2/dashboard');

  const supabase = await createClient();

  const { data: profile, error } = await supabase
    .from('profiles')
    .select(`
      *,
      profile_schools (
        school_id,
        graduation_year,
        club_activities,
        class_room,
        schools (id, name, type, prefecture, city)
      )
    `)
    .eq('clerk_user_id', userId)
    .single();

  if (error || !profile) redirect('/onboarding?redirect_url=/v2/dashboard');
  if (!profile.profile_schools?.length) redirect('/onboarding?redirect_url=/v2/dashboard');

  const schoolIds = profile.profile_schools
    .map((ps: any) => ps.school_id ?? ps.schools?.id)
    .filter(Boolean);

  const serviceSupabase = createServiceRoleClient();
  let posts: any[] = [];
  if (schoolIds.length > 0) {
    const selectCols = `id, content, image_url, school_id, created_at, profiles!author_id (id, display_name, clerk_user_id, avatar_url)`;
    let postsData: any[] | null = null;
    const result = await serviceSupabase
      .from('posts')
      .select(selectCols + ', board_type')
      .in('school_id', schoolIds)
      .order('created_at', { ascending: false })
      .limit(50);
    postsData = result.data;

    if (result.error && /board_type|column/i.test(String(result.error.message))) {
      const fallback = await serviceSupabase
        .from('posts')
        .select(selectCols)
        .in('school_id', schoolIds)
        .order('created_at', { ascending: false })
        .limit(50);
      postsData = fallback.data;
    }
    posts = postsData ?? [];
  }

  const postIds = posts.map((p: any) => p.id);
  let likesMap: Record<string, { count: number; isLiked: boolean }> = {};
  let commentsMap: Record<string, any[]> = {};

  if (postIds.length > 0) {
    const [likesRes, commentsRes] = await Promise.all([
      serviceSupabase.from('likes').select('post_id, user_id').in('post_id', postIds),
      serviceSupabase.from('comments').select(`
        id, post_id, content, created_at,
        profiles!user_id (display_name, clerk_user_id, avatar_url)
      `).in('post_id', postIds).order('created_at', { ascending: true }),
    ]);

    const likes = likesRes.data ?? [];
    postIds.forEach((pid: string) => {
      const postLikes = likes.filter((l: any) => l.post_id === pid);
      likesMap[pid] = {
        count: postLikes.length,
        isLiked: postLikes.some((l: any) => l.user_id === profile.id),
      };
    });

    const comments = commentsRes.data ?? [];
    postIds.forEach((pid: string) => {
      commentsMap[pid] = comments.filter((c: any) => c.post_id === pid);
    });
  }

  return (
    <DashboardClient
      profile={profile}
      schools={profile.profile_schools}
      posts={posts}
      likesMap={likesMap}
      commentsMap={commentsMap}
      theme="v2"
      basePath="/v2"
    />
  );
}
