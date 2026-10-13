// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';

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