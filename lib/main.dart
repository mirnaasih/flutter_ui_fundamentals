import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'services/course_service.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/home_page.dart';
import 'screens/courses_page.dart';
import 'screens/favorites_page.dart';
import 'screens/feedback_page.dart';

// Tahap 15 Selesai
// ni komang mirna asih
// 2415051018

class CourseState extends ChangeNotifier {
  final Set<String> favorites = {};

  bool isFavorite(String code) => favorites.contains(code);

  void toggleFavorite(String code) {
    favorites.contains(code)
        ? favorites.remove(code)
        : favorites.add(code);
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CourseState()),
        ChangeNotifierProvider(
          create: (_) => CourseProvider(CourseRepository(CourseService()))..loadCourses(),
        ),
      ],
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer v2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ResponsiveShell(),
    );
  }
}

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _selectedIndex = 0;

  final String studentId = "2415051018";
  final String studentName = "Ni Komang Mirna Asih";

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(studentId: studentId, studentName: studentName), // Index 0: Home
      CoursesPage(studentId: studentId, studentName: studentName), // Index 1: Courses
      const FavoritesPage(), // Index 2: Favorites
      FeedbackFormPage(studentId: studentId, studentName: studentName), // Index 3: Profile & Feedback
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isExpanded = constraints.maxWidth >= 840;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              _selectedIndex == 0
                  ? 'Course Explorer - Home'
                  : _selectedIndex == 1
                      ? 'Course Explorer - Courses'
                      : _selectedIndex == 2
                          ? 'Course Explorer - Favorites'
                          : 'Course Explorer - Profile & Feedback',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blue.shade50,
            elevation: 1,
          ),
          body: isExpanded
              ? Row(
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
                        NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('Home')),
                        NavigationRailDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: Text('Courses')),
                        NavigationRailDestination(icon: Icon(Icons.favorite_outline), selectedIcon: Icon(Icons.favorite), label: Text('Favorites')),
                        NavigationRailDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: Text('Profile')),
                      ],
                    ),
                    const VerticalDivider(width: 1, thickness: 1),
                    Expanded(child: pages[_selectedIndex]),
                  ],
                )
              : pages[_selectedIndex],
          bottomNavigationBar: isExpanded
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                    NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Courses'),
                    NavigationDestination(icon: Icon(Icons.favorite_outline), selectedIcon: Icon(Icons.favorite), label: 'Favorites'),
                    NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
                  ],
                ),
        );
      },
    );
  }
}