part of 'note_list_bloc.dart';

class NoteListState {
  final List<Note> notes;

  const NoteListState({this.notes = const []});

  NoteListState copyWith({List<Note>? notes}) {
    return NoteListState(notes: notes ?? this.notes);
  }
}
