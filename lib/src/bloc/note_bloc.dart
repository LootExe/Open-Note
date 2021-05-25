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
  })   : this._repository = repository,
        this._note = note,
        super(NoteInitial(note)) {
    _originalNote = _note.clone();
  }

  final NotesRepository _repository;
  final NoteData _note;
  late NoteData _originalNote;

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is NoteUpdated) {
      yield* _mapNoteUpdatedToState();
    }

    if (event is NoteDeleted) {
      yield* _mapNoteDeletedToState();
    }

    if (event is NoteTodoAllMarked) {
      yield* _mapNoteTodoAllMarkedToState();
    }

    if (event is NoteTodoAllUnmarked) {
      yield* _mapNoteTodoAllUnmarkedToState();
    }

    if (event is NoteTodoClearedCompleted) {
      yield* _mapNoteTodoClearedCompletedToState();
    }

    if (event is NoteTextCleared) {
      yield* _mapNoteTextClearedToState();
    }
  }

  Stream<NoteState> _mapNoteUpdatedToState() async* {
    if (_repository.notes.contains(_note) == false) {
      _repository.notes.add(_note);

      await _repository.writeNotes();
    } else if (_note.compareTo(_originalNote) == false) {
      _note.editTime = DateTime.now();
      _originalNote = _note.clone();

      await _repository.writeNotes();
    }

    yield NoteUpdateSuccess(_note);
  }

  Stream<NoteState> _mapNoteDeletedToState() async* {
    _repository.notes.remove(_note);

    await _repository.writeNotes();
    yield NoteDeleteSuccess(_note);
  }

  Stream<NoteState> _mapNoteTodoAllMarkedToState() async* {
    (_note as TodoData).items.forEach((item) => item.isChecked = true);

    add(NoteUpdated());
  }

  Stream<NoteState> _mapNoteTodoAllUnmarkedToState() async* {
    (_note as TodoData).items.forEach((item) => item.isChecked = false);

    add(NoteUpdated());
  }

  Stream<NoteState> _mapNoteTodoClearedCompletedToState() async* {
    (_note as TodoData).items.removeWhere((item) => item.isChecked);

    yield NoteClearCompletedSuccess(_note);
  }

  Stream<NoteState> _mapNoteTextClearedToState() async* {
    (_note as TextData).text = '';

    add(NoteUpdated());
  }
}
