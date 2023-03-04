import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:settings_provider/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSettingsProvider extends SettingsProvider {
  @visibleForTesting
  static const kSettingsKey = 'settingsKey';

  final SharedPreferences _plugin;
  var _settings = const Settings();

  LocalSettingsProvider({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _initialize();
  }

  @override
  Settings getSettings() => _settings;

  @override
  Future<bool> saveSettings(Settings settings) {
    _settings = settings;

    return _plugin.setString(kSettingsKey, json.encode(settings));
  }

  void _initialize() {
    final jsonString = _plugin.getString(kSettingsKey);

    if (jsonString == null || jsonString.isEmpty) {
      return;
    }

    final jsonObject = json.decode(jsonString) as JsonMap;
    _settings = Settings.fromJson(jsonObject);
  }
}
