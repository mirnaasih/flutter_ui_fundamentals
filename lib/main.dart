// ni komang mirna asih
// 2415051018

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/login_page.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'services/auth_service.dart';
import 'services/course_supabase_service.dart'; // Import service Supabase
import 'screens/home_page.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Firebase & FCM
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  debugPrint('Permission status: ${settings.authorizationStatus}');

  final fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint('FCM Token: $fcmToken');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Foreground title: ${message.notification?.title}');
    debugPrint('Foreground body: ${message.notification?.body}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('Notification opened: ${message.data}');
  });

  // 2. Inisialisasi Supabase
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
        // Check Session: jika sudah login masuk ke HomePage, jika belum ke LoginPage
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