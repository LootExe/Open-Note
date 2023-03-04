// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextNote _$TextNoteFromJson(Map<String, dynamic> json) => TextNote(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      editTime: json['editTime'] == null
          ? null
          : DateTime.parse(json['editTime'] as String),
      content: json['content'] as String? ?? '',
    );

Map<String, dynamic> _$TextNoteToJson(TextNote instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'editTime': instance.editTime.toIso8601String(),
      'content': instance.content,
    };

TodoNote _$TodoNoteFromJson(Map<String, dynamic> json) => TodoNote(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      editTime: json['editTime'] == null
          ? null
          : DateTime.parse(json['editTime'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => TodoItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TodoNoteToJson(TodoNote instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'editTime': instance.editTime.toIso8601String(),
      'items': instance.items,
    };

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => TodoItem(
      id: json['id'] as String?,
      text: json['text'] as String? ?? '',
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'isChecked': instance.isChecked,
    };
