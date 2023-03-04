import 'package:settings_provider/settings_provider.dart';

class SettingsRepository {
  final SettingsProvider _provider;

  /// The current [Settings].
  Settings get settings => _provider.getSettings();

  SettingsRepository({
    required SettingsProvider provider,
  }) : _provider = provider;

  /// Saves [Settings] data to disk.
  Future<bool> saveSettings(Settings settings) =>
      _provider.saveSettings(settings);
}
