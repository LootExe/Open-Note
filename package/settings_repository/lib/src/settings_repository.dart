import 'package:settings_provider/settings_provider.dart';

/// {@template settings_repository}
/// A repository that handles settings related requests.
/// {@endtemplate}
class SettingsRepository {
  /// {@macro settings_repository}
  const SettingsRepository({
    required SettingsProvider provider,
  }) : _provider = provider;

  final SettingsProvider _provider;

  /// Reads [Settings] from the provider.
  Future<Settings> readSettings() => _provider.readSettings();

  /// Saves [Settings] data to the provider.
  Future<void> saveSettings(Settings settings) =>
      _provider.saveSettings(settings);
}
