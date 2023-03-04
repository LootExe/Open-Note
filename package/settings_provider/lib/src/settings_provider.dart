import 'model/settings.dart';

abstract class SettingsProvider {
  const SettingsProvider();

  /// Returns currents [Settings].
  Settings getSettings();

  /// Saves [Settings] data to disk.
  Future<bool> saveSettings(Settings settings);
}
