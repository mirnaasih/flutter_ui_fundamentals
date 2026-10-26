// ni komang mirna asih
// 2415051018

import '../models/course.dart';
import '../services/course_api_service.dart';

class CourseRepository {
  final CourseApiService apiService;

  CourseRepository(this.apiService);

  Future<List<Course>> getCourses() async {
    return await apiService.getCourses();
  }

  Future<Course> createCourse(Course course) async {
    return await apiService.createCourse(course);
  }
  Future<void> updateCourse(String code, Course course) async {
    return await apiService.updateCourse(code, course);
  }
  Future<void> deleteCourse(String code) async {
    return await apiService.deleteCourse(code);
  }
}