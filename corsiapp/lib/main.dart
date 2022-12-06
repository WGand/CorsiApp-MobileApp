import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_Lesson.dart';
import 'package:corsiapp/Presentation/bloc/lesson_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:corsiapp/Domain/Course/course.dart';
import 'package:corsiapp/Utilities/injection.dart' as di;
import 'Presentation/bloc/course_bloc.dart';
import 'Presentation/pages/course.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'corsidb.db'),
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE Course(id INTEGER PRIMARY KEY, title TEXT, urlImage TEXT, description TEXT)');
      db.execute(
          'CREATE TABLE Lesson(courseId INTEGER, lessonId INTEGER PRIMARY KEY, lessonTitle TEXT, FOREIGN KEY (courseId) REFERENCES Course(id)');
    },
    version: 1,
  );
  Future<void> insertCourse(Course course) async {
    final db = await database;
    await db.insert('Course', course.toMap());
  }

  Future<void> insertLesson(Lesson lesson) async {
    final db = await database;
    await db.insert('Lesson', lesson.toMap());
  }

  Future<List<Course>> courses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Course');
    return List.generate(maps.length, (i) {
      return Course(
          id: maps[i]['id'],
          title: maps[i]['title'],
          urlImage: maps[i]['urlImage'],
          description: maps[i]['description']);
    });
  }

  Future<List<Lesson>> lessons() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Lesson');
    return List.generate(maps.length, (i) {
      return Lesson(
          courseId: maps[i]['courseId'],
          lessonId: maps[i]['lessonId'],
          lessonTitle: maps[i]['lessonTitle']);
    });
  }

  Future<void> jsonCourseToBd(List<Course> courseList) async {
    for (var i = 0; i < courseList.length; i++) {
      Course course = courseList[i];
      insertCourse(course);
    }
  }

  Future<void> jsonLessonToBd(List<Lesson> lessonList) async {
    for (var i = 0; i < lessonList.length; i++) {
      Lesson lesson = lessonList[i];
      insertLesson(lesson);
    }
  }

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
        future: RemoteDataSourceImplLesson(client: http.Client(), 1)
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
