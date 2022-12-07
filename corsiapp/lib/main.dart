import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corsiapp/Utilities/injection.dart' as di;
import 'Presentation/bloc/course_bloc.dart';
import 'Presentation/bloc/lesson_bloc.dart';
import 'Presentation/pages/course.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// THIS IS A TEST COMMIT
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.locator<LessonBloc>()),
          BlocProvider(create: (_) => di.locator<CourseBloc>())
        ],
        child: MaterialApp(
          title: 'Cursos',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const CoursePage(),
        ));
  }
}
