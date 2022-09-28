import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';
import '../repository/notes_repository.dart';

part 'note_state.dart';
part 'note_event.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc({
    required NotesRepository repository,
    required NoteData note,
  })  : _repository = repository,
        _note = note,
        super(NoteInitial(note)) {
    _originalNote = _note.clone();
    on<NoteUpdated>(_onNoteUpdated);
    on<NoteDeleted>(_onNoteDeleted);
    on<NoteTodoAllMarked>(_onTodoAllMarked);
    on<NoteTodoAllUnmarked>(_onTodoAllUnmarked);
    on<NoteTodoClearedCompleted>(_onTodoClearedCompleted);
    on<NoteTextCleared>(_onTextCleared);
  }

  final NotesRepository _repository;
  final NoteData _note;
  late NoteData _originalNote;

  Future<void> _onNoteUpdated(
      NoteUpdated event, Emitter<NoteState> emit) async {
    if (_repository.notes.contains(_note) == false) {
      _repository.notes.add(_note);

      await _repository.writeNotes();
    } else if (_note.compareTo(_originalNote) == false) {
      _note.editTime = DateTime.now();
      _originalNote = _note.clone();

      await _repository.writeNotes();
    }

    emit(NoteUpdateSuccess(_note));
  }

  Future<void> _onNoteDeleted(
      NoteDeleted event, Emitter<NoteState> emit) async {
    _repository.notes.remove(_note);

    await _repository.writeNotes();
    emit(NoteDeleteSuccess(_note));
  }

  Future<void> _onTodoAllMarked(
      NoteTodoAllMarked event, Emitter<NoteState> emit) async {
    for (var item in (_note as TodoData).items) {
      item.isChecked = true;
    }

    add(NoteUpdated());
  }

  Future<void> _onTodoAllUnmarked(
      NoteTodoAllUnmarked event, Emitter<NoteState> emit) async {
    for (var item in (_note as TodoData).items) {
      item.isChecked = false;
    }

    add(NoteUpdated());
  }

  Future<void> _onTodoClearedCompleted(
      NoteTodoClearedCompleted event, Emitter<NoteState> emit) async {
    (_note as TodoData).items.removeWhere((item) => item.isChecked);

    emit(NoteClearCompletedSuccess(_note));
  }

  Future<void> _onTextCleared(
      NoteTextCleared event, Emitter<NoteState> emit) async {
    (_note as TextData).text = '';

    add(NoteUpdated());
  }
}
