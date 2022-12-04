import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:equatable/equatable.dart';

import '../../Domain/Course/course.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class CourseLoading extends CourseState {}

class CourseEmpty extends CourseState {}

class CourseError extends CourseState {
  final String message;

  CourseError(this.message);

  @override
  List<Object?> get props => [message];
}

class CourseHasData extends CourseState {
  final List<Lesson> lessons;

  CourseHasData(this.lessons);

  @override
  List<Object?> get props => [lessons];
}
