import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corsiapp/Application/get_lessons.dart';
import 'package:corsiapp/Presentation/bloc/lesson_event.dart';
import 'package:corsiapp/Presentation/bloc/lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final GetLessons _getCurrentCourse;

  LessonBloc(this._getCurrentCourse) : super(LessonEmpty()) {
    on<LessonsRequested>((event, emit) async {
      final courseId = event.courseId;
      emit(LessonLoading());

      final result = await _getCurrentCourse.execute(courseId);
      result.fold(
        (failure) {
          emit(LessonError(failure.message));
        },
        (data) {
          emit(LessonHasData(data));
        },
      );
    });
  }
}
