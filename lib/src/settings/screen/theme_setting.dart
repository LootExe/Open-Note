import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_view/settings_view.dart';

import '../../../l10n/generated/l10n.dart';
import '../../common/utils.dart';
import '../bloc/settings_bloc.dart';
import '../widget/theme_mode_dialog.dart';
import '../widget/tile_icon.dart';

class ThemeSetting extends StatelessWidget {
  const ThemeSetting({super.key});

  bool _buildWhen(SettingsState previous, SettingsState current) =>
      previous.settings.themeMode != current.settings.themeMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: _buildWhen,
      builder: (context, state) => SettingsTile(
        leading: const TileIcon(icon: Icons.light_mode_outlined),
        title: Text(S.of(context).settingsThemeButton),
        subtitle: Text(Utils.getThemeModeText(state.settings.themeMode)),
        onPressed: () => ThemeModeDialog.show(context),
      ),
    );
  }
}
