import 'package:corsiapp/Presentation/bloc/lesson_state.dart';
import 'package:corsiapp/Presentation/bloc/lesson_event.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/Course/lesson.dart';
import '../bloc/lesson_bloc.dart';
import '../pages/course.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LessonBloc>().add(LessonsRequested(0));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lecciones',
          style: TextStyle(color: Color.fromARGB(255, 203, 197, 204)),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => CoursePage()));
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            // LinearGradient
            gradient: LinearGradient(
              // colors for gradient
              colors: [
                Color.fromARGB(255, 82, 159, 247),
                Color.fromARGB(255, 87, 85, 214),
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
                BlocBuilder<LessonBloc, LessonState>(
                  builder: ((context, state) {
                    print(state);
                    switch (state.runtimeType) {
                      case LessonEmpty:
                        {
                          return Center(
                            child: Text('Empty'),
                          );
                        }
                      case LessonLoading:
                        {
                          return Center(
                            child: Text('Loading'),
                          );
                        }
                      case LessonHasData:
                        {
                          var lista = state.props.elementAt(0) as List<Lesson>;

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
                                    color: Color.fromARGB(255, 50, 166, 212),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          // LinearGradient
                                          gradient: LinearGradient(
                                            // colors for gradient
                                            colors: [
                                              Color.fromARGB(255, 82, 159, 247),
                                              Color.fromARGB(255, 87, 85, 214),
                                            ],
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            // ignore: prefer_const_constructors
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0, 0),
                                              child: Text(
                                                '${lista[index].lessonTitle}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
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
                      case LessonError:
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
