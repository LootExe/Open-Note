import 'package:json_annotation/json_annotation.dart';

import './note_data.dart';

part 'text_data.g.dart';

@JsonSerializable()
class TextData extends NoteData {
  String text;

  TextData(
      {required String title, required DateTime editTime, required this.text})
      : super(title: title, type: NoteType.Text, editTime: editTime);

  TextData.clone(TextData original)
      : this(
            editTime: original.editTime,
            title: original.title,
            text: original.text);

  factory TextData.fromJson(Map<String, dynamic> json) =>
      _$TextDataFromJson(json);
  Map<String, dynamic> toJson() => _$TextDataToJson(this);

  @override
  TextData clone() => TextData(editTime: editTime, title: title, text: text);
}
