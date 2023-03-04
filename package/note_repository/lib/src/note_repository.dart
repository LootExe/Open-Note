import 'package:note_backup_provider/note_backup_provider.dart';
import 'package:note_provider/note_provider.dart';

class NoteRepository {
  final NoteProvider _noteProvider;
  final NoteBackupProvider _backupProvider;

  /// Provides a [List] of all [Note]s.
  List<Note> get notes => _noteProvider.getNotes();

  NoteRepository({
    required NoteProvider noteProvider,
    required NoteBackupProvider backupProvider,
  })  : _noteProvider = noteProvider,
        _backupProvider = backupProvider;

  /// Saves an updated [Note] or adds a new one.
  Future<void> saveNote(Note note) => _noteProvider.saveNote(note);

  /// Deletes a [Note] with the given [id].
  /// If no note with the given id exists, a [NoteNotFoundException] error is thrown.
  Future<void> deleteNote(String id) => _noteProvider.deleteNote(id);

  /// Saves all [Note]s into a file in the specified [directory].
  Future<void> saveNotesToFile(String directory) =>
      _backupProvider.saveNotes(notes, directory);

  /// Reads [Note]s from a [file]. Replaces all existing notes.
  Future<void> readNotesFromFile(String file) async {
    final newNotes = await _backupProvider.readNotes(file);

    if (newNotes.isEmpty) {
      return;
    }

    notes
      ..clear()
      ..addAll(newNotes);

    return _noteProvider.saveNote(notes.first);
  }
}
