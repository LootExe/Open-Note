/* import 'package:flutter/material.dart';

enum _TileType { simple, switcher, navigation }

/// A single fixed-height row that typically contains some text as well as
/// a leading or trailing icon.
class SettingsTile extends StatelessWidget {
  /// Creates a settings list tile.
  ///
  /// Requires one of its ancestors to be a [Material] widget.
  const SettingsTile({
    super.key,
    this.enabled = true,
    this.leading,
    this.title,
    this.subtitle,
    this.onPressed,
  })  : _type = _TileType.simple,
        trailing = null,
        value = false,
        onChanged = null;

  /// Creates a combination of a settings tile and a switch.
  ///
  /// The switch tile itself does not maintain any state. Instead, when the
  /// state of the switch changes, the widget calls the [onChanged] callback.
  /// Most widgets that use a switch will listen for the [onChanged] callback
  /// and rebuild the switch tile with a new [value] to update the visual
  /// appearance of the switch.
  ///
  /// The following arguments are required:
  ///
  /// * [value] determines whether this switch is on or off.
  /// * [onChanged] is called when the user toggles the switch on or off.
  const SettingsTile.switchTile({
    required this.value,
    required this.onChanged,
    super.key,
    this.enabled = true,
    this.leading,
    this.title,
    this.subtitle,
  })  : _type = _TileType.switcher,
        trailing = null,
        onPressed = null;

  /// Creates a settings list tile with a navigation icon.
  ///
  /// Requires one of its ancestors to be a [Material] widget.
  const SettingsTile.navigation({
    super.key,
    this.enabled = true,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onPressed,
  })  : _type = _TileType.navigation,
        value = false,
        onChanged = null;

  final _TileType _type;

  /// Whether this list tile is interactive.
  /// If false, this list tile is styled with the disabled color from the
  /// current [Theme] and the [onPressed] and [onChanged] callbacks are
  /// inoperative.
  final bool enabled;

  /// A widget to display before the title.
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget? leading;

  /// The primary content of the list tile.
  /// Typically a [Text] widget.
  /// This should not wrap. To enforce the single line limit,
  /// use [Text.maxLines].
  final Widget? title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  ///
  /// The subtitle's default [TextStyle] depends on [TextTheme.bodyMedium]
  /// except [TextStyle.color]. The [TextStyle.color] depends on the value of
  /// [enabled].
  ///
  /// When [enabled] is false, the text color is set to
  /// [ThemeData.disabledColor].
  final Widget? subtitle;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  ///
  /// To show right-aligned metadata (assuming left-to-right reading order;
  /// left-aligned for right-to-left reading order), consider using a [Row] with
  /// [CrossAxisAlignment.baseline] alignment whose first item is [Expanded] and
  /// whose second child is the metadata text, instead of using the [trailing]
  /// property.
  final Widget? trailing;

  /// Whether this switch is checked.
  ///
  /// This property must not be null.
  final bool value;

  /// Called when the user taps this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final VoidCallback? onPressed;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch tile with the
  /// new value.
  ///
  /// If null, the switch will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// {@tool snippet}
  /// ```dart
  /// SettingsTile.switchTile(
  ///   value: _isSelected,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _isSelected = newValue;
  ///     });
  ///   },
  ///   title: const Text('Selection'),
  /// )
  /// ```
  /// {@end-tool}
  final ValueSetter<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    var subtitle = this.subtitle;

    if (enabled && subtitle != null) {
      subtitle = DefaultTextStyle.merge(
        style: TextStyle(color: Theme.of(context).hintColor),
        child: subtitle,
      );
    }

    switch (_type) {
      case _TileType.simple:
        return ListTile(
          enabled: enabled,
          leading: leading,
          title: title,
          subtitle: subtitle,
          onTap: onPressed,
        );
      case _TileType.switcher:
        return SwitchListTile(
          secondary: leading,
          title: title,
          subtitle: subtitle,
          value: value,
          onChanged: enabled ? onChanged : null,
        );
      case _TileType.navigation:
        final trailing = this.trailing ?? const Icon(Icons.open_in_new_rounded);

        return ListTile(
          enabled: enabled,
          leading: leading,
          trailing: trailing,
          title: title,
          subtitle: subtitle,
          onTap: onPressed,
        );
    }
  }
}
 */