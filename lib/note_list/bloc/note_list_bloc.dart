import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_repository/note_repository.dart';

part 'note_list_state.dart';
part 'note_list_event.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc({required NoteRepository repository})
      : _repository = repository,
        super(const NoteListState()) {
    on<NoteListLoaded>(_onListLoaded);
    on<NoteListItemDeleted>(_onItemDeleted);
    on<NoteListExported>(_onListExported);
    on<NoteListImported>(_onListImported);
  }

  final NoteRepository _repository;

  Future<void> _onListLoaded(
    NoteListLoaded event,
    Emitter<NoteListState> emit,
  ) async {
    emit(state.copyWith(status: NoteListStatus.loading));

    final notes = await _repository.readNotes();

    emit(
      state.copyWith(
        status: NoteListStatus.success,
        notes: notes,
      ),
    );
  }

  Future<void> _onItemDeleted(
    NoteListItemDeleted event,
    Emitter<NoteListState> emit,
  ) async {
    emit(state.copyWith(status: NoteListStatus.loading));

    try {
      await _repository.deleteNote(event.noteId);
      final notes = await _repository.readNotes();

      emit(
        state.copyWith(
          status: NoteListStatus.success,
          notes: notes,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: NoteListStatus.failure));
    }
  }

  Future<void> _onListExported(
    NoteListExported event,
    Emitter<NoteListState> _,
  ) async {
    // TODO(Frank): Add success or failure
    //await _repository.saveNotesToFile(event.directory);
  }

  Future<void> _onListImported(
    NoteListImported event,
    Emitter<NoteListState> _,
  ) async {
    // TODO(Frank): Add success or failure
    //await _repository.readNotesFromFile(event.filePath);
  }
}
