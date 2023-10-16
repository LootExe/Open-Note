import 'dart:convert';

import 'package:settings_repository/src/model/settings.dart';
import 'package:storage_provider/storage_provider.dart';

/// {@template settings_repository}
/// A repository that handles app settings
/// {@endtemplate}
class SettingsRepository {
  /// {@macro settings_repository}
  SettingsRepository({required StorageProvider provider})
      : _provider = provider;

  static const _kSettingsKey = 'settings_key';

  final StorageProvider _provider;

  /// App settings.
  /// Use `readSettings()` to read the current settings from the provider.
  /// `writeSettings()` to update the current settings and `clearSettings()`
  /// to reset to the default value.
  Settings settings = const Settings();

  /// Read the `Settings` from the storage provider.
  /// Returns a `Future` that completes once the settings have been read.
  Future<Settings> readSettings() async {
    final jsonString = await _provider.read(_kSettingsKey);

    if (jsonString == null || jsonString.isEmpty) {
      return settings = const Settings();
    }

    try {
      final jsonObject = json.decode(jsonString) as JsonMap;
      return settings = Settings.fromJson(jsonObject);
    } catch (e) {
      return settings = const Settings();
    }
  }

  /// Writes the [settings] to the storage provider.
  /// Returns a `Future` that completes once the settings have been written.
  Future<void> writeSettings(Settings settings) {
    this.settings = settings.copyWith();
    return _provider.write(_kSettingsKey, json.encode(this.settings));
  }

  /// Clears the `Settings` from the storage provider and sets the [settings]
  /// to default value.
  /// Returns a `Future` that completes once the storage has been cleared.
  Future<void> clearSettings() {
    settings = const Settings();
    return _provider.delete(_kSettingsKey);
  }
}
