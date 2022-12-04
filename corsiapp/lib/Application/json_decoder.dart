import 'dart:convert';
import 'package:corsiapp/Domain/Course/course.dart';

class JsonDecoder {
  final String response;

  JsonDecoder(this.response);

  Course decodeCourse() {
    return Course.fromJson(jsonDecode(response));
  }
}
