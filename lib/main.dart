// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'services/course_api_service.dart';
import 'screens/home_page.dart'; // atau halaman utama aplikasi Anda

void main() {
  const apiBaseUrl = 'https://course-api-pearl.vercel.app';
  final repository = CourseRepository(CourseApiService(apiBaseUrl));

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(repository)..loadCourses(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Fundamentals',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(
        body: HomePage(studentId: '2415051018', studentName: 'Ni Komang Mirna Asih'),
      ),
    );
  }
}