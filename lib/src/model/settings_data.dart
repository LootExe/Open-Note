import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'settings_data.g.dart';

@JsonSerializable()
class SettingsData {
  ThemeMode themeMode = ThemeMode.system;

  bool get isEmpty {
    return themeMode == ThemeMode.system;
  }

  SettingsData();

  factory SettingsData.fromJson(Map<String, dynamic> json) =>
      _$SettingsDataFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsDataToJson(this);
}
