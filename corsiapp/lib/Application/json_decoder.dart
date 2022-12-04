import 'dart:convert';
import 'package:corsiapp/Domain/Course/course.dart';

class JsonDecoder {
  final String response;

  JsonDecoder(this.response);

  Future<List<Course>> parseCourse() {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

    return parsed.map<Course>((json) => Course.fromJson(json)).toList();
  }
}
