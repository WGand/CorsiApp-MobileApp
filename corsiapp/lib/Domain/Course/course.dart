import 'package:equatable/equatable.dart';
import 'package:corsiapp/Domain/Course/lesson.dart';

class Course extends Equatable {
  const Course(
      {required this.id,
      required this.title,
      required this.urlImage,
      required this.description});

  final int id;
  final String title;
  final String urlImage;
  final String description;

  factory Course.fromJson(Map<String, dynamic> json) {
    print('IMPRIME');
    return Course(
        id: json['id'] as int,
        title: json['title'] as String,
        urlImage: json['urlimage'] as String,
        description: json['description'] as String);
  }

  @override
  List<Object?> get props => [id, title, urlImage, description];
}
