import 'package:corsiapp/Domain/Course/course.dart';
import 'package:sqflite/sqflite.dart';
import 'course_repository_impl.dart';

class CourseModel extends Course {
  const CourseModel(
      {required super.id,
      required super.title,
      required super.urlImage,
      required super.description});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'urlImage': urlImage,
        'description': description,
      };
}
