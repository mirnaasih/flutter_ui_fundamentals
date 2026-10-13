// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';

class StudentHeader extends StatelessWidget {
  final String studentId;
  final String studentName;

  const StudentHeader({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'IDENTITAS MAHASISWA',
            style: TextStyle(color: Colors.white70, fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(studentName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
          const SizedBox(height: 2),
          Text('NIM: $studentId', style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}