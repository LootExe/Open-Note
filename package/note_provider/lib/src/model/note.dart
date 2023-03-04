import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'json_map.dart';

part 'note.g.dart';

@immutable
abstract class Note extends Equatable {
  /// The unique identifier of the note.
  final String id;

  /// Note title.
  final String title;

  /// The time the note was edited.
  final DateTime editTime;

  Note({
    String? id,
    this.title = '',
    DateTime? editTime,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4(),
        editTime = editTime ?? DateTime.now();

  /// Converts this [Note] into a [JsonMap].
  JsonMap toJson();

  /// Returns a copy of this [Note] with the given values updated.
  Note copyWith({String? id, String? title, DateTime? editTime});
}

@immutable
@JsonSerializable()
class TextNote extends Note {
  /// Text note content.
  final String content;

  @override
  List<Object?> get props => [id, title, editTime, content];

  TextNote({
    super.id,
    super.title,
    super.editTime,
    this.content = '',
  });

  /// Deserializes the given [JsonMap] into [TextNote].
  factory TextNote.fromJson(JsonMap json) => _$TextNoteFromJson(json);

  @override
  JsonMap toJson() => _$TextNoteToJson(this);

  @override
  TextNote copyWith({
    String? id,
    String? title,
    DateTime? editTime,
    String? content,
  }) {
    return TextNote(
      id: id ?? this.id,
      title: title ?? this.title,
      editTime: editTime ?? this.editTime,
      content: content ?? this.content,
    );
  }

  @override
  String toString() => content;
}

@immutable
@JsonSerializable()
class TodoNote extends Note {
  /// Todo items.
  final List<TodoItem> items;

  @override
  List<Object?> get props => [id, title, editTime, items];

  TodoNote({
    super.id,
    super.title,
    super.editTime,
    this.items = const [],
  });

  /// Deserializes the given [JsonMap] into [TodoNote].
  factory TodoNote.fromJson(JsonMap json) => _$TodoNoteFromJson(json);

  @override
  JsonMap toJson() => _$TodoNoteToJson(this);

  @override
  TodoNote copyWith({
    String? id,
    String? title,
    DateTime? editTime,
    List<TodoItem>? items,
  }) {
    return TodoNote(
      id: id ?? this.id,
      title: title ?? this.title,
      editTime: editTime ?? this.editTime,
      items: items ?? this.items,
    );
  }

  @override
  String toString() => items.join(', ');
}

@immutable
@JsonSerializable()
class TodoItem extends Equatable {
  /// The unique identifier of the item.
  final String id;

  /// Item text.
  final String text;

  /// Item completion status.
  final bool isChecked;

  @override
  List<Object?> get props => [id, text, isChecked];

  TodoItem({
    String? id,
    this.text = '',
    this.isChecked = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// Deserializes the given [JsonMap] into [TodoItem].
  factory TodoItem.fromJson(JsonMap json) => _$TodoItemFromJson(json);

  /// Converts this [TodoItem] into a [JsonMap].
  JsonMap toJson() => _$TodoItemToJson(this);

  /// Returns a copy of this [TodoNote] with the given values updated.
  TodoItem copyWith({
    String? id,
    String? text,
    bool? isChecked,
  }) {
    return TodoItem(
      id: id ?? this.id,
      text: text ?? this.text,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  String toString() => text;
}
