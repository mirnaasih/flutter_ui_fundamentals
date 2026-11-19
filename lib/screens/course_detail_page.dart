// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import 'edit_course_page.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;
  final String userRole;

  const CourseDetailPage({
    super.key,
    required this.course,
    this.userRole = 'mahasiswa',
  });

  bool get _canEdit {
    final role = userRole.toLowerCase();
    return role == 'dosen' || role == 'admin';
  }

  bool get _canDelete {
    return userRole.toLowerCase() == 'admin';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mata Kuliah'),
        actions: [
          if (_canEdit)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditCoursePage(course: course),
                  ),
                );
              },
            ),
          if (_canDelete)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Hapus Mata Kuliah'),
                    content: const Text('Yakin ingin menghapus mata kuliah ini?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Hapus'),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  final provider = Provider.of<CourseProvider>(context, listen: false);
                  final success = await provider.deleteCourse(course.id, course.code);
                  if (!context.mounted) return;

                  if (success) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          provider.actionError ?? 'Operasi ditolak oleh policy database (RLS).',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kode: ${course.code}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Judul: ${course.title}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('SKS: ${course.credits}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Status: ${course.status}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}