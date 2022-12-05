import 'package:corsiapp/Application/get_lessons.dart';
import 'package:corsiapp/Presentation/bloc/lesson_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => CourseBloc(locator()));

  locator.registerLazySingleton(() => GetLessons(locator()));

  // missing repository implementation
  // locator.registerLazySingleton<ILessonRepository>(
  //   () =>
  //   )

  //missing data source impl

  //missing http client request
}
