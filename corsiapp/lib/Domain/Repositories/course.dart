import 'package:corsiapp/Domain/Course/course.dart';
import 'package:dartz/dartz.dart';
import 'package:corsiapp/Utilities/failure.dart';

abstract class ICourseRepository {
  Future<Either<Failure, List<Course>>> findAllCourses();
}
