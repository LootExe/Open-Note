import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_bloc.dart';
import '../model/settings_data.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<RadioListTile> _createRadioTiles({
    required List<_ThemeTile> tiles,
    required SettingsData settings,
    required VoidCallback onChanged,
  }) {
    return tiles.map((tile) {
      return RadioListTile<ThemeMode>(
        title: Text(tile.text),
        value: tile.mode,
        groupValue: settings.themeMode,
        onChanged: (value) {
          settings.themeMode = value ?? ThemeMode.system;
          onChanged();
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                    left: 72.0,
                    bottom: 16.0,
                    top: 16.0,
                  ),
                  child: Text(
                    'App Theme',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                ..._createRadioTiles(
                  tiles: [
                    _ThemeTile(text: 'System Theme', mode: ThemeMode.system),
                    _ThemeTile(text: 'Light Theme', mode: ThemeMode.light),
                    _ThemeTile(text: 'Dark Theme', mode: ThemeMode.dark),
                  ],
                  settings: state.settings,
                  onChanged: () {
                    BlocProvider.of<SettingsBloc>(context)
                      ..add(SettingsChanged());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ThemeTile {
  const _ThemeTile({
    required this.text,
    required this.mode,
  });

  final String text;
  final ThemeMode mode;
}
