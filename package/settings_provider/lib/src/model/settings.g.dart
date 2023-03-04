// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Settings _$$_SettingsFromJson(Map<String, dynamic> json) => _$_Settings(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      useMaterialYou: json['useMaterialYou'] as bool? ?? false,
      noteSortMode:
          $enumDecodeNullable(_$NoteSortModeEnumMap, json['noteSortMode']) ??
              NoteSortMode.editDate,
      noteSortOrder: (json['noteSortOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      language: json['language'] as String? ?? null,
    );

Map<String, dynamic> _$$_SettingsToJson(_$_Settings instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'useMaterialYou': instance.useMaterialYou,
      'noteSortMode': _$NoteSortModeEnumMap[instance.noteSortMode]!,
      'noteSortOrder': instance.noteSortOrder,
      'language': instance.language,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$NoteSortModeEnumMap = {
  NoteSortMode.editDate: 'editDate',
  NoteSortMode.alphabeticalAscending: 'alphabeticalAscending',
  NoteSortMode.alphabeticalDescending: 'alphabeticalDescending',
  NoteSortMode.manual: 'manual',
};
