import 'package:flutter/material.dart';

const String studentName = 'Ni Komang Mirna Asih';
const String studentId = '2415051018';

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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Flutter UI Fundamentals',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: TopicListScreen(),
        ),
      ),
    );
  }
}

class TopicListScreen extends StatelessWidget {
  const TopicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Collection Topics (Tahap 10)
    final List<Map<String, dynamic>> topics = [
      {'title': 'Git & GitHub', 'subtitle': 'Version control', 'done': true},
      {'title': 'Dart Fundamentals', 'subtitle': 'Language basics', 'done': true},
      {'title': 'Flutter UI Fundamentals', 'subtitle': 'Widgets & layout', 'done': false},
      {'title': '$studentId - $studentName', 'subtitle': 'Pemilik aplikasi', 'done': false},
    ];

    return Column(
      children: [
        // Identitas tetap tampil di atas daftar (Tahap 10)
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            '$studentId - $studentName',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
        
        // ListView.builder dengan Expanded (Tahap 10)
        Expanded(
          child: ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final item = topics[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: Icon(
                    item['done'] == true ? Icons.check_circle : Icons.circle_outlined,
                    color: item['done'] == true ? Colors.green : Colors.grey,
                  ),
                  title: Text(item['title'] as String),
                  subtitle: Text(item['subtitle'] as String),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}