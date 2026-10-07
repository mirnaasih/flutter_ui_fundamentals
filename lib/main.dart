import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CourseExplorerApp());
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

// 1. REUSABLE WIDGET: Student Identity Header
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

// 2. RESPONSIVE SHELL
class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _selectedIndex = 0;

  final String studentId = "2415051018";
  final String studentName = "Ni Komang Mirna Asih";

  List<dynamic> _courses = [];
  bool _isLoadingCourses = true;

  @override
  void initState() {
    super.initState();
    _loadCoursesFromJson();
  }

  Future<void> _loadCoursesFromJson() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/student_data.json');
      final data = jsonDecode(jsonString);
      setState(() {
        _courses = data['courses'] ?? [];
        _isLoadingCourses = false;
      });
    } catch (e) {
      // Fallback data cadangan jika file JSON belum terbaca/terdaftar
      setState(() {
        _courses = [
          {"code": "MOB01", "title": "Git & GitHub", "credits": 2, "category": "Version Control", "isFavorite": false, "status": "done"},
          {"code": "MOB02", "title": "Dart Fundamentals", "credits": 2, "category": "Programming", "isFavorite": true, "status": "done"},
          {"code": "MOB03", "title": "Flutter UI Fundamentals", "credits": 3, "category": "Mobile Dev", "isFavorite": false, "status": "active"},
          {"code": "MOB04", "title": "UI/UX Prototyping", "credits": 3, "category": "Design", "isFavorite": false, "status": "pending"},
        ];
        _isLoadingCourses = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(studentId: studentId, studentName: studentName),
      CoursesPage(courses: _courses, isLoading: _isLoadingCourses),
      FeedbackFormPage(studentId: studentId, studentName: studentName),
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
                    NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
                  ],
                ),
        );
      },
    );
  }
}

// 3. HOME PAGE
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

// 4. COURSES PAGE
class CoursesPage extends StatefulWidget {
  final List<dynamic> courses;
  final bool isLoading;

  const CoursesPage({super.key, required this.courses, required this.isLoading});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.courses.isEmpty) {
      return const Center(child: Text('Tidak ada data mata kuliah ditemukan.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth >= 840;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daftar Mata Kuliah dari JSON:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: isWide
                        ? GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 2.8,
                            ),
                            itemCount: widget.courses.length,
                            itemBuilder: (context, index) => _buildCourseCard(context, widget.courses[index]),
                          )
                        : ListView.builder(
                            itemCount: widget.courses.length,
                            itemBuilder: (context, index) => _buildCourseCard(context, widget.courses[index]),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCourseCard(BuildContext context, dynamic course) {
    String status = course["status"] ?? "pending";
    Color statusColor = status == "done"
        ? Colors.green
        : status == "active"
            ? Colors.orange
            : Colors.grey;

    bool isFavorite = course["isFavorite"] ?? false;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailPage(courseData: course),
            ),
          );

          if (result == true && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Aksi berhasil untuk mata kuliah ${course["title"]}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${course["code"]} - ${course["title"]}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text('SKS: ${course["credits"]}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(width: 8),
                        Text('• ${status.toUpperCase()}', style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    course["isFavorite"] = !isFavorite;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 5. COURSE DETAIL PAGE
class CourseDetailPage extends StatelessWidget {
  final dynamic courseData;

  const CourseDetailPage({super.key, required this.courseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${courseData["code"]}'),
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
                        Text('Kode: ${courseData["code"]}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const Divider(height: 20),
                        Text('Judul: ${courseData["title"]}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Kategori: ${courseData["category"]}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Jumlah SKS: ${courseData["credits"]}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Status: ${courseData["status"] ?? "pending"}', style: const TextStyle(fontSize: 16)),
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

// 6. PROFILE & FEEDBACK FORM PAGE
class FeedbackFormPage extends StatefulWidget {
  final String studentId;
  final String studentName;

  const FeedbackFormPage({super.key, required this.studentId, required this.studentName});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Pengiriman'),
          content: const Text('Apakah Anda yakin ingin mengirimkan feedback ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _simulateLoadingAndSubmit();
              },
              child: const Text('Ya, Kirim'),
            ),
          ],
        );
      },
    );
  }

  void _simulateLoadingAndSubmit() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data feedback berhasil disimpan!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // FOTO PROFIL DARI ASSET
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade100,
                backgroundImage: const AssetImage('assets/images/profile.jpg'),
                onBackgroundImageError: (exception, stackTrace) {},
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    errorBuilder: (context, error, stackTrace) => Text(
                      widget.studentName.isNotEmpty ? widget.studentName[0] : 'M',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.studentName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                'NIM: ${widget.studentId}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Formulir Umpan Balik (Feedback Praktikum):',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.studentName,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.trim().isEmpty) ? 'Nama wajib diisi' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: widget.studentId,
                      decoration: const InputDecoration(
                        labelText: 'NIM',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.trim().isEmpty) ? 'NIM wajib diisi' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _commentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Komentar / Umpan Balik',
                        hintText: 'Tuliskan minimal 5 karakter...',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'Komentar wajib diisi';
                        if (value.trim().length < 5) return 'Komentar minimal harus 5 karakter';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    _isLoading
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _showConfirmationDialog();
                                }
                              },
                              child: const Text('Kirim Feedback', style: TextStyle(fontSize: 16)),
                            ),
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