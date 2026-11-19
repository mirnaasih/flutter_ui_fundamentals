// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/login_page.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'services/auth_service.dart';
import 'services/course_supabase_service.dart';
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
              CourseSupabaseService(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter UI Fundamentals',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: AuthService.instance.hasValidSession
            ? const HomePage(
                studentId: '2415051018',
                studentName: 'Ni Komang Mirna Asih',
              )
            : const LoginPage(),
      ),
    );
  }
}