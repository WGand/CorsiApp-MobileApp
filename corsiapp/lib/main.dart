import 'package:corsiapp/Domain/Course/lesson.dart';
import 'package:corsiapp/Infraestructure/remote_data_source_Lesson.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:corsiapp/Domain/Course/course.dart';

void main() async {
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

  runApp(const MyApp());
}

// THIS IS A TEST COMMIT
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //3232
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
