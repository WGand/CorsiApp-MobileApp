import 'package:corsiapp/Presentation/bloc/course_state.dart';
import 'package:corsiapp/Presentation/bloc/course_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/Course/course.dart';
import '../bloc/course_bloc.dart';
import '../pages/lesson.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CourseBloc>().add(CourseRequested());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 78, 75, 75),
      appBar: AppBar(
        title: Text(
          'Cursos',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          textAlign: TextAlign.center,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            // LinearGradient
            gradient: LinearGradient(
              // colors for gradient
              colors: [
                Color.fromARGB(255, 3, 200, 214),
                Color.fromARGB(166, 2, 204, 255),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: lista.length,
                            itemBuilder: ((context, index) {
                              return SizedBox(
                                  // ignore: unnecessary_new
                                  child: new Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                direction: Axis.horizontal,
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color.fromARGB(255, 78, 75, 75),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LessonPage(
                                                        courseId:
                                                            lista[index].id)));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.99,
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          // LinearGradient
                                          gradient: LinearGradient(
                                            // colors for gradient
                                            colors: [
                                              Color.fromARGB(255, 3, 200, 214),
                                              Color.fromARGB(166, 2, 204, 255),
                                            ],
                                          ),

                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                lista[index].urlImage,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            // ignore: prefer_const_constructors

                                            Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
                                                  child: Text(
                                                    '${lista[index].title}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          253, 255, 255, 255),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
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
}
