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
      title: 'Pertemuan 5: Tahap 2',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MediaQueryPage(),
    );
  }
}

class MediaQueryPage extends StatelessWidget {
  const MediaQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan MediaQuery untuk membaca karakteristik layar
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    final String studentId = "2415051018";
    final String studentName = "Ni Komang Mirna Asih";

    // Kondisi sederhana berdasarkan lebar layar
    final String layoutType = size.width < 600 ? 'Compact' : 'Wide';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 2: MediaQuery Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NIM: $studentId',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Nama: $studentName',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            Text(
              'Width: ${size.width.toStringAsFixed(0)} px',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Height: ${size.height.toStringAsFixed(0)} px',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Orientation: $orientation',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              color: size.width < 600 ? Colors.orange.shade100 : Colors.purple.shade100,
              child: Text(
                'Layout Type: $layoutType',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}