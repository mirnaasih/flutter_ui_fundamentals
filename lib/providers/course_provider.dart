// ni komang mirna asih
// 2415051018

import 'package:flutter/foundation.dart';
import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  List<Course> courses = [];
  bool isLoading = false;
  bool isSaving = false;
  String? error;

  final Set<String> favorites = {};

  CourseProvider(this.repository) {
    loadCourses();
  }

  bool isFavorite(String code) => favorites.contains(code);

  void toggleFavorite(String code) {
    favorites.contains(code)
        ? favorites.remove(code)
        : favorites.add(code);
    notifyListeners();
  }

  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();
    
    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCourses() async => await loadCourses();

  Future<bool> createCourse(Course course) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      await repository.createCourse(course);
      await loadCourses();
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Menggunakan dynamic agar aman menerima int maupun String dari UI
  Future<bool> updateCourse(dynamic id, Course course) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final int parsedId = id is int ? id : int.parse(id.toString());
      await repository.updateCourse(parsedId, course);
      await loadCourses();
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<bool> deleteCourse(dynamic id, String code) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final int parsedId = id is int ? id : int.parse(id.toString());
      await repository.deleteCourse(parsedId);
      favorites.remove(code);
      await loadCourses();
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }
}