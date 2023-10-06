import 'package:flutter/widgets.dart';
import 'package:local_note_provider/local_note_provider.dart';
import 'package:local_settings_provider/local_settings_provider.dart';
import 'package:note_backup_provider/note_backup_provider.dart';
import 'package:open_note/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();

  final settingsProvider = LocalSettingsProvider(plugin: preferences);
  final noteProvider = LocalNoteProvider(plugin: preferences);
  const backupProvider = NoteBackupProvider();

  await bootstrap(
    settingsProvider: settingsProvider,
    noteProvider: noteProvider,
    backupProvider: backupProvider,
  );
}
