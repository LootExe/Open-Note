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
  );
}

Map<String, dynamic> _$TextDataToJson(TextData instance) => <String, dynamic>{
      'title': instance.title,
      'editTime': instance.editTime.toIso8601String(),
      'text': instance.text,
    };
