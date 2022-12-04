import 'dart:convert';
import 'package:corsiapp/Domain/Course/course.dart';
import 'package:corsiapp/Domain/Repositories/course.dart';
import 'package:dartz/dartz.dart';
import 'package:corsiapp/Utilities/failure.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<Course>> getCoursefromAPI();
}

class RemoteDataSourceImpl implements ICourseRepository {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

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

  List<Course> parseCourse(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Course>((json) => Course.fromJson(json)).toList();
  }

  @override
  Future<Either<Failure, List<Course>>> findAllCourses() {
    throw UnimplementedError();
  }
}
