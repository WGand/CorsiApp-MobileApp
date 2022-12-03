import 'package:equatable/equatable.dart';
import 'package:corsiapp/Domain/Course/lesson.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.title,
    required this.urlImage,
    required this.description,
    required this.lessons,
  });

  final int id;
  final String title;
  final String urlImage;
  final String description;
  final List<Lesson> lessons;

  @override
  List<Object?> get props => [
        id,
        title,
        urlImage,
        description,
        lessons,
      ];
}
