// ni komang mirna asih
// 2415051018

import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/course.dart';

class CourseService {
  Future<List<Course>> loadCourses() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/student_data.json',
      );
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      final list = data['courses'] as List<dynamic>;
      return list
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Fallback data jika file JSON gagal dimuat
      return [
        Course(code: "MOB01", title: "Git & GitHub", credits: 2, category: "Version Control", status: "done", isFavorite: false),
        Course(code: "MOB02", title: "Dart Fundamentals", credits: 2, category: "Programming", status: "done", isFavorite: true),
        Course(code: "MOB03", title: "Flutter UI Fundamentals", credits: 3, category: "Mobile Dev", status: "active", isFavorite: false),
        Course(code: "MOB04", title: "UI/UX Prototyping", credits: 3, category: "Design", status: "pending", isFavorite: false),
      ];
    }
  }
}