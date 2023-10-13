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
        create: (_) => SettingsCubit(repository: settingsRepository),
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

  bool _buildWhen(Settings previous, Settings current) {
    return previous.themeMode != current.themeMode ||
        previous.useMaterialYou != current.useMaterialYou ||
        previous.language != current.language;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, Settings>(
      buildWhen: _buildWhen,
      builder: (context, settings) => DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          final useMonet = settings.useMaterialYou;
          final light =
              _generateTheme(lightDynamic, ThemeConfig.defaultLight, useMonet);
          final dark =
              _generateTheme(darkDynamic, ThemeConfig.defaultDark, useMonet);
          final language = settings.language;
          final locale = parseLocale(language);

          return MaterialApp(
            // Theming.
            theme: light,
            darkTheme: dark,
            themeMode: settings.themeMode,
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
