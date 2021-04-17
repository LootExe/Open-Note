import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './app.dart';
import './src/repository/settings_repository.dart';
import './src/repository/notes_repository.dart';

void main() {
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<SettingsRepository>(
        create: (_) => SettingsRepository(),
      ),
      RepositoryProvider<NotesRepository>(
        create: (_) => NotesRepository(),
      ),
    ],
    child: App(),
  ));
}
