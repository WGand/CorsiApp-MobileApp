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
    int idT;
    int cidT;
    if (json['id'].runtimeType == String) {
      idT = int.parse(json['id']);
    } else {
      idT = json['id'];
    }
    if (json['CourseId'].runtimeType == String) {
      cidT = int.parse(json['CourseId']);
    } else {
      cidT = json['CourseId'];
    }
    final String lessonTitle = json['title'].toString();
    return Lesson(courseId: cidT, lessonId: idT, lessonTitle: lessonTitle);
  }

  @override
  List<Object?> get props => [courseId, lessonId, lessonTitle];

  Map<String, dynamic> toMap() {
    return {
      'CourseId': courseId,
      'id': lessonId,
      'title': lessonTitle,
    };
  }
}
