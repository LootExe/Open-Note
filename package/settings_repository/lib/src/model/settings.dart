import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

/// The type definition for a JSON-serializable [Map].
typedef JsonMap = Map<String, dynamic>;

/// Defines the way notes are sorted.
enum NoteSortMode {
  /// Sort notes by editDate, youngest first.
  editDate,

  /// Sort notes by title in ascending order.
  alphabeticalAscending,

  /// Sort notes by title in descending order.
  alphabeticalDescending,

  /// Notes can be sorted manually.
  manual,
}

/// Model that holds app settings.
@immutable
@JsonSerializable()
class Settings extends Equatable {
  /// Creates a new Settings instance.
  const Settings({
    this.themeMode = ThemeMode.system,
    this.useMaterialYou = false,
    this.noteSortMode = NoteSortMode.editDate,
    this.noteSortIds = const [],
    this.language,
  });

  /// Deserializes the given [JsonMap] into [Settings].
  factory Settings.fromJson(JsonMap json) => _$SettingsFromJson(json);

  /// The theme mode used by the app.
  final ThemeMode themeMode;

  /// If Androids Material You color system should be used.
  final bool useMaterialYou;

  /// Note list sorting mode.
  final NoteSortMode noteSortMode;

  /// List of Note IDs for manual order mode.
  final List<String> noteSortIds;

  /// Locale language code.
  final String? language;

  /// Converts this [Settings] into a [JsonMap].
  JsonMap toJson() => _$SettingsToJson(this);

  /// Returns a copy of this [Settings] with the given values updated.
  Settings copyWith({
    ThemeMode? themeMode,
    bool? useMaterialYou,
    NoteSortMode? noteSortMode,
    List<String>? noteSortIds,
    String? Function()? language,
  }) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
      useMaterialYou: useMaterialYou ?? this.useMaterialYou,
      noteSortMode: noteSortMode ?? this.noteSortMode,
      noteSortIds: noteSortIds ?? this.noteSortIds,
      language: language?.call() ?? this.language,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        useMaterialYou,
        noteSortMode,
        noteSortIds,
        language,
      ];
}
