import 'package:flutter/material.dart';

class AppDesign {
  static const appBarDateTextStyle = TextStyle(fontSize: 16.0);
  static const appBarActionPadding = EdgeInsets.only(right: 6.0);
  static const mainContentPadding = EdgeInsets.only(
    left: 20.0,
    top: 20.0,
    right: 20.0,
  );

  static const emptyTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.zero,
    counterText: '',
    filled: false,
    border: InputBorder.none,
  );

  /// Zero-Width space unicode character.
  static const kZeroWidthSpace = '\u200b';

  AppDesign._();
}
