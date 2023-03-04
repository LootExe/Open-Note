part of 'note_list_bloc.dart';

abstract class NoteListEvent extends Equatable {
  const NoteListEvent();
}

class NoteListUpdated extends NoteListEvent {
  @override
  List<Object?> get props => [];

  const NoteListUpdated();
}

class NoteListItemDeleted extends NoteListEvent {
  final String noteId;

  @override
  List<Object?> get props => [noteId];

  const NoteListItemDeleted(this.noteId);
}

class NoteListExported extends NoteListEvent {
  final String directory;

  @override
  List<Object?> get props => [directory];

  const NoteListExported(this.directory);
}

class NoteListImported extends NoteListEvent {
  final String filePath;

  @override
  List<Object?> get props => [filePath];

  const NoteListImported(this.filePath);
}
