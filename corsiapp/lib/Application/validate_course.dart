import 'package:corsiapp/Domain/Course/course.dart';

class validateCourse {
  static List<Course> validatecourse(List<Course> courseList) {
    final List<Course> lista = [];
    for (Course course in courseList) {
      if (course.description.isNotEmpty &&
          course.id > 0 &&
          course.title.isNotEmpty &&
          course.urlImage.isNotEmpty) {
        lista.add(course);
      }
    }
    return lista;
  }
}
