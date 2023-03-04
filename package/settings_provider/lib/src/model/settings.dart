import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

import 'json_map.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

/// App settings data.
@Freezed(makeCollectionsUnmodifiable: false)
class Settings with _$Settings {
  const factory Settings({
    /// The theme mode used by the app.
    @Default(ThemeMode.system) ThemeMode themeMode,

    /// If Androids Material You color system should be used.
    @Default(false) bool useMaterialYou,

    /// Note list sorting mode.
    @Default(NoteSortMode.editDate) NoteSortMode noteSortMode,

    /// List of Note IDs for manual order mode.
    @Default(const <String>[]) List<String> noteSortOrder,

    /// Locale language code.
    @Default(null) String? language,
  }) = _Settings;

  /// Deserializes the given [JsonMap] into [Settings].
  factory Settings.fromJson(JsonMap json) => _$SettingsFromJson(json);
}

enum NoteSortMode {
  editDate,
  alphabeticalAscending,
  alphabeticalDescending,
  manual,
}
