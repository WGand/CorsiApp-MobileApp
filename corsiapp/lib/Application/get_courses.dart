import 'package:corsiapp/Domain/Repositories/course.dart';
import 'package:corsiapp/Utilities/failure.dart';
import 'package:dartz/dartz.dart';

import '../Domain/Course/course.dart';

class GetCourses {
  final ICourseRepository repository;

  GetCourses(this.repository);

  Future<Either<Failure, List<Course>>> execute() {
    return repository.findAllCourses();
  }
}
