import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/note_data.dart';
import '../repository/notes_repository.dart';

part 'note_list_state.dart';
part 'note_list_event.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final NotesRepository _repository;

  List<NoteData> get notes => _repository.notes;

  NoteListBloc(this._repository) : super(NoteListInitial(_repository.notes));

  @override
  Stream<NoteListState> mapEventToState(NoteListEvent event) async* {
    if (event is NoteListLoaded) {
      yield* _mapNotesLoadedToState();
    }

    if (event is NoteListUpdated) {
      yield* _mapNotesUpdatedToState();
    }

    if (event is NoteListItemDeleted) {
      yield* _mapNotesDeletedToState(event);
    }
  }

  Stream<NoteListState> _mapNotesLoadedToState() async* {
    yield NoteListLoadSuccess(notes);
  }

  Stream<NoteListState> _mapNotesUpdatedToState() async* {
    yield NoteListUpdateSuccess(notes);
  }

  Stream<NoteListState> _mapNotesDeletedToState(
      NoteListItemDeleted event) async* {
    notes.remove(event.note);
    await _repository.writeNotes();

    yield NoteListItemDeleteSuccess(notes);
  }
}
