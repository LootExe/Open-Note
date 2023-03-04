import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note_repository/note_repository.dart';
import 'package:settings_repository/settings_repository.dart';

import 'l10n/generated/l10n.dart';
import 'src/common/utils.dart';
import 'src/config/theme_config.dart';
import 'src/note_overview/bloc/note_list_bloc.dart';
import 'src/settings/bloc/settings_bloc.dart';
import 'src/note_overview/screen/home_screen.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.settingsRepository,
    required this.notesRepository,
  });

  final SettingsRepository settingsRepository;
  final NoteRepository notesRepository;

  ThemeData _generateTheme(
      ColorScheme? dynamic, ColorScheme appDefault, bool useMonet) {
    return dynamic != null && useMonet
        ? ThemeConfig.fromScheme(dynamic)
        : ThemeConfig.fromScheme(appDefault);
  }

  bool _buildWhen(SettingsState previous, SettingsState current) {
    final prevSettings = previous.settings;
    final currSettings = current.settings;

    return prevSettings.themeMode != currSettings.themeMode ||
        prevSettings.useMaterialYou != currSettings.useMaterialYou ||
        prevSettings.language != currSettings.language;
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: notesRepository),
        RepositoryProvider.value(value: settingsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SettingsBloc(repository: settingsRepository),
          ),
          BlocProvider(
            create: (_) => NoteListBloc(repository: notesRepository),
          ),
        ],
        child: BlocBuilder<SettingsBloc, SettingsState>(
          buildWhen: _buildWhen,
          builder: (context, state) => DynamicColorBuilder(
            // Can't move it to function because it would return a Widget.
            // ignore: prefer-extracting-callbacks
            builder: (lightDynamic, darkDynamic) {
              final useMonet = state.settings.useMaterialYou;
              final light = _generateTheme(
                  lightDynamic, ThemeConfig.defaultLight, useMonet);
              final dark = _generateTheme(
                  darkDynamic, ThemeConfig.defaultDark, useMonet);
              final language = state.settings.language;
              final locale = Utils.getLocale(language);

              return MaterialApp(
                // Theming.
                theme: light,
                darkTheme: dark,
                themeMode: state.settings.themeMode,
                // Localization.
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: locale,
                // Entry point.
                home: const HomeScreen(),
              );
            },
          ),
        ),
      ),
    );
  }
}
