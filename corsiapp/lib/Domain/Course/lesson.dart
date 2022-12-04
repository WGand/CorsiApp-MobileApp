import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  const Lesson({
    required this.courseId,
    required this.lessonId,
    required this.lessonTitle,
  });

  final int courseId;
  final int lessonId;
  final String lessonTitle;

  factory Lesson.fromJson(Map<String, dynamic> json) {
    final int lessonId = int.parse(json['lessonId']);
    final int courseId = int.parse(json['CourseId']);
    final String lessonTitle = json['lessonTitle'].toString();
    return Lesson(
        courseId: courseId, lessonId: lessonId, lessonTitle: lessonTitle);
  }

  @override
  List<Object?> get props => [courseId, lessonId, lessonTitle];
}
