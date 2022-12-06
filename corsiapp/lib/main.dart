import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:corsiapp/Infraestructure/database_connector.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_Lesson.dart';
import 'package:corsiapp/Presentation/bloc/lesson_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:corsiapp/Domain/Course/course.dart';
import 'package:corsiapp/Utilities/injection.dart' as di;
import 'package:sqflite_common/sqlite_api.dart';
import 'Presentation/bloc/course_bloc.dart';
import 'Presentation/pages/course.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  Database db =
      DatabaseConnection(dbcon: 'corsidb.db').MakeConnection() as Database;
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
          home: CoursePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Lesson>>(
        future: RemoteDataSourceImplLesson(client: http.Client(), 1, db)
            .getLessonfromAPI(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return LessonList(lesson: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class LessonList extends StatelessWidget {
  const LessonList({super.key, required this.lesson});

  final List<Lesson> lesson;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: lesson.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(lesson[index].lessonTitle),
        );
      },
    );
  }
}
