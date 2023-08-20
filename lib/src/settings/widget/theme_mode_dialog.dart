import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_repository/settings_repository.dart';

import '../../../l10n/generated/l10n.dart';
import '../../common/utils.dart';
import '../bloc/settings_bloc.dart';

class ThemeModeDialog {
  static void show(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).themeDialogTitle),
        content: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildRadioGroup(
              context: context,
              settings: state.settings,
            ),
          ),
        ),
      ),
    );
  }

  static List<Widget> _buildRadioGroup({
    required BuildContext context,
    required Settings settings,
  }) {
    void onChanged(ThemeMode? value) {
      final updatedSettings = settings.copyWith(
        themeMode: value ?? ThemeMode.system,
      );

      context.read<SettingsBloc>().add(SettingsUpdated(updatedSettings));
    }

    return ThemeMode.values
        .map(
          (mode) => RadioListTile(
            title: Text(Utils.getThemeModeText(mode)),
            groupValue: settings.themeMode,
            value: mode,
            onChanged: onChanged,
          ),
        )
        .toList(growable: false);
  }
}