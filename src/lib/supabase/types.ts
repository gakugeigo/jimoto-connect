export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string
          clerk_user_id: string
          email: string
          display_name: string
          avatar_url: string | null
          bio: string | null
          birth_year: number | null
          home_prefecture: string
          home_city: string
          current_prefecture: string
          current_city: string
          current_station: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          clerk_user_id: string
          email: string
          display_name: string
          avatar_url?: string | null
          bio?: string | null
          birth_year?: number | null
          home_prefecture: string
          home_city: string
          current_prefecture: string
          current_city: string
          current_station?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          clerk_user_id?: string
          email?: string
          display_name?: string
          avatar_url?: string | null
          bio?: string | null
          birth_year?: number | null
          home_prefecture?: string
          home_city?: string
          current_prefecture?: string
          current_city?: string
          current_station?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      schools: {
        Row: {
          id: string
          name: string
          type: 'junior_high' | 'high'
          prefecture: string
          city: string
          created_at: string
        }
        Insert: {
          id?: string
          name: string
          type: 'junior_high' | 'high'
          prefecture: string
          city: string
          created_at?: string
        }
        Update: {
          id?: string
          name?: string
          type?: 'junior_high' | 'high'
          prefecture?: string
          city?: string
          created_at?: string
        }
      }
      // 他のテーブル定義も必要に応じてここに追加
    }
  }
}
