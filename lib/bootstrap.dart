import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:note_backup_provider/note_backup_provider.dart';
import 'package:note_provider/note_provider.dart';
import 'package:note_repository/note_repository.dart';
import 'package:open_note/app/app.dart';
import 'package:open_note/config/config.dart';
import 'package:settings_provider/settings_provider.dart';
import 'package:settings_repository/settings_repository.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap({
  required SettingsProvider settingsProvider,
  required NoteProvider noteProvider,
  required NoteBackupProvider backupProvider,
}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(AppConfig.fontLicense);
    yield LicenseEntryWithLineBreaks([AppConfig.fontName], license);
  });

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final settingsRepository = SettingsRepository(provider: settingsProvider);
  final noteRepository = NoteRepository(
    noteProvider: noteProvider,
    backupProvider: backupProvider,
  );

  runApp(App(
    settingsRepository: settingsRepository,
    noteRepository: noteRepository,
  ));
}
