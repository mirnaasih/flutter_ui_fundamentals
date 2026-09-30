import 'package:flutter/material.dart';

const String studentName = 'Ni Komang Mirna Asih';
const String studentId = '2415051018';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UI Fundamentals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Flutter UI Fundamentals',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Foto Profil menggunakan CircleAvatar & Asset Image (Tahap 5)
              const CircleAvatar(
                radius: 46,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(height: 12),
              
              // Nama Mahasiswa
              Text(
                studentName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              // NIM Mahasiswa
              Text(
                studentId,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              
              // Deskripsi Minat & Icon Aktivitas (Tahap 5)
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_android, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Mobile Programming Student & UI/UX Enthusiast'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}