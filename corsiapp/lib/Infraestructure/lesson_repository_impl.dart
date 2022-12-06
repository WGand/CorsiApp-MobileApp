import 'dart:io';
import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:corsiapp/Domain/Repositories/lesson.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_Lesson.dart';
import 'package:dartz/dartz.dart';
import 'package:corsiapp/Utilities/failure.dart';
import 'package:sqflite/sqflite.dart';

import 'exception.dart';

class LessonRepositoryImpl implements ILessonRepository {
  final RemoteDataSourceLesson remoteDataSource;

  LessonRepositoryImpl(this.remoteDataSource);

  Future<void> insertLesson(Lesson lesson, Database db) async {
    await db.insert('Lesson', lesson.toMap());
  }

  @override
  Future<Either<Failure, List<Lesson>>> findLessonsByCourseId(int id) async {
    try {
      final result = await remoteDataSource.getLessonfromAPI();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  Future<void> jsonLessonToBd(List<Lesson> lessonList, Database db) async {
    for (var i = 0; i < lessonList.length; i++) {
      Lesson lesson = lessonList[i];
      insertLesson(lesson, db);
    }
  }
}
