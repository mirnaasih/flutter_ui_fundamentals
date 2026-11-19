// ni komang mirna asih
// 2415051018

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course.dart';
import 'course_data_source.dart';

class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('id');

    return (data as List)
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Course> createCourse(Course course) async {
    final userId = supabase.auth.currentUser?.id;
    final payload = {
      ...course.toJson(),
      if (userId != null) 'owner_id': userId,
    };

    final row = await supabase
        .from('courses')
        .insert(payload)
        .select()
        .single();

    return Course.fromJson(row);
  }
  @override
  Future<void> updateCourse(int id, Course course) async {
    final rows = await supabase
        .from('courses')
        .update(course.toJson())
        .eq('id', id)
        .select();

    if ((rows as List).isEmpty) {
      throw Exception('ACCESS DENIED: Operasi update ditolak oleh policy database (RLS).');
    }
  }

  @override
  Future<void> deleteCourse(int id) async {
    final rows = await supabase
        .from('courses')
        .delete()
        .eq('id', id)
        .select();

    if ((rows as List).isEmpty) {
      throw Exception('ACCESS DENIED: Operasi delete ditolak oleh policy database (RLS).');
    }
  }
}