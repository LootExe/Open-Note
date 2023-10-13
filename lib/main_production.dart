import 'package:flutter/widgets.dart';
import 'package:local_note_provider/local_note_provider.dart';
import 'package:note_backup_provider/note_backup_provider.dart';
import 'package:open_note/bootstrap.dart';
import 'package:shared_preferences_storage/shared_preferences_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final preferencesStorage = SharedPreferencesStorage(preferences: preferences);

  // TODO(Frank): Initialize Hive here and setup HiveStorage
  final noteProvider = LocalNoteProvider(plugin: preferences);
  const backupProvider = NoteBackupProvider();

  await bootstrap(
    settingsStorage: preferencesStorage,
    noteProvider: noteProvider,
    backupProvider: backupProvider,
  );
}
