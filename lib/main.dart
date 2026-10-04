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

  // Fungsi untuk mengatur jumlah kolom grid berdasarkan lebar layar
  int columnsFor(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    // Identitas mahasiswa sesuai student_data.json
    final String studentId = "2415051018";
    final String studentName = "Ni Komang Mirna Asih";

    // Data courses disesuaikan persis dengan student_data.json
    final List<Map<String, dynamic>> courses = [
      {"code": "MOB01", "title": "Git & GitHub", "credits": 2, "status": "done"},
      {"code": "MOB02", "title": "Dart Fundamentals", "credits": 2, "status": "done"},
      {"code": "MOB03", "title": "Flutter UI Fundamentals", "credits": 3, "status": "active"},
      {"code": "MOB04", "title": "UI/UX Prototyping", "credits": 3, "status": "planned"},
      {"code": "MOB05", "title": "Laravel Web Development", "credits": 3, "status": "planned"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 5: Responsive GridView (JSON Data)'),
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

            // GridView Responsif menggunakan LayoutBuilder & Data JSON
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = columnsFor(constraints.maxWidth);

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.2,
                    ),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return Card(
                        elevation: 2,
                        color: Colors.blue.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${course["code"]} - ${course["title"]}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text('SKS: ${course["credits"]} | Status: ${course["status"]}'),
                            ],
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