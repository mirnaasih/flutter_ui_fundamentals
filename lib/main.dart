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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Spacing luar (Tahap 7)
            child: Column(
              children: [
                // Menggunakan Card untuk mengelompokkan profil (Tahap 7)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Foto Profil menggunakan CircleAvatar & Asset Image (Tahap 5)
                        const CircleAvatar(
                          radius: 46,
                          backgroundImage: AssetImage('assets/images/profile.jpg'),
                        ),
                        const SizedBox(height: 12),
                        
                        // Nama Mahasiswa
                        Text(
                          studentName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        // NIM Mahasiswa
                        Text(
                          studentId,
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        
                        // Deskripsi Minat & Icon Aktivitas (Tahap 5 & Solusi Overflow Tahap 7)
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.phone_android, color: Colors.blue),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Mobile Programming Student & UI/UX Enthusiast',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Container dengan BoxDecoration untuk Statistik (Tahap 6 & 7)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Column(
                        children: [
                          Text('8', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                          Text('Widget', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('4', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                          Text('Layout', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                          Text('State', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ],
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