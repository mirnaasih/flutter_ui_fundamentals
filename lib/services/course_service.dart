// ni komang mirna asih
// 2415051018

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/course.dart';

class CourseService {
  // 1. Buat konstanta apiUrl sesuai endpoint latihan
  static const String apiUrl = 'https://course-api-pearl.vercel.app/courses';

  Future<List<Course>> loadCourses() async {
    try {
      // 2. Panggil GET melalui function asynchronous
      final response = await http.get(Uri.parse(apiUrl));

      // 3. Selalu periksa status code sebelum memproses response
      if (response.statusCode == 200) {
        final List<dynamic> list = jsonDecode(response.body) as List<dynamic>;
        
        // Tampilkan jumlah item pada debugPrint
        debugPrint('Jumlah item course berhasil dimuat: ${list.length}');

        return list
            .map((e) => Course.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Terjadi kesalahan: $e');
      // Fallback data jika gagal terhubung ke server/error
      return [
        Course(code: "MOB01", title: "Git & GitHub", credits: 2, category: "Version Control", status: "done", isFavorite: false),
        Course(code: "MOB02", title: "Dart Fundamentals", credits: 2, category: "Programming", status: "done", isFavorite: true),
        Course(code: "MOB03", title: "Flutter UI Fundamentals", credits: 3, category: "Mobile Dev", status: "active", isFavorite: false),
        Course(code: "MOB04", title: "UI/UX Prototyping", credits: 3, category: "Design", status: "pending", isFavorite: false),
      ];
    }
  }
}