part of 'note_bloc.dart';

final class NoteState extends Equatable {
  const NoteState({required this.note});

  final Note note;

  NoteState copyWith({Note? note}) {
    return NoteState(note: note ?? this.note);
  }

  @override
  List<Object?> get props => [note];
}
