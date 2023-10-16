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
    this.notes.clear();
    this.notes.addAll(notes);

    for (final note in notes) {
      final value = json.encode(note);
      await _provider.write(note.id, value);
    }
  }

  /// Clears all notes from the storage provider.
  /// Returns a `Future` that completes once the storage has been cleared.
  Future<void> clearNotes() {
    notes.clear();
    return _provider.clear();
  }
}
