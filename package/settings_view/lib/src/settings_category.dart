import 'package:flutter/material.dart';

class SettingsCategory extends StatelessWidget {
  const SettingsCategory({
    super.key,
    this.title,
    required this.children,
  });

  final Text? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final tileList = ListView.builder(
      shrinkWrap: true,
      itemCount: children.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => children[index],
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
            start: 24.0,
            end: 24.0,
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
