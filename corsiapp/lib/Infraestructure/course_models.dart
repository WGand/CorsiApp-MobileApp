import 'package:corsiapp/Domain/Course/course.dart';

class CourseModel extends Course {
  const CourseModel(
      {required super.id,
      required super.title,
      required super.urlImage,
      required super.description,
      required super.lessons});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'urlImage': urlImage,
        'description': description,
        "lessons": []
      };

  Course toEntity() => Course(
      id: id,
      title: title,
      urlImage: urlImage,
      description: description,
      lessons: lessons);
}
