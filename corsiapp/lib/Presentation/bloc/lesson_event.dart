import 'package:equatable/equatable.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object?> get props => [];
}

class LessonsRequested extends LessonEvent {
  final int courseId;

  LessonsRequested(this.courseId);

  @override
  List<Object?> get props => [courseId];
}

class CourseRequested extends LessonEvent {}
