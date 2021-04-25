// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoData _$TodoDataFromJson(Map<String, dynamic> json) {
  return TodoData(
    title: json['title'] as String,
    editTime: DateTime.parse(json['editTime'] as String),
    items: (json['items'] as List<dynamic>)
        .map((e) => TodoItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..type = _$enumDecode(_$NoteTypeEnumMap, json['type']);
}

Map<String, dynamic> _$TodoDataToJson(TodoData instance) => <String, dynamic>{
      'title': instance.title,
      'type': _$NoteTypeEnumMap[instance.type],
      'editTime': instance.editTime.toIso8601String(),
      'items': instance.items.map((e) => e.toJson()).toList(),
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

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) {
  return TodoItem(
    text: json['text'] as String,
    isChecked: json['isChecked'] as bool,
  );
}

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'text': instance.text,
      'isChecked': instance.isChecked,
    };
