// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_storage_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteStorageData _$NoteStorageDataFromJson(Map<String, dynamic> json) {
  return NoteStorageData(
    storageDetails: (json['storageDetails'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(int.parse(k), _$enumDecode(_$NoteTypeEnumMap, e)),
    ),
  );
}

Map<String, dynamic> _$NoteStorageDataToJson(NoteStorageData instance) =>
    <String, dynamic>{
      'storageDetails': instance.storageDetails
          .map((k, e) => MapEntry(k.toString(), _$NoteTypeEnumMap[e])),
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
