import 'package:json_annotation/json_annotation.dart';

import './note_data.dart';

part 'todo_data.g.dart';

@JsonSerializable(explicitToJson: true)
class TodoData extends NoteData {
  TodoData({
    required String title,
    required DateTime editTime,
    required this.items,
  }) : super(
          title: title,
          type: NoteType.Todo,
          editTime: editTime,
        );

  List<TodoItemData> items;

  factory TodoData.fromJson(Map<String, dynamic> json) =>
      _$TodoDataFromJson(json);
  Map<String, dynamic> toJson() => _$TodoDataToJson(this);

  @override
  TodoData clone() {
    final List<TodoItemData> itemList = [];

    items.forEach((item) {
      itemList.add(TodoItemData(
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

  bool _compareItems(List<TodoItemData> items) {
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
class TodoItemData {
  TodoItemData({
    required this.text,
    required this.isChecked,
  });

  String text;
  bool isChecked;

  factory TodoItemData.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);
  Map<String, dynamic> toJson() => _$TodoItemToJson(this);

  bool compareTo(TodoItemData item) =>
      item.text == text && item.isChecked == isChecked;
}
