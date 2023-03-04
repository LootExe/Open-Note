part of 'note_bloc.dart';

class NoteState extends Equatable {
  final Note note;

  @override
  List<Object?> get props => [note];

  const NoteState({required this.note});

  NoteState copyWith({Note? note}) {
    return NoteState(note: note ?? this.note);
  }
}
