import 'package:flutter/material.dart';

/// {@template settings_category}
/// A single settings category that has a title and holds a list
/// of children widgets.
/// {@endtemplate}
class SettingsCategory extends StatelessWidget {
  /// {@macro settings_category}
  const SettingsCategory({
    required this.children,
    super.key,
    this.title,
  });

  /// The title text widget for the category.
  final Text? title;

  /// List of child widgets in this category.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // TODO(Frank): Replace ListView with Column.
    final tileList = ListView.builder(
      shrinkWrap: true,
      itemCount: children.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) => children[index],
    );

    if (title == null) {
      return tileList;
    }

    final scaleFactor = MediaQuery.textScaleFactorOf(context);
    final titleColor = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: scaleFactor * 24.0,
            bottom: scaleFactor * 10.0,
            start: 24,
            end: 24,
          ),
          child: DefaultTextStyle(
            style: TextStyle(color: titleColor),
            child: title ?? const Text(''),
          ),
        ),
        tileList,
      ],
    );
  }
}
