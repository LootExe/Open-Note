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
  Future<Set<String>?> readKeys() => Future.value(_preferences.getKeys());

  @override
  Future<String?> read(String key) => Future.value(_preferences.getString(key));

  @override
  Future<void> write(String key, String value) =>
      _preferences.setString(key, value);

  @override
  Future<void> delete(String key) => _preferences.remove(key);

  @override
  Future<void> clear() => _preferences.clear();

  /// Does nothing with SharedPreferences.
  @override
  Future<void> close() => Future.value();
}
