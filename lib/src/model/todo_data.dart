import 'package:json_annotation/json_annotation.dart';

import './note_data.dart';

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

  @override
  bool compareTo(NoteData data) {
    if (data is TodoData && data.title == title && _compareItems(data.items)) {
      return true;
    }

    return false;
  }

  bool _compareItems(List<TodoItem> items) {
    if (items.length != this.items.length) {
      return false;
    }

    for (int i = 0; i < items.length; i++) {
      if (!items[i].compareTo(this.items[i])) {
        return false;
      }
    }

    return true;
  }
}

@JsonSerializable()
class TodoItem {
  String text;
  bool isChecked;

  TodoItem({required this.text, required this.isChecked});

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);
  Map<String, dynamic> toJson() => _$TodoItemToJson(this);

  bool compareTo(TodoItem item) =>
      item.text == text && item.isChecked == isChecked;
}
