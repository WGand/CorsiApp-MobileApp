import 'package:corsiapp/Presentation/bloc/course_state.dart';
import 'package:corsiapp/Presentation/bloc/lesson_bloc.dart';
import 'package:corsiapp/Presentation/bloc/course_event.dart';
import 'package:corsiapp/Presentation/bloc/lesson_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/course_bloc.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Prueba'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
              context.read<CourseBloc>().add(const CourseRequested());
              if (state is CourseHasData) {
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: const Color(0xFFF5F5F5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://picsum.photos/seed/31/600',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: const Text(
                          'Hello World',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is LessonError) {
                // ignore: prefer_const_constructors
                return Center(
                  child: const Text('Something went wrong'),
                );
              }
              return Center(
                child: const Text('Something went wrong'),
              );
            })
            // Card(
            //   clipBehavior: Clip.antiAliasWithSaveLayer,
            //   color: const Color(0xFFF5F5F5),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(10),
            //         child: Image.network(
            //           'https://picsum.photos/seed/31/600',
            //           width: 100,
            //           height: 100,
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //       // ignore: prefer_const_constructors
            //       Align(
            //         alignment: const AlignmentDirectional(0, 0),
            //         child: const Text(
            //           'Hello World',
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
