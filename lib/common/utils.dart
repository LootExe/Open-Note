import 'package:flutter/material.dart';
import 'package:open_note/common/extension/extension.dart';
import 'package:open_note/l10n/generated/l10n.dart';
import 'package:settings_repository/settings_repository.dart';

String getDateTime(DateTime dateTime) {
  return dateTime.isToday || dateTime.isYesterday
      ? S.current.utilsParseDateTimeShortTime(dateTime)
      : S.current.utilsParseDateTimeLongDate(dateTime);
}

/// Simple parser. Expects the locale string to be in the form of
/// 'language_script_COUNTRY' where the language is 2 characters,
/// script is 4 characters with the first uppercase,
/// and country is 2-3 characters and all uppercase.
///
/// 'language_COUNTRY' or 'language_script' are also valid.
/// Missing fields will be null.
Locale? parseLocale(String? locale) {
  if (locale == null) {
    return null;
  }

  // [language, script, country].
  final codes = locale.split('_');
  assert(
    codes.isNotEmpty && codes.length < 4,
    'Must be not empty and consists of max. 3 parts',
  );

  final languageCode = codes.first;
  String? scriptCode;
  String? countryCode;

  if (codes.length == 2) {
    final length = codes[1].length;
    scriptCode = length >= 4 ? codes[1] : null;
    countryCode = length < 4 ? codes[1] : null;
  } else if (codes.length == 3) {
    final length1 = codes[1].length;
    final length2 = codes[2].length;
    scriptCode = length1 > length2 ? codes[1] : codes[2];
    countryCode = length1 < length2 ? codes[1] : codes[2];
  }

  assert(codes.first.isNotEmpty, 'Must be not empty');

  return Locale.fromSubtags(
    languageCode: languageCode,
    scriptCode: scriptCode,
    countryCode: countryCode,
  );
}

String getLanguageName(String? languageCode) {
  switch (languageCode) {
    case null:
      return S.current.settingLocaleSystemDefault;
    case 'de_DE':
      return 'Deutsch';
    case 'en_GB':
      return 'English (UK)';
    default:
      return 'English (US)';
  }
}

String getThemeModeText(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.system:
      return S.current.settingsThemeSystem;
    case ThemeMode.light:
      return S.current.settingsThemeLight;
    case ThemeMode.dark:
      return S.current.settingsThemeDark;
  }
}

String getSortingModeText(NoteSortMode mode) {
  switch (mode) {
    case NoteSortMode.editDate:
      return S.current.settingSortEditDate;
    case NoteSortMode.alphabeticalAscending:
      return S.current.settingSortAscending;
    case NoteSortMode.alphabeticalDescending:
      return S.current.settingSortDescending;
    case NoteSortMode.manual:
      return S.current.settingSortManual;
  }
}
