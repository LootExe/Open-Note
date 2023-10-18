part of 'note_list_bloc.dart';

sealed class NoteListEvent extends Equatable {
  const NoteListEvent();
}

final class NoteListChanged extends NoteListEvent {
  const NoteListChanged();

  @override
  List<Object?> get props => [];
}

final class NoteListItemDeleted extends NoteListEvent {
  const NoteListItemDeleted(this.noteId);

  final String noteId;

  @override
  List<Object?> get props => [noteId];
}
/* 
final class NoteListExported extends NoteListEvent {
  const NoteListExported(this.directory);

  final String directory;

  @override
  List<Object?> get props => [directory];
}

final class NoteListImported extends NoteListEvent {
  const NoteListImported(this.filePath);

  final String filePath;

  @override
  List<Object?> get props => [filePath];
} */
