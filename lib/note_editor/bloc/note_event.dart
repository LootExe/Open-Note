part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

/// Note title has changed.
final class NoteTitleChanged extends NoteEvent {
  const NoteTitleChanged(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}

/// Note is saved to repository.
final class NoteSaved extends NoteEvent {
  const NoteSaved();
}

/// Note is deleted from repository.
final class NoteDeleted extends NoteEvent {
  const NoteDeleted();
}

/// Note content is cleared.
final class NoteCleared extends NoteEvent {
  const NoteCleared();
}

/// Text content has changed.
final class NoteTextContentChanged extends NoteEvent {
  const NoteTextContentChanged(this.content);

  final String content;

  @override
  List<Object?> get props => [content];
}

/// TodoItem is added.
final class NoteTodoItemAdded extends NoteEvent {
  const NoteTodoItemAdded(this.item);

  final TodoItem item;

  @override
  List<Object?> get props => [item];
}

/// TodoItem is deleted.
final class NoteTodoItemDeleted extends NoteEvent {
  const NoteTodoItemDeleted(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// TodoItem has changed.
final class NoteTodoItemChanged extends NoteEvent {
  const NoteTodoItemChanged(this.item);

  final TodoItem item;

  @override
  List<Object?> get props => [item];
}
