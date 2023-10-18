import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_repository/note_repository.dart';

part 'note_list_state.dart';
part 'note_list_event.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc({required NoteRepository repository})
      : _repository = repository,
        super(NoteListState(notes: List.of(repository.notes))) {
    on<NoteListChanged>(_onListChanged);
    on<NoteListItemDeleted>(_onNoteDeleted);
  }

  final NoteRepository _repository;

  Future<void> _onListChanged(
    NoteListChanged event,
    Emitter<NoteListState> emit,
  ) async {
    emit(state.copyWith(notes: List.of(_repository.notes)));
  }

  Future<void> _onNoteDeleted(
    NoteListItemDeleted event,
    Emitter<NoteListState> emit,
  ) async {
    await _repository.deleteNote(event.noteId);
    emit(state.copyWith(notes: List.of(_repository.notes)));
  }
}
