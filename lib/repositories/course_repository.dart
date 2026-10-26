// ni komang mirna asih
// 2415051018

import '../models/course.dart';
import '../services/course_data_source.dart';

class CourseRepository {
  CourseRepository(this.dataSource);

  final CourseDataSource dataSource;

  Future<List<Course>> getCourses() => dataSource.getCourses();

  Future<Course> createCourse(Course course) => dataSource.createCourse(course);

  Future<void> updateCourse(String code, Course course) => dataSource.updateCourse(code, course);

  Future<void> deleteCourse(String code) => dataSource.deleteCourse(code);
}