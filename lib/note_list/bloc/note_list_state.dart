part of 'note_list_bloc.dart';

final class NoteListState extends Equatable {
  const NoteListState({this.notes = const []});

  final List<Note> notes;

  NoteListState copyWith({List<Note>? notes}) {
    return NoteListState(notes: notes ?? this.notes);
  }

  @override
  List<Object?> get props => [notes];
}
