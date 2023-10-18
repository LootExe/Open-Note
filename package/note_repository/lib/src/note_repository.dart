import 'dart:convert';

import 'package:note_repository/src/model/note.dart';
import 'package:storage_provider/storage_provider.dart';

/// {@template note_repository}
/// A repository that handles note requests
/// {@endtemplate}
class NoteRepository {
  /// {@macro note_repository}
  NoteRepository({required StorageProvider provider})
      : _provider = provider,
        notes = <Note>[];

  final StorageProvider _provider;

  /// List of `Note`. Load them via `readNotes()`.
  final List<Note> notes;

  /// Read the `List<Note>` from the storage provider.
  /// Stores them in [notes].
  /// Returns a `Future` that completes once the notes have been read.
  Future<List<Note>> readNotes() async {
    notes.clear();
    final keys = await _provider.readKeys() ?? {};

    for (final key in keys) {
      final value = await _provider.read(key);

      if (value == null || value.isEmpty) {
        continue;
      }

      try {
        final jsonObject = json.decode(value) as JsonMap;

        if (jsonObject.containsKey('content')) {
          notes.add(TextNote.fromJson(jsonObject));
        } else if (jsonObject.containsKey('items')) {
          notes.add(TodoNote.fromJson(jsonObject));
        }
      } catch (e) {
        continue;
      }
    }

    return notes;
  }

  /// Write the [notes] to the storage provider.
  /// Returns a `Future` that completes once the notes have been written.
  Future<void> writeNotes(List<Note> notes) async {
    for (final note in notes) {
      final value = json.encode(note);
      await _provider.write(note.id, value);
    }

    final newNotes = List<Note>.from(notes);
    this.notes.clear();
    this.notes.addAll(newNotes);
  }

  /// Clears all notes from the storage provider.
  /// Returns a `Future` that completes once the storage has been cleared.
  Future<void> clearNotes() {
    notes.clear();
    return _provider.clear();
  }

  /// Writes the [note] to the storage provider. If an existing note can't be
  /// found, the note is added to the end of the note list.
  /// Returns a `Future` that completes once the note has been written.
  Future<void> writeNote(Note note) {
    final index = notes.indexWhere((n) => n.id == note.id);

    if (index >= 0) {
      notes[index] = note.copyWith();
    } else {
      notes.add(note);
    }

    return writeNotes(notes);
  }

  /// Deletes the note with the given [id] from the storage provider.
  /// Returns a `Future` that completes once the note has been deleted.
  Future<void> deleteNote(String id) async {
    final index = notes.indexWhere((n) => n.id == id);

    if (index >= 0) {
      notes.removeAt(index);
      return writeNotes(notes);
    }
  }
}
