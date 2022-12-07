import 'dart:convert';
import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:http/http.dart' as http;
import 'database.dart';

abstract class RemoteDataSourceLessons {
  Future<List<Lesson>> getLessonfromAPI(int courseId);
}

class RemoteDataSourceImplLesson implements RemoteDataSourceLessons {
  final http.Client client;
  RemoteDataSourceImplLesson({required this.client});

  @override
  Future<List<Lesson>> getLessonfromAPI(id) async {
    final response = await client.get(Uri.parse(
        'https://638d2212eafd555746b5c932.mockapi.io/CorsiApp/Courses/$id/lessons'));

    if (response.statusCode == 200) {
      return parseLesson(response.body);
    } else {
      return await getLessonsfromRepo();
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
