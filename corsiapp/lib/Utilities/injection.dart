import 'package:corsiapp/Application/get_courses.dart';
import 'package:corsiapp/Application/get_lessons.dart';
import 'package:corsiapp/Domain/Repositories/course.dart';
import 'package:corsiapp/Domain/Repositories/lesson.dart';
import 'package:corsiapp/Infraestructure/course_repository_impl.dart';
import 'package:corsiapp/Infraestructure/lesson_repository_impl.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_course.dart';
import 'package:corsiapp/Presentation/bloc/course_bloc.dart';
import 'package:corsiapp/Presentation/bloc/lesson_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../Infraestructure/remote_data_source_lesson.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => LessonBloc(locator()));

  locator.registerFactory(() => CourseBloc(locator()));

  locator.registerLazySingleton(() => GetLessons(locator()));

  locator.registerLazySingleton(() => GetCourses(locator()));

  locator.registerLazySingleton<ICourseRepository>(
    () => CourseRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<ILessonRepository>(
    () => LessonRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<RemoteDataSourceCourses>(
      () => RemoteDataSourceImplCourse(client: locator()));

  locator.registerLazySingleton<RemoteDataSourceLessons>(
      () => RemoteDataSourceImplLesson(client: locator()));

  locator.registerLazySingleton(() => http.Client());
}
