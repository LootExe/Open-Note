part of 'note_list_bloc.dart';

abstract class NoteListState {
  final List<NoteData> notes;

  const NoteListState(this.notes);
}

class NoteListInitial extends NoteListState {
  const NoteListInitial(List<NoteData> notes) : super(notes);
}

class NoteListLoadSuccess extends NoteListState {
  const NoteListLoadSuccess(List<NoteData> notes) : super(notes);
}

class NoteListUpdateSuccess extends NoteListState {
  const NoteListUpdateSuccess(List<NoteData> notes) : super(notes);
}

class NoteListItemDeleteSuccess extends NoteListState {
  const NoteListItemDeleteSuccess(List<NoteData> notes) : super(notes);
}
