import 'package:flutter/material.dart';

import 'settings_category.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    required this.children,
  });

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final List<SettingsCategory> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ListView.builder(
        physics: physics,
        shrinkWrap: shrinkWrap,
        itemCount: children.length,
        padding: padding ?? EdgeInsets.zero,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}
