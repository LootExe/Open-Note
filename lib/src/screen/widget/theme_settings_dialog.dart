import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/settings_bloc.dart';
import '../../model/settings_data.dart';

class ThemeSettingsDialog {
  static RadioListTile<ThemeMode> _createRadioTile(
      {required String title,
      required ThemeMode value,
      required BuildContext context,
      required SettingsData settings}) {
    return RadioListTile<ThemeMode>(
      title: Text(title),
      value: value,
      onChanged: (value) {
        settings.themeMode = value ?? ThemeMode.system;
        BlocProvider.of<SettingsBloc>(context).add(SettingsChanged());
      },
      groupValue: settings.themeMode,
    );
  }

  static void show({
    required BuildContext context,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Appearance'),
        content: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createRadioTile(
                context: context,
                title: 'Always Light',
                value: ThemeMode.light,
                settings: state.settings,
              ),
              _createRadioTile(
                context: context,
                title: 'Always Dark',
                value: ThemeMode.dark,
                settings: state.settings,
              ),
              _createRadioTile(
                context: context,
                title: 'System Default',
                value: ThemeMode.system,
                settings: state.settings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
