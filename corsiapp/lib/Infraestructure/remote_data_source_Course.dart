import 'dart:convert';
import 'package:corsiapp/Domain/Course/course.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

abstract class RemoteDataSourceCourse {
  Future<List<Course>> getCoursefromAPI();
}

class RemoteDataSourceImplCourse implements RemoteDataSourceCourse {
  final http.Client client;
  final Database db;
  RemoteDataSourceImplCourse(this.db, {required this.client});

  @override
  Future<List<Course>> getCoursefromAPI() async {
    final response = await client.get(Uri.parse(
        'https://638d2212eafd555746b5c932.mockapi.io/CorsiApp/Courses'));

    if (response.statusCode == 200) {
      return parseCourse(response.body);
    } else {
      print('Busca el respositorio CURSO');
      return getCourseFromRepo(db);
    }
  }

  Future<List<Course>> getCourseFromRepo(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('Course');
    return List.generate(maps.length, (i) {
      return Course(
          id: maps[i]['id'],
          title: maps[i]['title'],
          urlImage: maps[i]['urlImage'],
          description: maps[i]['description']);
    });
  }

  List<Course> parseCourse(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Course>((json) => Course.fromJson(json)).toList();
  }
}
