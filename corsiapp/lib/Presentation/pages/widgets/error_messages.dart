import 'package:flutter/material.dart';

class ErrorMessages {
  final String message;

  ErrorMessages(this.message);

  static Widget createMessage(String message) {
    return Center(
        child: Text(
      message,
      textScaleFactor: 1.0,
      style: TextStyle(color: Colors.amber),
    ));
  }
}
