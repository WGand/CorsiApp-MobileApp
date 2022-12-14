import 'dart:io';
import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:corsiapp/Domain/Repositories/lesson.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_lesson.dart';
import 'package:dartz/dartz.dart';
import 'package:corsiapp/Utilities/failure.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';
import '../Utilities/exception.dart';

class LessonRepositoryImpl implements ILessonRepository {
  final RemoteDataSourceLessons remoteDataSource;

  LessonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Lesson>>> findLessonsByCourseId(int id) async {
    try {
      final result = await remoteDataSource.getLessonfromAPI(id);
      jsonLessonToBd(result);
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
    await db.insert('Lesson', lesson.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> jsonLessonToBd(List<Lesson> lessonList) async {
    for (var i = 0; i < lessonList.length; i++) {
      Lesson lesson = lessonList[i];
      insertLesson(lesson);
    }
  }
}
