import 'dart:convert';
import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:http/http.dart' as http;

import 'database.dart';

abstract class RemoteDataSource {
  Future<List<Lesson>> getLessonfromAPI();
}

class RemoteDataSourceImplLesson implements RemoteDataSource {
  final http.Client client;
  final int id;
  RemoteDataSourceImplLesson(this.id, {required this.client});

  @override
  Future<List<Lesson>> getLessonfromAPI() async {
    final response = await client.get(Uri.parse(
        'https://638d2212eafd555746b5c932.mockapi.io/CorsiApp/Courses/$id/lessons'));

    if (response.statusCode == 200) {
      return parseLesson(response.body);
    } else {
      print('Busca el respositorio LECCION');
      return getLessonsfromRepo();
    }
  }

  Future<List<Lesson>> getLessonsfromRepo() async {
    final db = await SQLliteDatabase().openDB();
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
