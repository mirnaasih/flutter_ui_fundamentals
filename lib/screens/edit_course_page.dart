// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class EditCoursePage extends StatefulWidget {
  final Course course;

  const EditCoursePage({super.key, required this.course});

  @override
  State<EditCoursePage> createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codeController;
  late TextEditingController _titleController;
  late TextEditingController _creditsController;
  late TextEditingController _categoryController;
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.course.code);
    _titleController = TextEditingController(text: widget.course.title);
    _creditsController = TextEditingController(text: widget.course.credits.toString());
    _categoryController = TextEditingController(text: widget.course.category);
    
    // Normalisasi status agar cocok dengan DropdownMenuItem
    final status = widget.course.status.toLowerCase();
    _selectedStatus = ['planned', 'active', 'done'].contains(status) ? status : 'planned';
  }

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _creditsController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<CourseProvider>();
    final updatedCourse = Course(
      code: _codeController.text.trim(),
      title: _titleController.text.trim(),
      credits: int.parse(_creditsController.text.trim()),
      status: _selectedStatus,
      category: _categoryController.text.trim(),
    );

    final success = await provider.updateCourse(widget.course.code, updatedCourse);

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course berhasil diperbarui!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui course: ${provider.error}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Course', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _codeController,
                readOnly: true, // Field code dibuat read-only
                decoration: const InputDecoration(
                  labelText: 'Kode Course (Read-only)',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.black12,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul Mata Kuliah', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _creditsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'SKS (Angka)', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'SKS wajib diisi';
                  if (int.tryParse(value) == null) return 'SKS harus berupa angka';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Kategori wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'planned', child: Text('Planned')),
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'done', child: Text('Done')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _selectedStatus = value);
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: provider.isSaving ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: provider.isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Simpan Perubahan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}