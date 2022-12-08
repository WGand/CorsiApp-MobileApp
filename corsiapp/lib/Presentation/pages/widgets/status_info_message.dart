import 'package:flutter/material.dart';

class InfoMessage {
  final String message;
  InfoMessage(this.message);

  static Widget createInfoMessage(String message) {
    return Center(child: Text(message));
  }
}
