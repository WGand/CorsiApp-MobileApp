import 'package:dartz/dartz.dart';
import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:corsiapp/Utilities/failure.dart';

abstract class ILessonRepository {
  Future<Either<Failure, List<Lesson>>> findLessonsByCourseId(int courseId);
}
