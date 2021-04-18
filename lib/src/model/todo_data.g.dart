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
  );
}

Map<String, dynamic> _$TodoDataToJson(TodoData instance) => <String, dynamic>{
      'title': instance.title,
      'editTime': instance.editTime.toIso8601String(),
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
