// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  final String studentId;
  final String studentName;

  const HomePage({super.key, required this.studentId, required this.studentName});

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();
    final courseState = context.watch<CourseState>();

    int totalCourses = courseProvider.courses.length;
    int totalFavorites = courseProvider.courses
        .where((course) => courseState.isFavorite(course.code))
        .length;

    // Menampilkan seluruh mata kuliah
    final allCourses = courseProvider.courses;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. KARTU IDENTITAS MAHASISWA DENGAN FOTO PROFIL
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue.shade200,
                      backgroundImage: const AssetImage('assets/images/profile.jpg'),
                      onBackgroundImageError: (exception, stackTrace) {},
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          errorBuilder: (context, error, stackTrace) => Text(
                            studentName.isNotEmpty ? studentName[0] : 'M',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentName,
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'NIM: $studentId',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. KOTAK STATISTIK (Courses & Favorites)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Courses', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          const SizedBox(height: 6),
                          Text(
                            '$totalCourses',
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Favorites', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          const SizedBox(height: 6),
                          Text(
                            '$totalFavorites',
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              const Text(
                'Semua Mata Kuliah:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // 3. MENAMPILKAN SELURUH DAFTAR MATA KULIAH
              if (courseProvider.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (allCourses.isEmpty)
                const Center(child: Text('Tidak ada data mata kuliah.'))
              else
                ...allCourses.map((course) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${course.code} - ${course.title}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Status: ${course.status} • SKS: ${course.credits}',
                                style: TextStyle(
                                  color: course.status == 'done' ? Colors.green : Colors.orange,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            courseState.isFavorite(course.code) ? Icons.favorite : Icons.favorite_border,
                            color: courseState.isFavorite(course.code) ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            courseState.toggleFavorite(course.code);
                          },
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}