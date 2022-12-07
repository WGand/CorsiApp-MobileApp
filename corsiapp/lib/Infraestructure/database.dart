import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLliteDatabase {
  SQLliteDatabase();

  Future<Database> openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'corsidb.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE Course(id INTEGER PRIMARY KEY, title TEXT, urlImage TEXT, description TEXT)');
        db.execute(
            'CREATE TABLE Lesson(lessonId INTEGER PRIMARY KEY, courseId INTEGER, lessonTitle TEXT, FOREIGN KEY (courseId) REFERENCES Course(id) ON UPDATE CASCADE ON DELETE CASCADE)');
      },
      version: 1,
    );
  }
}
