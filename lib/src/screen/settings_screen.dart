import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_bloc.dart';
import '../model/settings_data.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.only(left: 72.0, bottom: 16.0, top: 16.0),
                child: Text('App Theme',
                    style: Theme.of(context).textTheme.caption),
              ),
              ..._createRadioTiles(
                tiles: [
                  _ThemeTile('System Theme', ThemeMode.system),
                  _ThemeTile('Light Theme', ThemeMode.light),
                  _ThemeTile('Dark Theme', ThemeMode.dark),
                ],
                settings: state.settings,
                onChanged: () =>
                    context.read<SettingsBloc>().add(SettingsChanged()),
              ),
            ],
          );
        },
      ),
    );
  }

  List<RadioListTile> _createRadioTiles(
      {required List<_ThemeTile> tiles,
      required SettingsData settings,
      required Function onChanged}) {
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
}

class _ThemeTile {
  final String text;
  final ThemeMode mode;

  _ThemeTile(this.text, this.mode);
}
