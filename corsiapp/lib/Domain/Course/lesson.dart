import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  const Lesson({
    required this.lessonId,
    required this.lessonTitle,
  });

  final int lessonId;
  final String lessonTitle;

  factory Lesson.fromJson(Map<String, dynamic> json) {
    final int lessonId = int.parse(json['lessonId']);
    final String lessonTitle = json['lessonTitle'].toString();
    return Lesson(lessonId: lessonId, lessonTitle: lessonTitle);
  }

  @override
  List<Object?> get props => [
        lessonId,
        lessonTitle,
      ];
}
