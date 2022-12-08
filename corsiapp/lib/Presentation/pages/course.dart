import 'package:corsiapp/Presentation/bloc/course_state.dart';
import 'package:corsiapp/Presentation/bloc/course_event.dart';
import 'package:corsiapp/Presentation/pages/widgets/error_messages.dart';
import 'package:corsiapp/Presentation/pages/widgets/status_info_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/Course/course.dart';
import '../bloc/course_bloc.dart';
import '../pages/lesson.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CourseBloc>().add(const CourseRequested());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 78, 75, 75),
      appBar: AppBar(
        title: const Text(
          'Cursos',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          textAlign: TextAlign.center,
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
                BlocBuilder<CourseBloc, CourseState>(
                  builder: ((context, state) {
                    switch (state.runtimeType) {
                      case CourseEmpty:
                        {
                          return InfoMessage.createInfoMessage('Vacío');
                        }
                      case CourseLoading:
                        {
                          return InfoMessage.createInfoMessage('Cargando');
                        }
                      case CourseHasData:
                        {
                          var lista = state.props.elementAt(0) as List<Course>;

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: lista.length,
                            itemBuilder: ((context, index) {
                              return SizedBox(
                                  child: Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                direction: Axis.horizontal,
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color:
                                        const Color.fromARGB(255, 78, 75, 75),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LessonPage(
                                                        course: lista[index])));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.99,
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
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  // ignore: prefer_const_constructors
                                                  return ErrorMessages
                                                      .createMessage(
                                                          'No se pudo cargar la imagen');
                                                },
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
                                                    lista[index].title,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          253, 255, 255, 255),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
                                                  child: Text(
                                                    lista[index].description,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          253, 255, 255, 255),
                                                      fontWeight:
                                                          FontWeight.w400,
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
                          return ErrorMessages.createMessage(
                              'Error cargando el curso');
                        }
                      default:
                        {
                          return ErrorMessages.createMessage('error');
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
