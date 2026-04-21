import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/hive.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  // =========================
  // 📚 COURSES
  // =========================

  Future<List<Map<String, dynamic>>> getCourses({
    String? department,
    String? batch,
  }) async {
    final cacheBox = Hive.box('cacheBox');

  try {
    final res = await client
        .from('courses')
        .select()
        .eq('is_active', true);

    // Save to cache
    cacheBox.put('courses', res);

    return List<Map<String, dynamic>>.from(res);
  } catch (e) {
    // fallback to cache
    final cached = cacheBox.get('courses', defaultValue: []);
    return List<Map<String, dynamic>>.from(cached);
  }
  }

  // =========================
  // 📘 TOPICS (Lectures)
  // =========================

  Future<List<Map<String, dynamic>>> getTopics(String courseId) async {
    try {
      final res = await client
          .from('topics')
          .select()
          .eq('course_id', courseId)
          .order('order_index', ascending: true);

      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      throw Exception("Failed to load topics: $e");
    }
  }

  // =========================
  // 📑 SLIDES
  // =========================

  Future<List<Map<String, dynamic>>> getSlides(String topicId) async {
    try {
      final res = await client
          .from('slides')
          .select()
          .eq('topic_id', topicId)
          .order('order_index', ascending: true);

      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      throw Exception("Failed to load slides: $e");
    }
  }

  // =========================
  // 🎥 VIDEOS
  // =========================

  Future<List<Map<String, dynamic>>> getVideos(String topicId) async {
    try {
      final res = await client
          .from('videos')
          .select()
          .eq('topic_id', topicId)
          .order('order_index', ascending: true);

      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      throw Exception("Failed to load videos: $e");
    }
  }

  // =========================
  // 📦 STUDY TOOLS (Resources)
  // =========================

Future<List<Map<String, dynamic>>> getStudyTools({
  required String courseId,
}) async {
  final res = await client
      .from('study_tools')
      .select()
      .eq('course_id', courseId);

  return List<Map<String, dynamic>>.from(res);
}

  // =========================
  // 🔗 FULL COURSE DETAILS (JOIN)
  // =========================

  Future<List<Map<String, dynamic>>> getFullCourseData(
      String courseId) async {
    try {
      final res = await client.from('topics').select('''
        id,
        title,
        order_index,
        slides (
          id,
          title,
          google_drive_url,
          order_index
        ),
        videos (
          id,
          title,
          youtube_url,
          order_index
        )
      ''').eq('course_id', courseId);

      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      throw Exception("Failed to load full course data: $e");
    }
  }

  // =========================
  // 📊 ANALYTICS TRACKING
  // =========================

  Future<void> trackContentView({
    required String contentType,
    required String contentId,
  }) async {
    try {
      await client.from('content_analytics').insert({
        'content_type': contentType,
        'content_id': contentId,
        'action_type': 'view',
      });
    } catch (e) {
      // Silent fail (analytics should never break UX)
    }
  }

  // =========================
  // 🔍 SEARCH (Future Use)
  // =========================

  Future<List<Map<String, dynamic>>> searchCourses(String query) async {
    try {
      final res = await client
          .from('courses')
          .select()
          .ilike('title', '%$query%');

      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      throw Exception("Search failed: $e");
    }
  }
Future<List<Map<String, dynamic>>> getAllResources() async {
  final res = await client
      .from('study_tools')
      .select()
      .order('created_at', ascending: false);

  return List<Map<String, dynamic>>.from(res);
}
}