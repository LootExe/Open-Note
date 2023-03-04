import 'package:flutter/material.dart';
import 'package:local_settings_provider/local_settings_provider.dart';
import 'package:test/test.dart';

import 'package:settings_provider/settings_provider.dart';

void main() {
  Future setupPreferences(String key, String value) async {
    SharedPreferences.setMockInitialValues(
        <String, Object>{'flutter.$key': value});
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  setUp(() {
    setupPreferences(LocalSettingsProvider.kSettingsKey, '');
  });

  test('Initializing provider with data returns data', () async {
    setupPreferences(
        LocalSettingsProvider.kSettingsKey, '{"themeMode":"dark"}');

    final SettingsProvider provider =
        LocalSettingsProvider(plugin: await SharedPreferences.getInstance());

    final result = provider.getSettings();

    expect(result.themeMode, ThemeMode.dark);
  });

  test('Save settings data returns true', () async {
    final SettingsProvider provider =
        LocalSettingsProvider(plugin: await SharedPreferences.getInstance());

    const settings = Settings(themeMode: ThemeMode.dark);

    final result = await provider.saveSettings(settings);

    expect(result, true);
  });

  test('Saving data and loading returns the same data', () async {
    final SettingsProvider provider =
        LocalSettingsProvider(plugin: await SharedPreferences.getInstance());

    const settings = Settings(themeMode: ThemeMode.dark);

    provider.saveSettings(settings);

    SettingsProvider provider2 =
        LocalSettingsProvider(plugin: await SharedPreferences.getInstance());

    final result = provider2.getSettings();

    expect(settings, result);
  });
}
