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
      title: 'Pertemuan 5: Tahap 11',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AdaptiveNavigationPage(),
    );
  }
}

class AdaptiveNavigationPage extends StatefulWidget {
  const AdaptiveNavigationPage({super.key});

  @override
  State<AdaptiveNavigationPage> createState() => _AdaptiveNavigationPageState();
}

class _AdaptiveNavigationPageState extends State<AdaptiveNavigationPage> {
  int _selectedIndex = 0;

  final String studentId = "2415051018";
  final String studentName = "Ni Komang Mirna Asih";

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeTab(studentId: studentId, studentName: studentName),
      const CoursesTab(),
      ProfileTab(studentId: studentId, studentName: studentName),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0
            ? 'Home'
            : _selectedIndex == 1
                ? 'Courses'
                : 'Profile'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Breakpoint Expanded dimulai dari 840
          if (constraints.maxWidth >= 840) {
            // Tampilan Expanded: Menggunakan NavigationRail di sebelah kiri
            return Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.school),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(
                  child: pages[_selectedIndex],
                ),
              ],
            );
          } else {
            // Tampilan Compact / Medium: Menggunakan NavigationBar di bawah
            return Scaffold(
              body: pages[_selectedIndex],
              bottomNavigationBar: NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
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
        },
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
          const Text('Selamat datang di Adaptive Navigation App! Ukur ulang jendela emulator untuk melihat perubahan NavigationBar ke NavigationRail.'),
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