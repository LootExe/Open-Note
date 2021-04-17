part of 'note_bloc.dart';

abstract class NoteState {
  final NoteData note;

  const NoteState(this.note);
}

class NoteInitial extends NoteState {
  const NoteInitial(NoteData note) : super(note);
}

class NoteUpdateSuccess extends NoteState {
  const NoteUpdateSuccess(NoteData note) : super(note);
}

class NoteDeleteSuccess extends NoteState {
  const NoteDeleteSuccess(NoteData note) : super(note);
}
