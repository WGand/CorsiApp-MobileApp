import 'dart:io';
import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:corsiapp/Domain/Repositories/lesson.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_Lesson.dart';
import 'package:dartz/dartz.dart';
import 'package:corsiapp/Utilities/failure.dart';

import 'database.dart';
import 'exception.dart';

class LessonRepositoryImpl implements ILessonRepository {
  final RemoteDataSource remoteDataSource;

  LessonRepositoryImpl(this.remoteDataSource);

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

  @override
  Future<void> insertLesson(Lesson lesson) async {
    final db = await SQLliteDatabase().openDB();
    await db.insert('Lesson', lesson.toMap());
  }

  Future<void> jsonLessonToBd(List<Lesson> lessonList) async {
    for (var i = 0; i < lessonList.length; i++) {
      Lesson lesson = lessonList[i];
      insertLesson(lesson);
    }
  }
}
