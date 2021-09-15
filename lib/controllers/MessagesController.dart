import 'package:flutter/material.dart';

class MessagesController {
  final TextEditingController _controller = TextEditingController();

  TextEditingController getController() {
    return _controller;
  }

  String getMessage() {
    if (_controller.text == null) return null;
    return _controller.text;
  }

  void clearField() {
    _controller.clear();
  }
}
