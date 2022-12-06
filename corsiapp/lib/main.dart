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
  // WidgetsFlutterBinding.ensureInitialized();

  // final database = openDatabase(
  //   join(await getDatabasesPath(), 'corsidb.db'),
  //   onCreate: (db, version) {
  //     db.execute(
  //         'CREATE TABLE Course(id INTEGER PRIMARY KEY, title TEXT, urlImage TEXT, description TEXT)');
  //     db.execute(
  //         'CREATE TABLE Lesson(courseId INTEGER, lessonId INTEGER PRIMARY KEY, lessonTitle TEXT, FOREIGN KEY (courseId) REFERENCES Course(id)');
  //   },
  //   version: 1,
  // );

  // Future<void> insertCourse(Course course) async {
  //   final db = await database;

  //   await db.insert('Course', course.toMap());
  // }

  // Future<void> insertLesson(Lesson lesson) async {
  //   final db = await database;

  //   await db.insert('Lesson', lesson.toMap());
  // }

  // Future<List<Course>> courses() async {
  //   final db = await database;

  //   final List<Map<String, dynamic>> maps = await db.query('Course');

  //   return List.generate(maps.length, (i) {
  //     return Course(
  //         id: maps[i]['id'],
  //         title: maps[i]['title'],
  //         urlImage: maps[i]['urlImage'],
  //         description: maps[i]['description']);
  //   });
  // }

  // Future<List<Lesson>> lessons() async {
  //   final db = await database;

  //   final List<Map<String, dynamic>> maps = await db.query('Lesson');

  //   return List.generate(maps.length, (i) {
  //     return Lesson(
  //         courseId: maps[i]['courseId'],
  //         lessonId: maps[i]['lessonId'],
  //         lessonTitle: maps[i]['lessonTitle']);
  //   });
  // }

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
