import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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
      home: const StudentDataScreen(),
    );
  }
}

class StudentDataScreen extends StatefulWidget {
  const StudentDataScreen({super.key});

  @override
  State<StudentDataScreen> createState() => _StudentDataScreenState();
}

class _StudentDataScreenState extends State<StudentDataScreen> {
  // Fungsi pembaca file JSON statik (Tahap 12)
  Future<Map<String, dynamic>> loadStudentData() async {
    final jsonString = await rootBundle.loadString('assets/data/student_data.json');
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Flutter UI Fundamentals - JSON',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadStudentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak ditemukan'));
          }

          final data = snapshot.data!;
          final student = data['student'] as Map<String, dynamic>;
          final courses = data['courses'] as List<dynamic>;

          // Menghitung jumlah kursus dengan status 'done'
          final int completed = courses.where((item) => item['status'] == 'done').length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Identitas Mahasiswa dari JSON
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/profile.jpg'),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student['name'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              student['nim'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Ringkasan Kursus Selesai
                Text(
                  '$completed dari ${courses.length} topik selesai',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),

                // Daftar List Kursus dari JSON
                Expanded(
                  child: ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index] as Map<String, dynamic>;
                      final String status = course['status'] as String;
                      final bool isDone = status == 'done';

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: Icon(
                            isDone ? Icons.check_circle : Icons.schedule,
                            color: isDone ? Colors.green : Colors.orange,
                          ),
                          title: Text(course['title'] as String),
                          subtitle: Text('Kode: ${course['code']} • SKS: ${course['credits']}'),
                          trailing: Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              color: isDone ? Colors.green : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}