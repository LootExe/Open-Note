import '../provider/storage_provider.dart';
import '../model/settings_data.dart';

class SettingsRepository {
  static const String _storageKey = 'settings';

  SettingsData settings = SettingsData();

  Future<bool> readSettings() async {
    final json = await StorageProvider.readJson(_storageKey);

    if (json.isEmpty) {
      return false;
    }

    try {
      settings = SettingsData.fromJson(json);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> writeSettings() async {
    final json = settings.toJson();

    return await StorageProvider.writeJson(_storageKey, json);
  }
}
