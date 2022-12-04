import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class LessonsRequested extends CourseEvent {
  final int courseId;

  LessonsRequested(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
