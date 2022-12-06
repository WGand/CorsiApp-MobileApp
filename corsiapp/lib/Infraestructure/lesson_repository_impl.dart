import 'dart:io';
import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:corsiapp/Domain/Repositories/lesson.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_Lesson.dart';
import 'package:dartz/dartz.dart';
import 'package:corsiapp/Utilities/failure.dart';

import 'exception.dart';

class LessonRepositoryImpl implements ILessonRepository {
  final RemoteDataSourceLessons remoteDataSource;

  LessonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Lesson>>> findLessonsByCourseId(int id) async {
    try {
      final result = await remoteDataSource.getLessonfromAPI(id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
