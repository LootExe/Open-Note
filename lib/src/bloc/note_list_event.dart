part of 'note_list_bloc.dart';

abstract class NoteListEvent {}

class NoteListLoaded extends NoteListEvent {}

class NoteListUpdated extends NoteListEvent {}

class NoteListItemDeleted extends NoteListEvent {
  final NoteData note;

  NoteListItemDeleted(this.note);
}
