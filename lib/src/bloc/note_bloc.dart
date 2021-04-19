import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/notes_repository.dart';
import '../model/note_data.dart';

part 'note_state.dart';
part 'note_event.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesRepository _repository;
  final NoteData note;
  late NoteData _originalNote;

  NoteBloc({required NotesRepository repository, required this.note})
      : this._repository = repository,
        super(NoteInitial(note)) {
    _originalNote = note.clone();
  }

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is NoteUpdated) {
      yield* _mapNoteUpdatedToState();
    }

    if (event is NoteDeleted) {
      yield* _mapNoteDeletedToState();
    }
  }

  Stream<NoteState> _mapNoteUpdatedToState() async* {
    if (note.compareTo(_originalNote) == false) {
      note.editTime = DateTime.now();
      _originalNote = note.clone();

      await _repository.writeNotes();
    }

    yield NoteUpdateSuccess(note);
  }

  Stream<NoteState> _mapNoteDeletedToState() async* {
    _repository.notes.remove(note);
    await _repository.writeNotes();

    yield NoteDeleteSuccess(note);
  }
}
