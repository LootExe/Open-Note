part of 'note_bloc.dart';

abstract class NoteEvent {}

class NoteUpdated extends NoteEvent {}

class NoteDeleted extends NoteEvent {}
