import '../provider/storage_provider.dart';
import '../model/settings_data.dart';

class SettingsRepository {
  static const String _storageKey = 'settings';

  SettingsData settings = SettingsData();

  Future<bool> readSettings() async {
    final json = await StorageProvider.readData(_storageKey);

    if (json.isNotEmpty) {
      settings = SettingsData.fromJson(json);
    }

    return true;
  }

  Future<bool> writeSettings() async {
    final json = settings.toJson();

    return await StorageProvider.saveData(_storageKey, json);
  }
}
