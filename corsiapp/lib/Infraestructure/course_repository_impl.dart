import 'dart:io';

import 'package:corsiapp/Domain/Course/course.dart';
import 'package:corsiapp/Domain/Repositories/course.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_Course.dart';
import 'package:dartz/dartz.dart';
import 'package:corsiapp/Utilities/failure.dart';

import 'exception.dart';

class CourseRepositoryImpl implements ICourseRepository {
  final RemoteDataSource remoteDataSource;

  CourseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Course>>> findAllCourses() async {
    try {
      final result = await remoteDataSource.getCoursefromAPI();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
