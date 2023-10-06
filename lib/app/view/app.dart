import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note_repository/note_repository.dart';
import 'package:open_note/common/utils.dart';
import 'package:open_note/config/config.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:open_note/note_list/note_list.dart';
import 'package:open_note/settings/settings.dart';
import 'package:settings_repository/settings_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.settingsRepository,
    required this.noteRepository,
    super.key,
  });

  final SettingsRepository settingsRepository;
  final NoteRepository noteRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: noteRepository,
      child: BlocProvider(
        create: (_) => SettingsBloc(repository: settingsRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  ThemeData _generateTheme(
    ColorScheme? dynamic,
    ColorScheme appDefault,
    bool useMonet,
  ) {
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
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: _buildWhen,
      builder: (context, state) => DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          final useMonet = state.settings.useMaterialYou;
          final light =
              _generateTheme(lightDynamic, ThemeConfig.defaultLight, useMonet);
          final dark =
              _generateTheme(darkDynamic, ThemeConfig.defaultDark, useMonet);
          final language = state.settings.language;
          final locale = parseLocale(language);

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
            home: const NoteListPage(),
          );
        },
      ),
    );
  }
}
