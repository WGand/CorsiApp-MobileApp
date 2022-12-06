import 'package:corsiapp/Domain/Repositories/lesson.dart';
import 'package:dartz/dartz.dart';

import '../Domain/Course/lesson.dart';
import '../Utilities/failure.dart';

class GetLessons {
  final ILessonRepository repository;

  GetLessons(this.repository);

  Future<Either<Failure, List<Lesson>>> execute(int courseId) {
    return repository.findLessonsByCourseId(courseId);
  }
}
