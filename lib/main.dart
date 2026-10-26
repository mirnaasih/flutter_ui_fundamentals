// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'services/course_supabase_service.dart'; // Import service Supabase
import 'screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = 'https://vhkmszgznybztfxkckug.supabase.co';
  const supabaseAnonKey = 'sb_publishable_UynmcTbZYx1Y0t-eVTDXlQ_7cWd2LZb';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CourseProvider(
            CourseRepository(
              CourseSupabaseService(), // Menggunakan CourseSupabaseService
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter UI Fundamentals',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(
          studentId: '2415051018',
          studentName: 'Ni Komang Mirna Asih',
        ),
      ),
    );
  }
}