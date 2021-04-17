import 'package:json_annotation/json_annotation.dart';

import './note_data.dart';
import './todo_item.dart';

part 'todo_data.g.dart';

@JsonSerializable(explicitToJson: true)
class TodoData extends NoteData {
  List<TodoItem> items;

  TodoData(
      {required String title, required DateTime editTime, required this.items})
      : super(title: title, type: NoteType.Todo, editTime: editTime);

  factory TodoData.fromJson(Map<String, dynamic> json) =>
      _$TodoDataFromJson(json);
  Map<String, dynamic> toJson() => _$TodoDataToJson(this);

  @override
  TodoData clone() {
    final List<TodoItem> itemList = [];

    items.forEach((item) {
      itemList.add(TodoItem(
        isChecked: item.isChecked,
        text: item.text,
      ));
    });

    return TodoData(title: title, editTime: editTime, items: itemList);
  }
}
