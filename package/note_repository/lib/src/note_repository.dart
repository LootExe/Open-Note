import 'package:note_backup_provider/note_backup_provider.dart';
import 'package:note_provider/note_provider.dart';

/// {@template note_repository}
/// A repository that handles note related requests.
/// {@endtemplate}
class NoteRepository {
  /// {@macro note_repository}
  const NoteRepository({
    required NoteProvider noteProvider,
    required NoteBackupProvider backupProvider,
  })  : _noteProvider = noteProvider,
        _backupProvider = backupProvider;

  final NoteProvider _noteProvider;
  final NoteBackupProvider _backupProvider;

  /// Read all notes from the provider.
  /// Returns a `Future<List<Note>>` that completes once the notes are read.
  Future<List<Note>> readNotes() => _noteProvider.readNotes();

  /// Saves a new [Note] or updates an existing one.
  /// Returns a `Future` that completes once the saving is complete.
  Future<void> saveNote(Note note) => _noteProvider.saveNote(note);

  /// Deletes a [Note] with the given [id].
  /// If no note with the given id exists, a [NoteNotFoundException]
  /// error is thrown.
  Future<void> deleteNote(String id) => _noteProvider.deleteNote(id);

  /// Read all notes from a file.
  /// Returns a `Future<List<Note>>` that completes once
  /// the file content has been read.
  Future<List<Note>> readNotesFromFile(String file) =>
      _backupProvider.readNotes(file);

  /// Save all notes to a file.
  /// Returns a `Future` that completes once the file content has been written.
  Future<void> saveNotesToFile(String file, List<Note> notes) =>
      _backupProvider.saveNotes(file, notes);
}
