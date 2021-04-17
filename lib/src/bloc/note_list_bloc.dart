import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/notes_repository.dart';
import '../model/note_data.dart';

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
    _sortNotesByTime(notes);

    yield NoteListLoadSuccess(notes);
  }

  Stream<NoteListState> _mapNotesUpdatedToState() async* {
    _sortNotesByTime(notes);

    yield NoteListUpdateSuccess(notes);
  }

  Stream<NoteListState> _mapNotesDeletedToState(
      NoteListItemDeleted event) async* {
    notes.remove(event.note);
    _repository.writeNotes();

    yield NoteListItemDeleteSuccess(notes);
  }

  void _sortNotesByTime(List<NoteData> noteList) =>
      noteList.sort((a, b) => b.editTime.compareTo(a.editTime));
}
