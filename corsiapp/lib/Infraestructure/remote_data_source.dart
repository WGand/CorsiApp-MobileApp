import 'dart:convert';
import 'package:corsiapp/Domain/Course/course.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<Course>> getCoursefromAPI();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<Course>> getCoursefromAPI() async {
    final response = await client
        .get(Uri.parse('https://638c1e60eafd555746a0b852.mockapi.io/Course'));

    if (response.statusCode == 200) {
      return parseCourse(response.body);
    } else {
      print('Busca el respositorio');
      throw Exception();
    }
  }

  // A function that converts a response body into a List<Photo>.
  List<Course> parseCourse(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print(responseBody);
    print(parsed);
    return parsed.map<Course>((json) => Course.fromJson(json)).toList();
  }
}
