import 'package:flutter/widgets.dart';
import 'package:settings_list/src/settings_category.dart';

/// {@template settings_list}
/// A widget to manage app settings
/// {@endtemplate}
class SettingsList extends StatelessWidget {
  /// {@macro settings_list}
  const SettingsList({
    required this.children,
    super.key,
    this.padding,
  });

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  /// List of setting categories.
  final List<SettingsCategory> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO(Frank): Maybe double.infinity?
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: children.length,
        padding: padding,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}
