part of 'note_list_bloc.dart';

abstract class NoteListEvent {}

class NoteListLoaded extends NoteListEvent {}

class NoteListUpdated extends NoteListEvent {}

class NoteListItemDeleted extends NoteListEvent {
  final NoteData note;

  NoteListItemDeleted(this.note);
}

class NoteListExported extends NoteListEvent {}

class NoteListImportFilesStarted extends NoteListEvent {}

class NoteListImportFilesLoaded extends NoteListEvent {
  final List<NoteListFile> files;

  NoteListImportFilesLoaded(this.files);
}

class NoteListImported extends NoteListEvent {
  final Uri file;

  NoteListImported(this.file);
}
