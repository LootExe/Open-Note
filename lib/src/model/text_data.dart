import 'package:json_annotation/json_annotation.dart';

import './note_data.dart';

part 'text_data.g.dart';

@JsonSerializable()
class TextData extends NoteData {
  TextData({
    required String title,
    required DateTime editTime,
    required this.text,
  }) : super(
          title: title,
          type: NoteType.Text,
          editTime: editTime,
        );

  String text;

  factory TextData.fromJson(Map<String, dynamic> json) =>
      _$TextDataFromJson(json);
  Map<String, dynamic> toJson() => _$TextDataToJson(this);

  @override
  TextData clone() => TextData(editTime: editTime, title: title, text: text);

  @override
  bool compareTo(NoteData data) {
    if (data is TextData && data.title == title && data.text == text) {
      return true;
    }

    return false;
  }
}
