import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/common/utils.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/cubit/settings_cubit.dart';
import 'package:open_note/settings/widget/widget.dart';
import 'package:settings_repository/settings_repository.dart';

class ThemeSetting extends StatelessWidget {
  const ThemeSetting({super.key});

  bool _buildWhen(Settings previous, Settings current) =>
      previous.themeMode != current.themeMode ||
      previous.useMaterialYou != current.useMaterialYou;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, Settings>(
      buildWhen: _buildWhen,
      builder: (context, settings) => ListTile(
        leading: const TileIcon(icon: Icons.light_mode_outlined),
        title: Text(S.of(context).settingsThemeButton),
        subtitle: Text(getThemeModeText(settings.themeMode)),
        onTap: () => ThemeModeDialog.show(context),
      ),
    );
  }
}
