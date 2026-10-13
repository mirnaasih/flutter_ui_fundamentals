// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import '../widgets/student_header.dart';

class HomePage extends StatelessWidget {
  final String studentId;
  final String studentName;

  const HomePage({super.key, required this.studentId, required this.studentName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StudentHeader(studentId: studentId, studentName: studentName),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 2),
                  ],
                ),
                child: Column(
                  children: const [
                    Icon(Icons.explore, size: 64, color: Colors.blue),
                    SizedBox(height: 16),
                    Text(
                      'Selamat Datang di Course Explorer!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}