import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:settings_provider/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_settings_provider}
/// A Flutter implementation of the SettingsProvider that uses local storage.
/// {@endtemplate}
class LocalSettingsProvider extends SettingsProvider {
  /// {@macro local_settings_provider}
  LocalSettingsProvider({required SharedPreferences plugin})
      : _plugin = plugin {
    _initialize();
  }

  /// Shared preferences key for accessing settings.
  @visibleForTesting
  static const kSettingsKey = 'sharedPreferencesSettings';

  final SharedPreferences _plugin;
  var _settings = const Settings();

  /// Read [Settings] from shared preferences.
  @override
  Future<Settings> readSettings() => Future.value(_settings);

  /// Saves [Settings] to shared preferences.
  @override
  Future<void> saveSettings(Settings settings) {
    _settings = settings.copyWith();
    return _plugin.setString(kSettingsKey, json.encode(settings));
  }

  void _initialize() {
    final jsonString = _plugin.getString(kSettingsKey);

    if (jsonString == null || jsonString.isEmpty) {
      return;
    }

    try {
      final jsonObject = json.decode(jsonString) as JsonMap;
      _settings = Settings.fromJson(jsonObject);
    } catch (e) {
      return;
    }
  }
}
