import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:local_settings_provider/local_settings_provider.dart';
import 'package:note_backup_provider/note_backup_provider.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:local_note_provider/local_note_provider.dart';
import 'package:note_repository/note_repository.dart';

import 'app.dart';
import 'src/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(AppConfig.fontLicense);
    yield LicenseEntryWithLineBreaks([AppConfig.fontName], license);
  });

  final preferences = await SharedPreferences.getInstance();

  final settingsRepository = SettingsRepository(
    provider: LocalSettingsProvider(plugin: preferences),
  );

  final notesRepository = NoteRepository(
    noteProvider: LocalNoteProvider(plugin: preferences),
    backupProvider: NoteBackupProvider(),
  );

  // Set system orientation to portrait only.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(App(
    settingsRepository: settingsRepository,
    notesRepository: notesRepository,
  ));
}
