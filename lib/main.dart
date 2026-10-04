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
      title: 'Pertemuan 5: Tahap 12',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const InteractiveCoursePage(),
    );
  }
}

class InteractiveCoursePage extends StatefulWidget {
  const InteractiveCoursePage({super.key});

  @override
  State<InteractiveCoursePage> createState() => _InteractiveCoursePageState();
}

class _InteractiveCoursePageState extends State<InteractiveCoursePage> {
  final String studentId = "2415051018";
  final String studentName = "Ni Komang Mirna Asih";

  final List<Map<String, dynamic>> courses = [
    {"code": "MOB01", "title": "Git & GitHub", "credits": 2, "isFavorite": false},
    {"code": "MOB02", "title": "Dart Fundamentals", "credits": 2, "isFavorite": true},
    {"code": "MOB03", "title": "Flutter UI Fundamentals", "credits": 3, "isFavorite": false},
    {"code": "MOB04", "title": "UI/UX Prototyping", "credits": 3, "isFavorite": false},
    {"code": "MOB05", "title": "Laravel Web Development", "credits": 3, "isFavorite": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 12: User Interaction'),
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
              'Ketuk kartu untuk aksi, ikon untuk favorite, atau tahan (long press) untuk info:',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Anda memilih: ${course["title"]}')),
                        );
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(course["code"]),
                            content: Text('Informasi Lengkap:\n${course["title"]} bernilai ${course["credits"]} SKS.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Tutup'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${course["code"]} - ${course["title"]}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                const SizedBox(height: 4),
                                Text('SKS: ${course["credits"]}'),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                course["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                color: course["isFavorite"] ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  course["isFavorite"] = !course["isFavorite"];
                                });
                              },
                            ),
                          ],
                        ),
                      ),
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