import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'note.g.dart';

/// The type definition for a JSON-serializable [Map].
typedef JsonMap = Map<String, dynamic>;

/// Base class for text or to-do note types.
@immutable
abstract class Note extends Equatable {
  /// Creates a new Note instance.
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

  /// The unique identifier of the note.
  final String id;

  /// Note title.
  final String title;

  /// The time the note was edited.
  final DateTime editTime;

  /// Converts this [Note] into a [JsonMap].
  JsonMap toJson();

  /// Returns a copy of this [Note] with the given values updated.
  Note copyWith({String? id, String? title, DateTime? editTime});
}

/// A Note that contains text content.
@immutable
@JsonSerializable()
final class TextNote extends Note {
  /// Creates a new Text Note instance.
  TextNote({
    super.id,
    super.title,
    super.editTime,
    this.content = '',
  });

  /// Deserializes the given [JsonMap] into [TextNote].
  factory TextNote.fromJson(JsonMap json) => _$TextNoteFromJson(json);

  /// Text note content.
  final String content;

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
  List<Object?> get props => [id, title, editTime, content];

  @override
  String toString() => content;
}

/// A Note that contains to-do items.
@immutable
@JsonSerializable()
final class TodoNote extends Note {
  /// Creates a new To-Do Note instance.
  TodoNote({
    super.id,
    super.title,
    super.editTime,
    this.items = const [],
  });

  /// Deserializes the given [JsonMap] into [TodoNote].
  factory TodoNote.fromJson(JsonMap json) => _$TodoNoteFromJson(json);

  /// To-do items.
  final List<TodoItem> items;

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
  List<Object?> get props => [id, title, editTime, items];

  @override
  String toString() => items.join(', ');
}

/// A To-Do item.
@immutable
@JsonSerializable()
final class TodoItem extends Equatable {
  /// Creates a new To-Do Item instance.
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

  /// The unique identifier of the item.
  final String id;

  /// Item text.
  final String text;

  /// Item completion status.
  final bool isChecked;

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
  List<Object?> get props => [id, text, isChecked];

  @override
  String toString() => text;
}
