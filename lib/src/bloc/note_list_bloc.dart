import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_storage/saf.dart' as saf;

import '../model/note_data.dart';
import '../model/note_list_file.dart';
import '../repository/notes_repository.dart';

part 'note_list_state.dart';
part 'note_list_event.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final NotesRepository _repository;

  List<NoteData> get notes => _repository.notes;

  NoteListBloc(this._repository) : super(NoteListInitial(_repository.notes)) {
    on<NoteListLoaded>(_onListLoaded);
    on<NoteListUpdated>(_onListUpdated);
    on<NoteListItemDeleted>(_onListItemDeleted);
    on<NoteListExported>(_onListExported);
    on<NoteListImportFilesStarted>(_onListImportFilesStarted);
    on<NoteListImportFilesLoaded>(_onListImportFilesLoaded);
    on<NoteListImported>(_onListImported);
  }

  Future<void> _onListLoaded(
      NoteListLoaded event, Emitter<NoteListState> emit) async {
    emit(NoteListLoadSuccess(notes));
  }

  Future<void> _onListUpdated(
      NoteListUpdated event, Emitter<NoteListState> emit) async {
    emit(NoteListUpdateSuccess(notes));
  }

  Future<void> _onListItemDeleted(
      NoteListItemDeleted event, Emitter<NoteListState> emit) async {
    notes.remove(event.note);
    await _repository.writeNotes();

    emit(NoteListItemDeleteSuccess(notes));
  }

  Future<void> _onListExported(
      NoteListExported event, Emitter<NoteListState> emit) async {
    final Uri? directory = await saf.openDocumentTree();
    bool success = false;

    if (directory != null) {
      success = await _repository.writeNotes(directory);
    }

    if (success) {
      emit(NoteListExportSuccess(notes));
    } else {
      emit(NoteListExportFailure(notes));
    }
  }

  Future<void> _onListImportFilesStarted(
      NoteListImportFilesStarted event, Emitter<NoteListState> emit) async {
    final Uri? directory =
        await saf.openDocumentTree(grantWritePermission: false);

    if (directory == null) {
      emit(NoteListImportFileStartFailure(notes));
      return;
    }

    final List<NoteListFile> files = [];

    final Stream<saf.DocumentFile> onNewFileLoaded =
        saf.listFiles(directory, columns: [
      saf.DocumentFileColumn.displayName,
      saf.DocumentFileColumn.mimeType,
    ]);

    onNewFileLoaded.listen(
      (file) {
        if ((file.type ?? '').isEmpty ||
            (file.name ?? '').isEmpty ||
            file.type != 'text/plain') {
          return;
        }

        files.add(NoteListFile(name: file.name!, uri: file.uri));
      },
      onDone: () {
        add(NoteListImportFilesLoaded(files));
      },
    );
  }

  Future<void> _onListImportFilesLoaded(
      NoteListImportFilesLoaded event, Emitter<NoteListState> emit) async {
    emit(NoteListImportFileLoadSuccess(notes, event.files));
  }

  Future<void> _onListImported(
      NoteListImported event, Emitter<NoteListState> emit) async {
    final success = await _repository.readNotes(event.file);

    if (success) {
      await _repository.writeNotes();
      emit(NoteListImportSuccess(notes));
    } else {
      emit(NoteListImportFailure(notes));
    }
  }
}
