import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course(
      {required this.id,
      required this.title,
      required this.urlImage,
      required this.description});

  final int id;
  final String title;
  final String urlImage;
  final String description;

  factory Course.fromJson(Map<String, dynamic> json) {
    int idT;
    if (json['id'].runtimeType == String) {
      idT = int.parse(json['id']);
    } else {
      idT = json['id'];
    }
    final String title = json['title'].toString();
    final String urlImage = json['urlImage'].toString();
    final String description = json['description'].toString();
    return Course(
        id: idT, title: title, urlImage: urlImage, description: description);
  }

  @override
  List<Object?> get props => [id, title, urlImage, description];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'urlimage': urlImage,
      'description': description,
    };
  }
}
