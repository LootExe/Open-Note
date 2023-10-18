import 'package:flutter/widgets.dart';
import 'package:hive_storage/hive_storage.dart';
import 'package:open_note/bootstrap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences_storage/shared_preferences_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final preferencesStorage = SharedPreferencesStorage(preferences: preferences);

  final directory = await getApplicationDocumentsDirectory();
  final hiveStorage = await HiveStorage.build(directory);

  await bootstrap(
    settingsStorage: preferencesStorage,
    noteStorage: hiveStorage,
  );
}
