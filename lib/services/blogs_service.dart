import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jisser_app/model/blogs_model.dart';

class BlogService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Blogs>> getBlogs() async {
    try {
      final response = await _supabase
          .from('blogs')
          .select('id, title, content, color, created_at')
          .order('created_at', ascending: false);

      if (response.isEmpty) {
        return [];
      }

      return response.map<Blogs>((blog) => Blogs.fromSupabase(blog)).toList();
    } catch (e) {
      print('Error fetching blogs: $e');
      rethrow;
    }
  }

  Stream<List<Blogs>> getBlogsStream() {
    return _supabase
        .from('blogs')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data.map<Blogs>((blog) => Blogs.fromSupabase(blog)).toList());
  }
}