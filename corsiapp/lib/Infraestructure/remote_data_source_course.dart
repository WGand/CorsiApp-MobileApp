import 'dart:convert';
import 'package:corsiapp/Domain/Course/course.dart';
import 'package:http/http.dart' as http;
import 'database.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class RemoteDataSourceCourses {
  Future<List<Course>> getCoursefromAPI();
}

class RemoteDataSourceImplCourse implements RemoteDataSourceCourses {
  final http.Client client;
  RemoteDataSourceImplCourse({required this.client});

  @override
  Future<List<Course>> getCoursefromAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      print('Tengo INTERNET');
      final response = await client.get(Uri.parse(
          'https://638d2212eafd555746b5c932.mockapi.io/CorsiApp/Courses'));
      if (response.statusCode == 200) {
        return parseCourse(response.body);
      } else {
        return await getCoursesfromRepo();
      }
    } else {
      return await getCoursesfromRepo();
    }
  }

  Future<List<Course>> getCoursesfromRepo() async {
    final db = await SQLliteDatabase().openDB();
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
    final whatever =
        parsed.map<Course>((json) => Course.fromJson(json)).toList();
    final List<Course> lista = [];
    for (Course x in whatever) {
      if (x.description.isNotEmpty &&
          x.id > 0 &&
          x.title.isNotEmpty &&
          x.urlImage.isNotEmpty) {
        lista.add(x);
      }
    }
    return lista;
  }
}
