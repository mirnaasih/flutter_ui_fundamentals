// ni komang mirna asih
// 2415051018

import '../models/course.dart';

abstract class CourseDataSource {
  Future<List<Course>> getCourses();
  Future<Course> createCourse(Course course);
  Future<void> updateCourse(String code, Course course);
  Future<void> deleteCourse(String code);
}