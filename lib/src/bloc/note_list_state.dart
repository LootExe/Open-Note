part of 'note_list_bloc.dart';

abstract class NoteListState {
  final List<NoteData> notes;

  NoteListState(this.notes) {
    _sortNotesByTime(notes);
  }

  void _sortNotesByTime(List<NoteData> noteList) =>
      noteList.sort((a, b) => b.editTime.compareTo(a.editTime));
}

class NoteListInitial extends NoteListState {
  NoteListInitial(List<NoteData> notes) : super(notes);
}

class NoteListLoadSuccess extends NoteListState {
  NoteListLoadSuccess(List<NoteData> notes) : super(notes);
}

class NoteListUpdateSuccess extends NoteListState {
  NoteListUpdateSuccess(List<NoteData> notes) : super(notes);
}

class NoteListItemDeleteSuccess extends NoteListState {
  NoteListItemDeleteSuccess(List<NoteData> notes) : super(notes);
}
