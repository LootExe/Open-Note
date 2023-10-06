import 'package:settings_provider/src/model/settings.dart';

/// {@template settings_provider}
/// The interface and models for an API providing access to app settings.
/// {@endtemplate}
abstract class SettingsProvider {
  /// {@macro settings_provider}
  const SettingsProvider();

  /// Reads [Settings] from provider.
  Future<Settings> readSettings();

  /// Saves [Settings] data to provider.
  Future<void> saveSettings(Settings settings);
}
