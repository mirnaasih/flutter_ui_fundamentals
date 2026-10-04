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
      title: 'Pertemuan 5: Tahap 5',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Tahap5Page(),
    );
  }
}

class Tahap5Page extends StatelessWidget {
  const Tahap5Page({super.key});

  // Fungsi untuk menentukan jumlah kolom berdasarkan lebar layar
  int columnsFor(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final String studentId = "2415051018";
    final String studentName = "Ni Komang Mirna Asih";

    // Contoh data course/mata kuliah
    final List<String> courses = [
      'Pemrograman Mobile',
      'UI/UX Design',
      'Jaringan Komputer',
      'Kecerdasan Buatan',
      'Manajemen Proyek',
      'Pemrograman Web'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 5: Responsive GridView'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Nama dan NIM
            Text('NIM: $studentId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Nama: $studentName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(height: 24),

            // GridView Responsif menggunakan LayoutBuilder
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = columnsFor(constraints.maxWidth);

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.blue.shade50,
                        elevation: 2,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              courses[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}