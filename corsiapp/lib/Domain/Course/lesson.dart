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
    final int lessonId = int.parse(json['id']);
    final int courseId = int.parse(json['CourseId']);
    final String lessonTitle = json['title'].toString();
    return Lesson(
        courseId: courseId, lessonId: lessonId, lessonTitle: lessonTitle);
  }

  @override
  List<Object?> get props => [courseId, lessonId, lessonTitle];

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'lessonId': lessonId,
      'lessonTitle': lessonTitle,
    };
  }
}
