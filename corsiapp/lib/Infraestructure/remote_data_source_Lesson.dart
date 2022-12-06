import 'dart:convert';
import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

abstract class RemoteDataSourceLesson {
  Future<List<Lesson>> getLessonfromAPI();
}

class RemoteDataSourceImplLesson implements RemoteDataSourceLesson {
  final http.Client client;
  final int id;
  final Database db;
  RemoteDataSourceImplLesson(this.id, this.db, {required this.client});

  @override
  Future<List<Lesson>> getLessonfromAPI() async {
    final response = await client.get(Uri.parse(
        'https://638d2212eafd555746b5c932.mockapi.io/CorsiApp/Courses/$id/lessons'));

    if (response.statusCode == 200) {
      return parseLesson(response.body);
    } else {
      print('Busca el respositorio LECCION');
      return getLessonFromRepo(db);
    }
  }

  Future<List<Lesson>> getLessonFromRepo(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('Lesson');
    return List.generate(maps.length, (i) {
      return Lesson(
          courseId: maps[i]['courseId'],
          lessonId: maps[i]['lessonId'],
          lessonTitle: maps[i]['lessonTitle']);
    });
  }

  List<Lesson> parseLesson(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Lesson>((json) => Lesson.fromJson(json)).toList();
  }
}
