// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      useMaterialYou: json['useMaterialYou'] as bool? ?? false,
      noteSortMode:
          $enumDecodeNullable(_$NoteSortModeEnumMap, json['noteSortMode']) ??
              NoteSortMode.editDate,
      noteSortIds: (json['noteSortIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      language: json['language'] as String?,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'useMaterialYou': instance.useMaterialYou,
      'noteSortMode': _$NoteSortModeEnumMap[instance.noteSortMode]!,
      'noteSortIds': instance.noteSortIds,
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
