import 'package:corsiapp/Domain/Course/course.dart';

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

  Course toEntity() => Course(
      id: id, title: title, urlImage: urlImage, description: description);
}
