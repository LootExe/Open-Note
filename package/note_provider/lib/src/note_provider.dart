import 'package:note_provider/src/model/note.dart';

/// {@template note_provider}
/// The interface and models for an API providing access to notes.
/// {@endtemplate}
abstract class NoteProvider {
  /// Create a provider instance.
  const NoteProvider();

  /// Provides a [List] of all notes.
  Future<List<Note>> readNotes();

  /// Saves a [Note].
  ///
  /// If a [Note] with the same id already exists, it will be replaced.
  Future<void> saveNote(Note note);

  /// Deletes the [Note] with the given id.
  ///
  /// If no note with the given id exists, a [NoteNotFoundException] error is
  /// thrown.
  Future<void> deleteNote(String id);
}

/// Error thrown when a [Note] with a given id is not found.
class NoteNotFoundException implements Exception {}
