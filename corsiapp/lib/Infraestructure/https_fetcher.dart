import 'dart:convert';

import 'package:corsiapp/Domain/Course/course.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Course>> fetchCourse(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://638c1e60eafd555746a0b852.mockapi.io/Course'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseCourse, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Course> parseCourse(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Course>((json) => Course.fromJson(json)).toList();
}
