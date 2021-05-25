part of 'note_bloc.dart';

abstract class NoteState {
  const NoteState(this.note);

  final NoteData note;
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

class NoteClearCompletedSuccess extends NoteState {
  const NoteClearCompletedSuccess(NoteData note) : super(note);
}
