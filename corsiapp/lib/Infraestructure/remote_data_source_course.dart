import 'dart:convert';
import 'package:corsiapp/Application/validate_course.dart';
import 'package:corsiapp/Domain/Course/course.dart';
import 'package:corsiapp/Infraestructure/conectivity_chequer.dart';
import 'package:http/http.dart' as http;
import 'database.dart';

abstract class RemoteDataSourceCourses {
  Future<List<Course>> getCoursefromAPI();
}

class RemoteDataSourceImplCourse implements RemoteDataSourceCourses {
  final http.Client client;
  RemoteDataSourceImplCourse({required this.client});

  @override
  Future<List<Course>> getCoursefromAPI() async {
    if (await const ConectivityCheck().checkConectivity()) {
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
    return validateCourse.validatecourse(
        maps.map<Course>((json) => Course.fromJson(json)).toList());
  }

  List<Course> parseCourse(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return validateCourse.validatecourse(
        parsed.map<Course>((json) => Course.fromJson(json)).toList());
  }
}
