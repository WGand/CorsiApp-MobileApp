import 'dart:io';

import 'package:corsiapp/Domain/Course/course.dart';
import 'package:corsiapp/Domain/Repositories/course.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_Course.dart';
import 'package:dartz/dartz.dart';
import 'package:corsiapp/Utilities/failure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  final String dbcon;

  DatabaseConnection({required this.dbcon});

  Future<Database> MakeConnection() async {
    final database = openDatabase(
      join(await getDatabasesPath(), dbcon),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE Course(id INTEGER PRIMARY KEY, title TEXT, urlImage TEXT, description TEXT)');
        db.execute(
            'CREATE TABLE Lesson(courseId INTEGER, lessonId INTEGER PRIMARY KEY, lessonTitle TEXT, FOREIGN KEY (courseId) REFERENCES Course(id)');
      },
      version: 1,
    );
    return await database;
  }
}
