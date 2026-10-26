// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'services/course_api_service.dart';
import 'screens/home_page.dart';

Future<void> main() async {
  // Wajib dipanggil sebelum inisialisasi asynchronous
  WidgetsFlutterBinding.ensureInitialized();

  // Konfigurasi Supabase (Ganti dengan URL dan Anon Key project kamu)
  const supabaseUrl = 'https://vhkmszgznybztfxkckug.supabase.co';
  const supabaseAnonKey = 'sb_publishable_UynmcTbZyX1Y0t-eVTDXlQ_7cWd2LZb';

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
    const supabaseUrl = 'https://vhkmszgznybztfxkckug.supabase.co';

    // MultiProvider dengan CourseProvider, CourseRepository, dan CourseApiService yang menyertakan base URL
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CourseProvider(
            CourseRepository(
              CourseApiService(supabaseUrl),
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