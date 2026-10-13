// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/student_header.dart';
import '../main.dart'; // Import main.dart untuk mengakses CourseState
import 'course_detail_page.dart';

class CoursesPage extends StatelessWidget {
  final String studentId;     
  final String studentName;

  const CoursesPage({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();

    if (courseProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (courseProvider.error != null) {
      return Center(
        child: Text(
          'Terjadi kesalahan: ${courseProvider.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (courseProvider.courses.isEmpty) {
      return const Center(child: Text('Tidak ada data mata kuliah ditemukan.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth >= 840;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StudentHeader(
                    studentId: studentId,
                    studentName: studentName,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Daftar Mata Kuliah:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: isWide
                        ? GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 2.8,
                            ),
                            itemCount: courseProvider.courses.length,
                            itemBuilder: (context, index) => _buildCourseCard(context, courseProvider.courses[index]),
                          )
                        : ListView.builder(
                            itemCount: courseProvider.courses.length,
                            itemBuilder: (context, index) => _buildCourseCard(context, courseProvider.courses[index]),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    // Menggunakan Builder agar context baru tersedia untuk Provider
    return Builder(
      builder: (BuildContext context) {
        String status = course.status;
        Color statusColor = status == "done"
            ? Colors.green
            : status == "active"
                ? Colors.orange
                : Colors.grey;

        final courseState = context.watch<CourseState>();
        bool isFavorite = courseState.favorites.contains(course.code);

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailPage(courseData: course),
                ),
              );

              if (result == true && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Aksi berhasil untuk mata kuliah ${course.title}')),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${course.code} - ${course.title}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text('SKS: ${course.credits}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            const SizedBox(width: 8),
                            Text('• ${status.toUpperCase()}', style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      context.read<CourseState>().toggleFavorite(course.code);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}