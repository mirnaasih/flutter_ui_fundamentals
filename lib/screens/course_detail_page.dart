// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import 'edit_course_page.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();
    final isFav = courseProvider.isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Colors.blue.shade50,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCoursePage(course: course),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('Kode Mata Kuliah: ${course.code}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Jumlah SKS: ${course.credits}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Status: ${course.status}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: isFav ? Colors.red.shade50 : Colors.blue.shade50,
              ),
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : Colors.blue,
              ),
              label: Text(isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit'),
              onPressed: () {
                courseProvider.toggleFavorite(course.code);
              },
            ),
          ],
        ),
      ),
    );
  }
}