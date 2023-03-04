import 'package:flutter/material.dart';
import 'package:local_settings_provider/local_settings_provider.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:open_note/src/settings/bloc/settings_bloc.dart';

void main() {
  group('SettingsBloc', () {
    late SettingsBloc settingsBloc;

    setUp(() async {
      final values = <String, Object>{
        'flutter.${LocalSettingsProvider.kSettingsKey}': '{"themeMode":"dark"}'
      };

      SharedPreferences.setMockInitialValues(values);
      final provider =
          LocalSettingsProvider(plugin: await SharedPreferences.getInstance());

      settingsBloc =
          SettingsBloc(repository: SettingsRepository(provider: provider));
    });

    test('initial state is SettingsState with data from repository', () {
      expect(
          settingsBloc.state,
          const SettingsState(
            settings: Settings(themeMode: ThemeMode.dark),
          ));
    });

    blocTest(
      'emits SettingsState with changed values when SettingsChanged is added',
      build: () => settingsBloc,
      act: (bloc) {
        const newSettings = Settings(themeMode: ThemeMode.light);
        bloc.add(const SettingsUpdated(newSettings));
      },
      expect: () => [
        const SettingsState(
          settings: Settings(themeMode: ThemeMode.light),
        ),
      ],
    );
  });
}
