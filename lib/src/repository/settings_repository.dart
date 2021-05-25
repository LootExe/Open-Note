import '../model/settings_data.dart';
import '../provider/storage_provider.dart';

class SettingsRepository {
  static const String _storageKey = 'settings';

  var settings = SettingsData();

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
