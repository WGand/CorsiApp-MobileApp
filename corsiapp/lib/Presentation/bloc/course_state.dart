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

  const CourseError(this.message);

  @override
  List<Object?> get props => [message];
}

class LoadCourse extends CourseState {
  final List<Course> courses;

  const LoadCourse(this.courses);

  @override
  List<Object?> get props => [courses];
}

class CourseHasData extends CourseState {
  final List<Course> courses;

  const CourseHasData(this.courses);

  @override
  List<Object?> get props => [courses];
}
