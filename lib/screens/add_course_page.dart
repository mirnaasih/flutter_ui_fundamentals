// ni komang mirna asih
// 2415051018

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({super.key});

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _titleController = TextEditingController();
  final _creditsController = TextEditingController();
  String _status = 'planned';

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _creditsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Kode Mata Kuliah'),
                validator: (value) => value!.isEmpty ? 'Kode tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul Mata Kuliah'),
                validator: (value) => value!.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _creditsController,
                decoration: const InputDecoration(labelText: 'SKS (Angka)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'SKS tidak boleh kosong' : null,
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'planned', child: Text('Planned')),
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'done', child: Text('Done')),
                ],
                onChanged: (val) {
                  setState(() {
                    _status = val!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: provider.isSaving
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final newCourse = Course(
                            code: _codeController.text.trim(),
                            title: _titleController.text.trim(),
                            credits: int.parse(_creditsController.text.trim()),
                            status: _status,
                          );

                          final success = await provider.createCourse(newCourse);
                          if (success && mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                child: provider.isSaving
                    ? const CircularProgressIndicator()
                    : const Text('Simpan Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}