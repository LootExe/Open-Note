part of 'note_bloc.dart';

abstract class NoteEvent extends ReplayEvent {
  const NoteEvent();
}

/// Note title has changed.
class NoteTitleChanged extends NoteEvent {
  final String title;

  const NoteTitleChanged({required this.title});
}

/// Note is saved to repository.
class NoteSaved extends NoteEvent {
  const NoteSaved();
}

/// Note is deleted from repository.
class NoteDeleted extends NoteEvent {
  const NoteDeleted();
}

/// Note content is cleared.
class NoteCleared extends NoteEvent {
  const NoteCleared();
}

/// Text content has changed.
class NoteTextContentChanged extends NoteEvent {
  final String content;

  const NoteTextContentChanged({required this.content});
}

/// TodoItem is added.
class NoteTodoItemAdded extends NoteEvent {
  final TodoItem item;

  const NoteTodoItemAdded({required this.item});
}

/// TodoItem is deleted.
///
class NoteTodoItemDeleted extends NoteEvent {
  final String id;

  const NoteTodoItemDeleted({required this.id});
}

/// TodoItem has changed.
class NoteTodoItemChanged extends NoteEvent {
  final TodoItem item;

  const NoteTodoItemChanged({required this.item});
}
