import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './src/repository/settings_repository.dart';
import './src/repository/notes_repository.dart';
import './src/bloc/settings_bloc.dart';
import './src/screen/home_screen.dart';
import './src/theme_manager.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadData(),
      builder: _buildApp,
    );
  }

  Future<bool> _loadData() async {
    await Future.wait([
      RepositoryProvider.of<SettingsRepository>(context).readSettings(),
      RepositoryProvider.of<NotesRepository>(context).readNotes(),
    ]);

    return true;
  }

  Widget _buildApp(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return BlocProvider(
        create: (context) =>
            SettingsBloc(RepositoryProvider.of<SettingsRepository>(context)),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeManager.lightTheme,
              darkTheme: ThemeManager.darkTheme,
              themeMode: state.settings.themeMode,
              home: HomeScreen(),
            );
          },
        ),
      );
    } else {
      return Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
          width: 60,
          height: 60,
        ),
      );
    }
  }
}
