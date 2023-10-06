import 'package:flutter/material.dart';

class AppDesign {
  AppDesign._();

  static const appBarDateTextStyle = TextStyle(fontSize: 16);
  static const appBarActionPadding = EdgeInsets.only(right: 6);
  static const mainContentPadding = EdgeInsets.only(
    left: 20,
    top: 20,
    right: 20,
  );

  static const emptyTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.zero,
    counterText: '',
    filled: false,
    border: InputBorder.none,
  );

  /// Zero-Width space unicode character.
  static const kZeroWidthSpace = '\u200b';
}
