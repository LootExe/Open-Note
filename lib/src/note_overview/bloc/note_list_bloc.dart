import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_repository/note_repository.dart';

part 'note_list_state.dart';
part 'note_list_event.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final NoteRepository _repository;

  NoteListBloc({required NoteRepository repository})
      : _repository = repository,
        super(NoteListState(notes: [...repository.notes])) {
    on<NoteListUpdated>(_onListUpdated);
    on<NoteListItemDeleted>(_onItemDeleted);
    on<NoteListExported>(_onListExported);
    on<NoteListImported>(_onListImported);
  }

  void _onListUpdated(NoteListUpdated event, Emitter<NoteListState> emit) {
    emit(state.copyWith(notes: [..._repository.notes]));
  }

  Future<void> _onItemDeleted(
      NoteListItemDeleted event, Emitter<NoteListState> emit) async {
    await _repository.deleteNote(event.noteId);
    emit(state.copyWith(notes: [..._repository.notes]));
  }

  Future<void> _onListExported(
      NoteListExported event, Emitter<NoteListState> _) async {
    await _repository.saveNotesToFile(event.directory);
  }

  Future<void> _onListImported(
      NoteListImported event, Emitter<NoteListState> _) async {
    await _repository.readNotesFromFile(event.filePath);
  }
}
