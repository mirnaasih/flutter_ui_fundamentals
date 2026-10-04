import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pertemuan 5: Tahap 1',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Tahap1Page(),
    );
  }
}

class Tahap1Page extends StatelessWidget {
  const Tahap1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final String studentId = "2415051018";
    final String studentName = "Ni Komang Mirna Asih";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 1: Responsive Layout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Menggunakan width tetap (500):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Instruksi Tahap 1 (width tetap 500)
            Container(
              width: 500,
              padding: const EdgeInsets.all(16),
              color: Colors.red.shade100,
              child: Text('$studentId - $studentName'),
            ),
            const SizedBox(height: 24),
            const Text(
              '2. Menggunakan width responsif (double.infinity):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Perbaikan agar responsif
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.green.shade100,
              child: Text('$studentId - $studentName'),
            ),
          ],
        ),
      ),
    );
  }
}