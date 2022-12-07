import 'package:corsiapp/Domain/Course/lesson.dart';

class validateLesson {
  static List<Lesson> validatecourse(List<Lesson> lessonList) {
    final List<Lesson> lista = [];
    for (Lesson lesson in lessonList) {
      if (lesson.lessonId > 0 &&
          lesson.courseId > 0 &&
          lesson.lessonTitle.isNotEmpty) {
        lista.add(lesson);
      }
    }
    return lista;
  }
}
