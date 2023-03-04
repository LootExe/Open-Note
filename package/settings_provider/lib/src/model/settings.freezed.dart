// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Settings _$SettingsFromJson(Map<String, dynamic> json) {
  return _Settings.fromJson(json);
}

/// @nodoc
mixin _$Settings {
  /// The theme mode used by the app.
  ThemeMode get themeMode => throw _privateConstructorUsedError;

  /// If Androids Material You color system should be used.
  bool get useMaterialYou => throw _privateConstructorUsedError;

  /// Note list sorting mode.
  NoteSortMode get noteSortMode => throw _privateConstructorUsedError;

  /// List of Note IDs for manual order mode.
  List<String> get noteSortOrder => throw _privateConstructorUsedError;

  /// Locale language code.
  String? get language => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res, Settings>;
  @useResult
  $Res call(
      {ThemeMode themeMode,
      bool useMaterialYou,
      NoteSortMode noteSortMode,
      List<String> noteSortOrder,
      String? language});
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res, $Val extends Settings>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? useMaterialYou = null,
    Object? noteSortMode = null,
    Object? noteSortOrder = null,
    Object? language = freezed,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      useMaterialYou: null == useMaterialYou
          ? _value.useMaterialYou
          : useMaterialYou // ignore: cast_nullable_to_non_nullable
              as bool,
      noteSortMode: null == noteSortMode
          ? _value.noteSortMode
          : noteSortMode // ignore: cast_nullable_to_non_nullable
              as NoteSortMode,
      noteSortOrder: null == noteSortOrder
          ? _value.noteSortOrder
          : noteSortOrder // ignore: cast_nullable_to_non_nullable
              as List<String>,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$$_SettingsCopyWith(
          _$_Settings value, $Res Function(_$_Settings) then) =
      __$$_SettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThemeMode themeMode,
      bool useMaterialYou,
      NoteSortMode noteSortMode,
      List<String> noteSortOrder,
      String? language});
}

/// @nodoc
class __$$_SettingsCopyWithImpl<$Res>
    extends _$SettingsCopyWithImpl<$Res, _$_Settings>
    implements _$$_SettingsCopyWith<$Res> {
  __$$_SettingsCopyWithImpl(
      _$_Settings _value, $Res Function(_$_Settings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? useMaterialYou = null,
    Object? noteSortMode = null,
    Object? noteSortOrder = null,
    Object? language = freezed,
  }) {
    return _then(_$_Settings(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      useMaterialYou: null == useMaterialYou
          ? _value.useMaterialYou
          : useMaterialYou // ignore: cast_nullable_to_non_nullable
              as bool,
      noteSortMode: null == noteSortMode
          ? _value.noteSortMode
          : noteSortMode // ignore: cast_nullable_to_non_nullable
              as NoteSortMode,
      noteSortOrder: null == noteSortOrder
          ? _value.noteSortOrder
          : noteSortOrder // ignore: cast_nullable_to_non_nullable
              as List<String>,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Settings implements _Settings {
  const _$_Settings(
      {this.themeMode = ThemeMode.system,
      this.useMaterialYou = false,
      this.noteSortMode = NoteSortMode.editDate,
      this.noteSortOrder = const <String>[],
      this.language = null});

  factory _$_Settings.fromJson(Map<String, dynamic> json) =>
      _$$_SettingsFromJson(json);

  /// The theme mode used by the app.
  @override
  @JsonKey()
  final ThemeMode themeMode;

  /// If Androids Material You color system should be used.
  @override
  @JsonKey()
  final bool useMaterialYou;

  /// Note list sorting mode.
  @override
  @JsonKey()
  final NoteSortMode noteSortMode;

  /// List of Note IDs for manual order mode.
  @override
  @JsonKey()
  final List<String> noteSortOrder;

  /// Locale language code.
  @override
  @JsonKey()
  final String? language;

  @override
  String toString() {
    return 'Settings(themeMode: $themeMode, useMaterialYou: $useMaterialYou, noteSortMode: $noteSortMode, noteSortOrder: $noteSortOrder, language: $language)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Settings &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.useMaterialYou, useMaterialYou) ||
                other.useMaterialYou == useMaterialYou) &&
            (identical(other.noteSortMode, noteSortMode) ||
                other.noteSortMode == noteSortMode) &&
            const DeepCollectionEquality()
                .equals(other.noteSortOrder, noteSortOrder) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      themeMode,
      useMaterialYou,
      noteSortMode,
      const DeepCollectionEquality().hash(noteSortOrder),
      language);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsCopyWith<_$_Settings> get copyWith =>
      __$$_SettingsCopyWithImpl<_$_Settings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SettingsToJson(
      this,
    );
  }
}

abstract class _Settings implements Settings {
  const factory _Settings(
      {final ThemeMode themeMode,
      final bool useMaterialYou,
      final NoteSortMode noteSortMode,
      final List<String> noteSortOrder,
      final String? language}) = _$_Settings;

  factory _Settings.fromJson(Map<String, dynamic> json) = _$_Settings.fromJson;

  @override

  /// The theme mode used by the app.
  ThemeMode get themeMode;
  @override

  /// If Androids Material You color system should be used.
  bool get useMaterialYou;
  @override

  /// Note list sorting mode.
  NoteSortMode get noteSortMode;
  @override

  /// List of Note IDs for manual order mode.
  List<String> get noteSortOrder;
  @override

  /// Locale language code.
  String? get language;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsCopyWith<_$_Settings> get copyWith =>
      throw _privateConstructorUsedError;
}
