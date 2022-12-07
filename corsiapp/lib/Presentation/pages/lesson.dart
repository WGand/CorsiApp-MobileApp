import 'package:corsiapp/Presentation/bloc/lesson_state.dart';
import 'package:corsiapp/Presentation/bloc/lesson_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Domain/Course/lesson.dart';
import '../../Domain/Course/course.dart';
import '../bloc/lesson_bloc.dart';
import '../pages/course.dart';

class LessonPage extends StatelessWidget {
  const LessonPage(
      {super.key, /*required this.courseId,*/ required this.course});
  //final int courseId;
  final Course course;

  @override
  Widget build(BuildContext context) {
    context.read<LessonBloc>().add(LessonsRequested(course.id));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 78, 75, 75),
      appBar: AppBar(
        title: const Text(
          'Lecciones',
          style: TextStyle(color: Color.fromARGB(255, 252, 251, 252)),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const CoursePage()));
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
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
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: const Color.fromARGB(255, 78, 75, 75),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.99,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      // LinearGradient
                      gradient: const LinearGradient(
                        // colors for gradient
                        colors: [
                          Color.fromARGB(255, 3, 200, 214),
                          Color.fromARGB(166, 2, 204, 255),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            course.urlImage,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Text('No se pudo cargar la imagen');
                            },
                          ),
                        ),
                        // ignore: prefer_const_constructors

                        Column(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Text(
                                course.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(253, 255, 255, 255),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const Divider(),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Text(
                                course.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(253, 255, 255, 255),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                BlocBuilder<LessonBloc, LessonState>(
                  builder: ((context, state) {
                    switch (state.runtimeType) {
                      case LessonEmpty:
                        {
                          return const Center(
                            child: Text('Empty'),
                          );
                        }
                      case LessonLoading:
                        {
                          return const Center(
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
                                    color:
                                        const Color.fromARGB(255, 78, 75, 75),
                                    elevation: 40,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(14.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          // LinearGradient
                                          gradient: const LinearGradient(
                                            // colors for gradient
                                            colors: [
                                              Color.fromARGB(255, 3, 200, 214),
                                              Color.fromARGB(166, 2, 204, 255),
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                lista[index].lessonTitle,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            const Divider(),
                                            const Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                'description',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      253, 255, 255, 255),
                                                  fontWeight: FontWeight.w400,
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
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                      default:
                        {
                          return const Center(
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
