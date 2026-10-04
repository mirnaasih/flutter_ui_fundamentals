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
      title: 'Pertemuan 5: Tahap 9',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CourseListPage(),
    );
  }
}

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  final String studentId = "2415051018";
  final String studentName = "Ni Komang Mirna Asih";

  final List<Map<String, dynamic>> courses = [
    {"code": "MOB01", "title": "Git & GitHub", "credits": 2, "status": "done", "category": "Version Control"},
    {"code": "MOB02", "title": "Dart Fundamentals", "credits": 2, "status": "done", "category": "Programming"},
    {"code": "MOB03", "title": "Flutter UI Fundamentals", "credits": 3, "status": "active", "category": "Mobile Dev"},
    {"code": "MOB04", "title": "UI/UX Prototyping", "credits": 3, "status": "planned", "category": "Design"},
    {"code": "MOB05", "title": "Laravel Web Development", "credits": 3, "status": "planned", "category": "Web Dev"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 9: Returning Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NIM: $studentId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Nama: $studentName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(height: 24),
            const Text(
              'Daftar Mata Kuliah (Pilih untuk favorit):',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        '${course["code"]} - ${course["title"]}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Status: ${course["status"]} | SKS: ${course["credits"]}'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () async {
                        final result = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailPage(course: course),
                          ),
                        );

                        if (result == true && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mata kuliah ${course["title"]} berhasil ditambahkan ke Favorit!'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
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

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final String studentId = "2415051018";
    final String studentName = "Ni Komang Mirna Asih";

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${course["code"]}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NIM: $studentId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Nama: $studentName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(height: 24),
            Card(
              elevation: 3,
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kode: ${course["code"]}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Judul: ${course["title"]}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Kategori: ${course["category"]}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Jumlah SKS (Credits): ${course["credits"]}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Status: ${course["status"]}', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Pilih / Jadikan Favorit', style: TextStyle(color: Colors.black87)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}