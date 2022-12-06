import 'dart:convert';
import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:http/http.dart' as http;

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
      print('Busca el respositorio LECCION');
      throw Exception();
    }
  }

  List<Lesson> parseLesson(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Lesson>((json) => Lesson.fromJson(json)).toList();
  }
}
