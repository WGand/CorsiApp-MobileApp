import 'dart:convert';
import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<Lesson>> getLessonfromAPI();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<Lesson>> getLessonfromAPI() async {
    final response = await client.get(
        Uri.parse('https://mocki.io/v1/1e151dfa-38bd-42e2-bc4b-a048dab78a37'));

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
