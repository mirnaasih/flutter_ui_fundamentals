// ni komang mirna asih
// 2415051018

import '../models/course.dart';
import '../services/course_data_source.dart';

class CourseRepository {
  final CourseDataSource dataSource;

  CourseRepository(this.dataSource);

  Future<List<Course>> getCourses() async {
    return await dataSource.getCourses();
  }

  Future<Course> createCourse(Course course) async {
    return await dataSource.createCourse(course);
  }

  // Ubah parameter dari String menjadi int id
  Future<void> updateCourse(int id, Course course) async {
    return await dataSource.updateCourse(id, course);
  }

  Future<void> deleteCourse(int id) async {
    return await dataSource.deleteCourse(id);
  }
}