import { createClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import { DashboardClient } from '@/components/dashboard-client';

export default async function DashboardPage() {
  const { userId } = await auth();
  if (!userId) {
    redirect('/sign-in');
  }

  const supabase = await createClient();

  // ユーザー情報と学校情報を取得
  const { data: profile, error } = await supabase
    .from('profiles')
    .select(`
      *,
      profile_schools (
        school_id,
        graduation_year,
        club_activities,
        class_room,
        schools (
          id,
          name,
          type,
          prefecture,
          city
        )
      )
    `)
    .eq('clerk_user_id', userId)
    .single();

  if (error || !profile) {
    redirect('/onboarding');
  }

  if (!profile.profile_schools || profile.profile_schools.length === 0) {
    redirect('/onboarding');
  }

  // ユーザーの学校ID一覧
  const schoolIds = profile.profile_schools
    .map((ps: { school_id?: string; schools?: { id: string } }) => ps.school_id ?? ps.schools?.id)
    .filter(Boolean);

  // 投稿を取得（学校掲示板用、著者情報付き）
  let posts: any[] = [];
  if (schoolIds.length > 0) {
    const { data: postsData } = await supabase
      .from('posts')
      .select(`
        id,
        content,
        image_url,
        school_id,
        created_at,
        profiles!author_id (
          id,
          display_name,
          clerk_user_id
        )
      `)
      .in('school_id', schoolIds)
      .order('created_at', { ascending: false })
      .limit(50);
    posts = postsData ?? [];
  }

  const postIds = posts.map((p: any) => p.id);

  // いいね一覧（投稿ごとの件数と、自分がいいねしたか）
  let likesMap: Record<string, { count: number; isLiked: boolean }> = {};
  if (postIds.length > 0) {
    const { data: likesData } = await supabase
      .from('likes')
      .select('post_id, user_id')
      .in('post_id', postIds);
    const likes = likesData ?? [];
    postIds.forEach((pid: string) => {
      const postLikes = likes.filter((l: any) => l.post_id === pid);
      likesMap[pid] = {
        count: postLikes.length,
        isLiked: postLikes.some((l: any) => l.user_id === profile.id),
      };
    });
  }

  // コメント一覧（著者情報付き）
  let commentsMap: Record<string, any[]> = {};
  if (postIds.length > 0) {
    const { data: commentsData } = await supabase
      .from('comments')
      .select(`
        id,
        post_id,
        content,
        created_at,
        profiles!user_id (
          display_name,
          clerk_user_id
        )
      `)
      .in('post_id', postIds)
      .order('created_at', { ascending: true });
    const comments = commentsData ?? [];
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
    />
  );
}
