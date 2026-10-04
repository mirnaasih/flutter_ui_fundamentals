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
      title: 'Pertemuan 5: Tahap 4',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Tahap4Page(),
    );
  }
}

class Tahap4Page extends StatelessWidget {
  const Tahap4Page({super.key});

  @override
  Widget build(BuildContext context) {
    final String studentId = "2415051018";
    final String studentName = "Ni Komang Mirna Asih";

    // Daftar skill untuk demonstrasi Wrap
    final List<String> skills = [
      'Flutter',
      'Dart',
      'Figma',
      'UI/UX Design',
      'Laravel',
      'Git'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 4: Expanded & Wrap'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identitas Mahasiswa
            Text('NIM: $studentId', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Nama: $studentName', style: const TextStyle(fontWeight: FontWeight.bold)),
            const Divider(height: 24),

            // Bagian 1: Expanded dengan Flex 2:1 dalam Row
            const Text(
              '1. Expanded (Flex 2 : 1):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 80,
                    color: Colors.blue.shade200,
                    alignment: Alignment.center,
                    child: const Text('Panel A (Flex 2)', textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 80,
                    color: Colors.green.shade200,
                    alignment: Alignment.center,
                    child: const Text('Panel B (Flex 1)', textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Bagian 2: Wrap dengan Chip
            const Text(
              '2. Wrap dengan Chip Skills:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: skills.map((skill) {
                return Chip(
                  label: Text(skill),
                  backgroundColor: Colors.purple.shade100,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}