import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_provider/storage_provider.dart';

/// {@template shared_preferences_storage}
/// A Shared Preferences implementation of the StorageProvider interface
/// {@endtemplate}
class SharedPreferencesStorage implements StorageProvider {
  /// {@macro shared_preferences_storage}
  SharedPreferencesStorage({required SharedPreferences preferences})
      : _preferences = preferences;

  final SharedPreferences _preferences;

  @override
  Future<String?> read(String key) => Future.value(_preferences.getString(key));

  @override
  Future<void> write(String key, String data) =>
      _preferences.setString(key, data);

  @override
  Future<void> delete(String key) => _preferences.remove(key);

  @override
  Future<void> clear() => _preferences.clear();

  @override
  Future<void> close() async {
    /// Does nothing with SharedPreferences.
  }
}
