import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  const Lesson({
    required this.lessonId,
    required this.lessonTitle,
  });

  final int lessonId;
  final String lessonTitle;

  @override
  List<Object?> get props => [
        lessonId,
        lessonTitle,
      ];

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
        lessonId: json['lessonId'] as int,
        lessonTitle: json['lessonTitle'] as String);
  }
}
