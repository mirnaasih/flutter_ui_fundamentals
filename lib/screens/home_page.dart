// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_profile.dart';
import '../providers/course_provider.dart';
import '../widgets/error_view.dart';
import 'course_detail_page.dart';
import 'add_course_page.dart';
import 'courses_page.dart';
import 'favorites_page.dart';
import '../pages/login_page.dart';
import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  final String studentId;
  final String studentName;

  const HomePage({super.key, required this.studentId, required this.studentName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await AuthService.instance.getCurrentProfile();
    if (mounted) {
      setState(() => _userProfile = profile);
    }
  }

  String get _currentRole => (_userProfile?.role ?? 'mahasiswa').toLowerCase();

  bool get _canManageCourses => _currentRole == 'dosen' || _currentRole == 'admin';
  bool get _canAddCourse => _currentRole == 'dosen' || _currentRole == 'admin';
  bool get _canEditCourse => _currentRole == 'dosen' || _currentRole == 'admin';
  bool get _canDeleteCourse => _currentRole == 'admin';

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'planned':
        return Colors.amber.shade700;
      case 'completed':
      case 'done':
        return Colors.green.shade600;
      case 'ongoing':
      case 'active':
        return Colors.blue.shade600;
      default:
        return Colors.grey;
    }
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.deepPurple;
      case 'dosen':
        return Colors.teal;
      case 'mahasiswa':
      default:
        return Colors.blue;
    }
  }

  Future<void> _handleLogout() async {
    await AuthService.instance.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  Widget _buildDashboardBody(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();
    final courses = courseProvider.courses;
    final totalCourses = courses.length;
    final totalFavorites = courses.where((c) => courseProvider.isFavorite(c.code)).length;
    final displayName =
        (_userProfile?.name.isNotEmpty == true) ? _userProfile!.name : widget.studentName;
    final roleColor = _getRoleColor(_currentRole);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kartu Profil & Role Pengguna
          Card(
            elevation: 1,
            color: Colors.blue.shade50.withOpacity(0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "NIM: ${widget.studentId}",
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: roleColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: roleColor),
                          ),
                          child: Text(
                            'Role: ${_currentRole.toUpperCase()}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: roleColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Kotak Statistik
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Courses", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(
                          "$totalCourses",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Favorites", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(
                          "$totalFavorites",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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
          const SizedBox(height: 8),

          if (courseProvider.isLoading)
            const Center(
              child: Padding(padding: EdgeInsets.all(32.0), child: CircularProgressIndicator()),
            )
          else if (courseProvider.error != null)
            ErrorView(
              message: courseProvider.error!,
              onRetry: () => courseProvider.loadCourses(),
            )
          else if (courses.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('Data course belum tersedia', style: TextStyle(color: Colors.grey)),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                final isFav = courseProvider.isFavorite(course.code);
                final statusColor = _getStatusColor(course.status);

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      '${course.code} - ${course.title}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          Text(
                            'Status: ${course.status}',
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const Text(' • ', style: TextStyle(color: Colors.grey)),
                          Text(
                            'SKS: ${course.credits}',
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        courseProvider.toggleFavorite(course.code);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDetailPage(
                            course: course,
                            userRole: _currentRole,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildProfileBody(BuildContext context) {
    final userEmail = _userProfile?.email.isNotEmpty == true
        ? _userProfile!.email
        : (AuthService.instance.currentUser?.email ?? '-');
    final displayName =
        (_userProfile?.name.isNotEmpty == true) ? _userProfile!.name : widget.studentName;
    final roleColor = _getRoleColor(_currentRole);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const CircleAvatar(
            radius: 48,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          const SizedBox(height: 12),
          Text(
            displayName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 4),
          Text(
            'NIM: ${widget.studentId}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 8),
          Chip(
            label: Text(
              _currentRole.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: roleColor,
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text('Email Akun'),
              subtitle: Text(userEmail),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.verified_user, color: roleColor),
              title: const Text('Role Terdaftar'),
              subtitle: Text(_currentRole),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _handleLogout,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildDashboardBody(context),
      const CoursesPage(),
      const FavoritesPage(),
      _buildProfileBody(context),
    ];

    final titles = [
      'Dashboard Course',
      'Daftar Mata Kuliah',
      'Mata Kuliah Favorit',
      'Profil Pengguna',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex], style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade50,
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.blue),
                  tooltip: 'Logout',
                  onPressed: _handleLogout,
                ),
              ]
            : null,
      ),
      body: pages[_selectedIndex],
      floatingActionButton: (_selectedIndex == 0 && _canManageCourses)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddCoursePage()),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}