import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/cubit/settings_cubit.dart';
import 'package:open_note/settings/widget/widget.dart';
import 'package:settings_repository/settings_repository.dart';

class MonetSetting extends StatelessWidget {
  const MonetSetting({super.key});

  String _getMaterialColorText(bool isActive) => isActive
      ? S.current.settingMonetAndroidColor
      : S.current.settingMonetAppColor;

  void _onChanged(BuildContext context, Settings settings, bool value) {
    final changedSettings = settings.copyWith(useMaterialYou: value);
    context.read<SettingsCubit>().save(changedSettings);
  }

  bool _buildWhen(Settings previous, Settings current) =>
      previous.themeMode != current.themeMode ||
      previous.useMaterialYou != current.useMaterialYou ||
      previous.language != current.language;

  @override
  Widget build(BuildContext context) {
    const icon = TileIcon(icon: Icons.color_lens_outlined);
    const title = Text('Material You');

    return FutureBuilder(
      future: DynamicColorPlugin.getCorePalette(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return BlocBuilder<SettingsCubit, Settings>(
              buildWhen: _buildWhen,
              builder: (context, settings) => SwitchListTile(
                secondary: icon,
                title: title,
                subtitle: Text(
                  _getMaterialColorText(settings.useMaterialYou),
                ),
                value: settings.useMaterialYou,
                onChanged: (value) => _onChanged(context, settings, value),
              ),
            );
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return SwitchListTile(
              secondary: icon,
              title: title,
              subtitle: Text(_getMaterialColorText(false)),
              value: false,
              onChanged: null,
            );
        }
      },
    );
  }
}
