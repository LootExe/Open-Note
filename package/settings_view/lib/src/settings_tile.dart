import 'package:flutter/material.dart';

enum _TileType { simple, switcher, navigation }

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    this.enabled = true,
    this.leading,
    this.title,
    this.subtitle,
    this.onPressed,
  })  : _type = _TileType.simple,
        trailing = null,
        value = null,
        onChanged = null;

  const SettingsTile.switchTile({
    super.key,
    this.enabled = true,
    this.leading,
    this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  })  : _type = _TileType.switcher,
        trailing = null,
        onPressed = null;

  const SettingsTile.navigation({
    super.key,
    this.enabled = true,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onPressed,
  })  : _type = _TileType.navigation,
        value = null,
        onChanged = null;

  final _TileType _type;
  final bool enabled;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool? value;
  final VoidCallback? onPressed;
  final ValueSetter<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    Widget? subtitle = this.subtitle;

    if (enabled && subtitle != null) {
      subtitle = DefaultTextStyle.merge(
          style: TextStyle(color: Theme.of(context).hintColor),
          child: subtitle);
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
          value: value ?? false,
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
