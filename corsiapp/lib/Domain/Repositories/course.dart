import 'package:corsiapp/Domain/Course/course.dart';

abstract class ICourseRepository {
  Future<List<Course>> findAllCourses();
}
