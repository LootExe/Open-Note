part of 'note_bloc.dart';

abstract class NoteEvent {}

class NoteUpdated extends NoteEvent {}

class NoteDeleted extends NoteEvent {}

class NoteTodoAllMarked extends NoteEvent {}

class NoteTodoAllUnmarked extends NoteEvent {}

class NoteTodoClearedCompleted extends NoteEvent {}

class NoteTextCleared extends NoteEvent {}
