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
  Future<Course> createCourse(Course course) => throw UnimplementedError();

  // Mengubah parameter int menjadi String agar sesuai dengan CourseDataSource
  @override
  Future<void> updateCourse(String code, Course course) => throw UnimplementedError();

  @override
  Future<void> deleteCourse(String code) => throw UnimplementedError();
}