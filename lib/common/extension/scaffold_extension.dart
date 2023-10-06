import 'package:flutter/material.dart';

extension ScaffoldExtension on ScaffoldMessengerState {
  void showSnackMessage(String message) {
    hideCurrentSnackBar();
    showSnackBar(SnackBar(content: Text(message)));
  }
}
