// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Note`
  String get appTitle {
    return Intl.message(
      'Note',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `To add a note, click on the + button in the bottom right corner.`
  String get emptyListInfo {
    return Intl.message(
      'To add a note, click on the + button in the bottom right corner.',
      name: 'emptyListInfo',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsAppbar {
    return Intl.message(
      'Settings',
      name: 'settingsAppbar',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get settingsAppearanceHeader {
    return Intl.message(
      'Appearance',
      name: 'settingsAppearanceHeader',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get settingsNotesHeader {
    return Intl.message(
      'Notes',
      name: 'settingsNotesHeader',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get settingsAboutHeader {
    return Intl.message(
      'About',
      name: 'settingsAboutHeader',
      desc: '',
      args: [],
    );
  }

  /// `System default`
  String get settingsThemeSystem {
    return Intl.message(
      'System default',
      name: 'settingsThemeSystem',
      desc: '',
      args: [],
    );
  }

  /// `Always light`
  String get settingsThemeLight {
    return Intl.message(
      'Always light',
      name: 'settingsThemeLight',
      desc: '',
      args: [],
    );
  }

  /// `Always dark`
  String get settingsThemeDark {
    return Intl.message(
      'Always dark',
      name: 'settingsThemeDark',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settingsThemeButton {
    return Intl.message(
      'Theme',
      name: 'settingsThemeButton',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get themeDialogTitle {
    return Intl.message(
      'Theme Mode',
      name: 'themeDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Android 12+ color system`
  String get settingMonetAndroidColor {
    return Intl.message(
      'Android 12+ color system',
      name: 'settingMonetAndroidColor',
      desc: '',
      args: [],
    );
  }

  /// `Default app color scheme`
  String get settingMonetAppColor {
    return Intl.message(
      'Default app color scheme',
      name: 'settingMonetAppColor',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingLocaleLanguageButton {
    return Intl.message(
      'Language',
      name: 'settingLocaleLanguageButton',
      desc: '',
      args: [],
    );
  }

  /// `System default`
  String get settingLocaleSystemDefault {
    return Intl.message(
      'System default',
      name: 'settingLocaleSystemDefault',
      desc: '',
      args: [],
    );
  }

  /// `Sorting Mode`
  String get settingSortTitle {
    return Intl.message(
      'Sorting Mode',
      name: 'settingSortTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit date (default)`
  String get settingSortEditDate {
    return Intl.message(
      'Edit date (default)',
      name: 'settingSortEditDate',
      desc: '',
      args: [],
    );
  }

  /// `Alphabetical ↑`
  String get settingSortAscending {
    return Intl.message(
      'Alphabetical ↑',
      name: 'settingSortAscending',
      desc: '',
      args: [],
    );
  }

  /// `Alphabetical ↓`
  String get settingSortDescending {
    return Intl.message(
      'Alphabetical ↓',
      name: 'settingSortDescending',
      desc: '',
      args: [],
    );
  }

  /// `Manual`
  String get settingSortManual {
    return Intl.message(
      'Manual',
      name: 'settingSortManual',
      desc: '',
      args: [],
    );
  }

  /// `Export Notes`
  String get settingExportTitle {
    return Intl.message(
      'Export Notes',
      name: 'settingExportTitle',
      desc: '',
      args: [],
    );
  }

  /// `Export into a file`
  String get settingExportSubtitle {
    return Intl.message(
      'Export into a file',
      name: 'settingExportSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Export cancelled`
  String get settingExportCancelled {
    return Intl.message(
      'Export cancelled',
      name: 'settingExportCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Notes exported`
  String get settingExportSuccess {
    return Intl.message(
      'Notes exported',
      name: 'settingExportSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Import Notes`
  String get settingImportTitle {
    return Intl.message(
      'Import Notes',
      name: 'settingImportTitle',
      desc: '',
      args: [],
    );
  }

  /// `Import from a file`
  String get settingImportSubtitle {
    return Intl.message(
      'Import from a file',
      name: 'settingImportSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Import cancelled`
  String get settingImportCancelled {
    return Intl.message(
      'Import cancelled',
      name: 'settingImportCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Notes imported`
  String get settingImportSuccess {
    return Intl.message(
      'Notes imported',
      name: 'settingImportSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Licenses`
  String get settingLicenseTitle {
    return Intl.message(
      'Licenses',
      name: 'settingLicenseTitle',
      desc: '',
      args: [],
    );
  }

  /// `Show third-party licenses`
  String get settingLicenseSubtitle {
    return Intl.message(
      'Show third-party licenses',
      name: 'settingLicenseSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get dateSeparatedListTodaySeparator {
    return Intl.message(
      'Today',
      name: 'dateSeparatedListTodaySeparator',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get dateSeparatedListYesterdaySeparator {
    return Intl.message(
      'Yesterday',
      name: 'dateSeparatedListYesterdaySeparator',
      desc: '',
      args: [],
    );
  }

  /// `Past 30 Days`
  String get dateSeparatedList30DaysSeparator {
    return Intl.message(
      'Past 30 Days',
      name: 'dateSeparatedList30DaysSeparator',
      desc: '',
      args: [],
    );
  }

  /// `{time}`
  String utilsParseDateTimeShortTime(DateTime time) {
    final DateFormat timeDateFormat = DateFormat.jm(Intl.getCurrentLocale());
    final String timeString = timeDateFormat.format(time);

    return Intl.message(
      '$timeString',
      name: 'utilsParseDateTimeShortTime',
      desc: '',
      args: [timeString],
    );
  }

  /// `{date}`
  String utilsParseDateTimeLongDate(DateTime date) {
    final DateFormat dateDateFormat =
        DateFormat.yMMMMd(Intl.getCurrentLocale());
    final String dateString = dateDateFormat.format(date);

    return Intl.message(
      '$dateString',
      name: 'utilsParseDateTimeLongDate',
      desc: '',
      args: [dateString],
    );
  }

  /// `Delete Note`
  String get deleteDialogTitle {
    return Intl.message(
      'Delete Note',
      name: 'deleteDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this note?`
  String get deleteDialogContent {
    return Intl.message(
      'Do you want to delete this note?',
      name: 'deleteDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get deleteDialogActionCancel {
    return Intl.message(
      'Cancel',
      name: 'deleteDialogActionCancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteDialogActionDelete {
    return Intl.message(
      'Delete',
      name: 'deleteDialogActionDelete',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get noteAppBarDateToday {
    return Intl.message(
      'Today',
      name: 'noteAppBarDateToday',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get noteAppBarDateYesterday {
    return Intl.message(
      'Yesterday',
      name: 'noteAppBarDateYesterday',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get noteMenuClearLabel {
    return Intl.message(
      'Clear',
      name: 'noteMenuClearLabel',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get noteMenuShareLabel {
    return Intl.message(
      'Share',
      name: 'noteMenuShareLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get noteMenuDeleteLabel {
    return Intl.message(
      'Delete',
      name: 'noteMenuDeleteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to share`
  String get noteMenuShareMessage {
    return Intl.message(
      'Nothing to share',
      name: 'noteMenuShareMessage',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get noteTitleHint {
    return Intl.message(
      'Title',
      name: 'noteTitleHint',
      desc: '',
      args: [],
    );
  }

  /// `Start writing your text ...`
  String get noteContentTextHint {
    return Intl.message(
      'Start writing your text ...',
      name: 'noteContentTextHint',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'de', countryCode: 'DE'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'GB'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
