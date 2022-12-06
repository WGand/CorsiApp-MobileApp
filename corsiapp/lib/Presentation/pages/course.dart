import 'package:corsiapp/Presentation/bloc/course_state.dart';
import 'package:corsiapp/Presentation/bloc/course_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/Course/course.dart';
import '../bloc/course_bloc.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CourseBloc>().add(CourseRequested());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Cursos',
          style: TextStyle(color: Colors.pinkAccent),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<CourseBloc, CourseState>(
                  builder: ((context, state) {
                    print(state);
                    switch (state.runtimeType) {
                      case CourseEmpty:
                        {
                          return Center(
                            child: Text('Empty'),
                          );
                        }
                      case CourseLoading:
                        {
                          return Center(
                            child: Text('Loading'),
                          );
                        }
                      case CourseHasData:
                        {
                          var lista = state.props.elementAt(0) as List<Course>;

                          // return Center(
                          //   child: Text('asdasd'),
                          // );
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: lista.length,
                            itemBuilder: ((context, index) {
                              return SizedBox(
                                  // ignore: unnecessary_new
                                  child: new Wrap(
                                spacing: 10.0,
                                runSpacing: 10.0,
                                direction: Axis.horizontal,
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: const Color(0xFFF5F5F5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            lista[index].urlImage,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        // ignore: prefer_const_constructors
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(0, 0),
                                          child: Text('${lista[index].title}'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ));
                            }),
                          );
                        }
                      case CourseError:
                        {
                          return Center(
                            child: Text('Error'),
                          );
                        }
                      default:
                        {
                          return Center(
                            child: Text('Error 3'),
                          );
                        }
                    }
                  }),
                )
              ],
            ),
          )),
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.blue,
  //       title: const Text('Prueba'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(24.0),
  //       child: ListView(
  //         padding: EdgeInsets.zero,
  //         scrollDirection: Axis.vertical,
  //         children: [
  //           Card(
  //             clipBehavior: Clip.antiAliasWithSaveLayer,
  //             color: const Color(0xFFF5F5F5),
  //             child: Row(
  //               mainAxisSize: MainAxisSize.max,
  //               children: [
  //                 ClipRRect(
  //                   borderRadius: BorderRadius.circular(10),
  //                   child: Image.network(
  //                     'https://picsum.photos/seed/31/600',
  //                     width: 100,
  //                     height: 100,
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //                 // ignore: prefer_const_constructors
  //                 Align(
  //                   alignment: const AlignmentDirectional(0, 0),
  //                   child: const Text(
  //                     'Hello World',
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )

  // ignore: prefer_const_constructors

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
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
