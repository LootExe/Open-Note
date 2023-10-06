import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/common/utils.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/bloc/settings_bloc.dart';
import 'package:open_note/settings/widget/widget.dart';

class ThemeSetting extends StatelessWidget {
  const ThemeSetting({super.key});

  bool _buildWhen(SettingsState previous, SettingsState current) =>
      previous.settings.themeMode != current.settings.themeMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: _buildWhen,
      builder: (context, state) => ListTile(
        leading: const TileIcon(icon: Icons.light_mode_outlined),
        title: Text(S.of(context).settingsThemeButton),
        subtitle: Text(getThemeModeText(state.settings.themeMode)),
        onTap: () => ThemeModeDialog.show(context),
      ),
    );
  }
}
