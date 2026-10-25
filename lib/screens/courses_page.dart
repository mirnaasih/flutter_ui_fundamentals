// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import 'course_detail_page.dart';
import 'add_course_page.dart';

class CoursesPage extends StatelessWidget {
  final String studentId;
  final String studentName;

  const CoursesPage({super.key, required this.studentId, required this.studentName});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'planned':
        return Colors.amber.shade700;
      case 'completed':
      case 'done':
        return Colors.green.shade600;
      case 'ongoing':
      case 'active':
        return Colors.blue.shade600;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();
    final courses = courseProvider.courses;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Identitas Mahasiswa Biru Gradasi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'IDENTITAS MAHASISWA',
                    style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    studentName,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'NIM: $studentId',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Daftar Mata Kuliah:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: courseProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : courseProvider.error != null
                      ? Center(child: Text('Error: ${courseProvider.error}'))
                      : courses.isEmpty
                          ? const Center(child: Text('Data course belum tersedia'))
                          : ListView.builder(
                              itemCount: courses.length,
                              itemBuilder: (context, index) {
                                final course = courses[index];
                                final isFav = courseProvider.isFavorite(course.code);
                                final statusColor = _getStatusColor(course.status);

                                return Card(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    title: Text(
                                      '${course.code} - ${course.title}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Row(
                                        children: [
                                          Text(
                                            'SKS: ${course.credits}',
                                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                                          ),
                                          const Text(' • ', style: TextStyle(color: Colors.grey)),
                                          Text(
                                            '${course.status.toUpperCase()}',
                                            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        isFav ? Icons.favorite : Icons.favorite_border,
                                        color: isFav ? Colors.red : Colors.grey,
                                      ),
                                      onPressed: () {
                                        courseProvider.toggleFavorite(course.code);
                                      },
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CourseDetailPage(course: course),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCoursePage()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}