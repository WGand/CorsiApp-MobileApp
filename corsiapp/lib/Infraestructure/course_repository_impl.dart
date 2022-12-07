import 'dart:io';
import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'package:corsiapp/Domain/Course/course.dart';
import 'package:corsiapp/Domain/Repositories/course.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_course.dart';
import 'package:dartz/dartz.dart';
import 'package:corsiapp/Utilities/failure.dart';

import '../Utilities/exception.dart';

class CourseRepositoryImpl implements ICourseRepository {
  final RemoteDataSourceCourses remoteDataSource;

  CourseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Course>>> findAllCourses() async {
    try {
      final result = await remoteDataSource.getCoursefromAPI();
      jsonCourseToBd(result);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<void> insertCourse(Course course) async {
    final db = await SQLliteDatabase().openDB();
    await db.insert('Course', course.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> jsonCourseToBd(List<Course> courseList) async {
    for (var i = 0; i < courseList.length; i++) {
      Course course = courseList[i];
      insertCourse(course);
    }
  }
}
