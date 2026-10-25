// ni komang mirna asih
// 2415051018

import '../models/course.dart';
import '../services/course_api_service.dart';

class CourseRepository {
  final CourseApiService apiService;

  CourseRepository(this.apiService);

  // Mengubah pemanggilan menjadi getCourses()
  Future<List<Course>> getCourses() async {
    return await apiService.getCourses();
  }
}