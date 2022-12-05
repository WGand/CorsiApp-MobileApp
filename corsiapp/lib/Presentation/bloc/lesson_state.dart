import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:equatable/equatable.dart';
import '../../Domain/Course/course.dart';

abstract class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object?> get props => [];
}

class LessonLoading extends LessonState {}

class LessonEmpty extends LessonState {}

class LessonError extends LessonState {
  final String message;

  const LessonError(this.message);

  @override
  List<Object?> get props => [message];
}

class LoadCourse extends LessonState {
  final List<Course> courses;

  const LoadCourse(this.courses);

  @override
  List<Object?> get props => [courses];
}

class LessonHasData extends LessonState {
  final List<Lesson> lessons;

  const LessonHasData(this.lessons);

  @override
  List<Object?> get props => [lessons];
}
