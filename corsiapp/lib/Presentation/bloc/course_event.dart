import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class CourseRequested extends CourseEvent {
  const CourseRequested();

  @override
  List<Object?> get props => [];
}
