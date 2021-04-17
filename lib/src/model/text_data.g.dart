// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextData _$TextDataFromJson(Map<String, dynamic> json) {
  return TextData(
    title: json['title'] as String,
    editTime: DateTime.parse(json['editTime'] as String),
    text: json['text'] as String,
  )..type = _$enumDecode(_$NoteTypeEnumMap, json['type']);
}

Map<String, dynamic> _$TextDataToJson(TextData instance) => <String, dynamic>{
      'title': instance.title,
      'type': _$NoteTypeEnumMap[instance.type],
      'editTime': instance.editTime.toIso8601String(),
      'text': instance.text,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$NoteTypeEnumMap = {
  NoteType.Todo: 'Todo',
  NoteType.Text: 'Text',
};
