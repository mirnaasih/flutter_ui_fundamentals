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
      title: 'Pertemuan 5: Tahap 3',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LayoutBuilderPage(),
    );
  }
}

class LayoutBuilderPage extends StatelessWidget {
  const LayoutBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 3: LayoutBuilder Breakpoint'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const CompactLayout();
          } else if (constraints.maxWidth < 840) {
            return const MediumLayout();
          } else {
            return const ExpandedLayout();
          }
        },
      ),
    );
  }
}

class CompactLayout extends StatelessWidget {
  const CompactLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade100,
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NIM: 2415051018', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('Nama: Ni Komang Mirna Asih', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Layout Category: Compact (< 600)', style: TextStyle(fontSize: 18, color: Colors.red)),
          SizedBox(height: 8),
          Text('Perbedaan Visual: Tampilan satu kolom vertikal sederhana untuk ponsel.'),
        ],
      ),
    );
  }
}

class MediumLayout extends StatelessWidget {
  const MediumLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange.shade100,
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NIM: 2415051018', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Nama: Ni Komang Mirna Asih', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Layout Category: Medium (600 - 839)', style: TextStyle(fontSize: 20, color: Colors.orange)),
          SizedBox(height: 8),
          Text('Perbedaan Visual: Menggunakan elemen card dengan ruang yang sedikit lebih luas untuk tablet kecil.'),
        ],
      ),
    );
  }
}

class ExpandedLayout extends StatelessWidget {
  const ExpandedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade100,
      padding: const EdgeInsets.all(24.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NIM: 2415051018', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Nama: Ni Komang Mirna Asih', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Layout Category: Expanded (>= 840)', style: TextStyle(fontSize: 22, color: Colors.green)),
          SizedBox(height: 8),
          Text('Perbedaan Visual: Tampilan grid/multikolom yang lega khusus untuk layar desktop atau tablet besar.'),
        ],
      ),
    );
  }
}