import 'package:corsiapp/Application/get_courses.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corsiapp/Application/get_lessons.dart';
import 'package:corsiapp/Presentation/bloc/course_event.dart';
import 'package:corsiapp/Presentation/bloc/course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCourses _getCourses;

  CourseBloc(this._getCourses) : super(CourseEmpty()) {
    on<CourseRequested>((event, emit) async {
      emit(CourseLoading());

      final result = await _getCourses.execute();
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
