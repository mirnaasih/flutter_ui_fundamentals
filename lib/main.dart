import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pertemuan 5: Tahap 10',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final String studentId = "2415051018";
  final String studentName = "Ni Komang Mirna Asih";

  @override
  Widget build(BuildContext context) {
    // Daftar halaman/destinasi yang langsung dipanggil di dalam build
    final List<Widget> pages = [
      HomeTab(studentId: studentId, studentName: studentName),
      const CoursesTab(),
      ProfileTab(studentId: studentId, studentName: studentName),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0
            ? 'Home'
            : _currentIndex == 1
                ? 'Courses'
                : 'Profile'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// 1. Tab Home
class HomeTab extends StatelessWidget {
  final String studentId;
  final String studentName;

  const HomeTab({super.key, required this.studentId, required this.studentName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NIM: $studentId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text('Nama: $studentName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Divider(height: 24),
          const Text('Selamat datang di Aplikasi Pembelajaran Mobile! Gunakan bilah navigasi di bawah untuk berpindah menu.'),
        ],
      ),
    );
  }
}

// 2. Tab Courses
class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> courses = [
      'Git & GitHub',
      'Dart Fundamentals',
      'Flutter UI Fundamentals',
      'UI/UX Prototyping',
      'Laravel Web Development'
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: const Icon(Icons.book, color: Colors.blue),
            title: Text(courses[index]),
            subtitle: const Text('Status: Aktif / Selesai'),
          ),
        );
      },
    );
  }
}

// 3. Tab Profile
class ProfileTab extends StatelessWidget {
  final String studentId;
  final String studentName;

  const ProfileTab({super.key, required this.studentId, required this.studentName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Text('NIM: $studentId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text('Nama: $studentName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          const Text('Program Studi: Pendidikan Teknik Informatika', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          const Text('Kampus: Undiksha', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}