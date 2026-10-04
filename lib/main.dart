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
      title: 'Pertemuan 5: Tahap 7',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String studentId = "2415051018";
    final String studentName = "Ni Komang Mirna Asih";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 7: Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NIM: $studentId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Nama: $studentName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(height: 24),
            const Text('Ini adalah halaman utama (Home Page).'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Menggunakan Navigator.push untuk membuka DetailPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(),
                  ),
                );
              },
              child: const Text('Buka Detail'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String studentId = "2415051018";
    final String studentName = "Ni Komang Mirna Asih";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 7: Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NIM: $studentId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Nama: $studentName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(height: 24),
            const Text('Ini adalah halaman detail yang dibuka dengan Navigator.push().'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Menggunakan Navigator.pop untuk kembali
                Navigator.pop(context);
              },
              child: const Text('Kembali (pop)'),
            ),
          ],
        ),
      ),
    );
  }
}