import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/settings/bloc/settings_bloc.dart';

class ThemeModeDialog {
  static void show(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        final l10n = S.of(context);
        final settings = context.watch<SettingsBloc>().state.settings;

        void onChanged(ThemeMode? value) => context.read<SettingsBloc>().add(
              SettingsChanged(
                settings.copyWith(themeMode: value ?? ThemeMode.system),
              ),
            );

        return AlertDialog(
          title: Text(l10n.themeDialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile(
                title: Text(l10n.settingsThemeSystem),
                value: ThemeMode.system,
                groupValue: settings.themeMode,
                onChanged: onChanged,
              ),
              RadioListTile(
                title: Text(l10n.settingsThemeLight),
                value: ThemeMode.light,
                groupValue: settings.themeMode,
                onChanged: onChanged,
              ),
              RadioListTile(
                title: Text(l10n.settingsThemeDark),
                value: ThemeMode.dark,
                groupValue: settings.themeMode,
                onChanged: onChanged,
              ),
            ],
          ),
        );
      },
    );
  }
}
