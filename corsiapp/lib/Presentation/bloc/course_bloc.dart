import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corsiapp/Application/get_lessons.dart';
import 'package:corsiapp/Presentation/bloc/course_event.dart';
import 'package:corsiapp/Presentation/bloc/course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetLessons _getCurrentCourse;

  CourseBloc(this._getCurrentCourse) : super(CourseEmpty()) {
    on<LessonsRequested>((event, emit) async {
      final courseId = event.courseId;

      emit(CourseLoading());

      final result = await _getCurrentCourse.execute(courseId);
      result.fold(
        (failure) {
          emit(CourseError(failure.message));
        },
        (data) {
          emit(CourseHasData(data));
        },
      );
    });
  }
}
