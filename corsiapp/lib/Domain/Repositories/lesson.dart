import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:corsiapp/Domain/Course/course.dart';

abstract class ILessonRepository {
  Future<List<Lesson>> findLessonsByCourseId(int courseId);
}
