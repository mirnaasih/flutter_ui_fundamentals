// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseDetailPage extends StatelessWidget {
  final Course courseData;

  const CourseDetailPage({super.key, required this.courseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${courseData.code}'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  color: Colors.blue.shade50,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kode: ${courseData.code}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const Divider(height: 20),
                        Text('Judul: ${courseData.title}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Kategori: ${courseData.category}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Jumlah SKS: ${courseData.credits}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Status: ${courseData.status}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('Simpan & Kembali', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}