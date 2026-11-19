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

/// Handler untuk kondisi BACKGROUND & TERMINATED
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('=== [BACKGROUND / TERMINATED] Notification Received ===');
  debugPrint('Background message ID : ${message.messageId}');
  debugPrint('Background title      : ${message.notification?.title}');
  debugPrint('Background body       : ${message.notification?.body}');
  debugPrint('Background data       : ${message.data}');
}

/// GlobalKey agar SnackBar muncul di layar saat notifikasi masuk di Foreground
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

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

  // KONDISI 1: FOREGROUND (aplikasi sedang terbuka di layar)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('=== [FOREGROUND] Notification Received ===');
    debugPrint('Foreground title: ${message.notification?.title}');
    debugPrint('Foreground body: ${message.notification?.body}');
    debugPrint('Foreground data: ${message.data}');

    final title = message.notification?.title ?? 'Notifikasi Baru';
    final body = message.notification?.body ?? '';

    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue.shade800,
        duration: const Duration(seconds: 4),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (body.isNotEmpty)
              Text(
                body,
                style: const TextStyle(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  });

  // KONDISI 2: BACKGROUND (notifikasi diklik saat aplikasi di latar belakang)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('=== [BACKGROUND] Notification Opened ===');
    debugPrint('Notification opened title: ${message.notification?.title}');
    debugPrint('Notification opened body: ${message.notification?.body}');
    debugPrint('Notification opened data: ${message.data}');
  });

  // KONDISI 3: TERMINATED (aplikasi dibuka dari tap notifikasi saat tertutup total)
  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    debugPrint('=== [TERMINATED] App Opened from Notification ===');
    debugPrint('Initial title: ${initialMessage.notification?.title}');
    debugPrint('Initial body: ${initialMessage.notification?.body}');
    debugPrint('Initial data: ${initialMessage.data}');
  }

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
        scaffoldMessengerKey: rootScaffoldMessengerKey,
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