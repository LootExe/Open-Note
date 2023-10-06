import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:note_provider/note_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_note_provider}
/// An implementation of the NoteProvider that uses local storage.
/// {@endtemplate}
class LocalNoteProvider extends NoteProvider {
  /// {@macro local_note_provider}
  LocalNoteProvider({required SharedPreferences plugin})
      : _plugin = plugin,
        _notes = <Note>[] {
    _initialize();
  }

  /// Shared preferences key for accessing notes.
  @visibleForTesting
  static const kNotesKey = 'sharedPreferencesNotes';

  final SharedPreferences _plugin;
  final List<Note> _notes;

  @override
  Future<List<Note>> readNotes() => Future.value(_notes);

  @override
  Future<void> saveNote(Note note) {
    final index = _notes.indexWhere((n) => n.id == note.id);

    if (index >= 0) {
      _notes[index] = note;
    } else {
      _notes.add(note);
    }

    return _plugin.setString(kNotesKey, json.encode(_notes));
  }

  @override
  Future<void> deleteNote(String id) {
    final noteIndex = _notes.indexWhere((n) => n.id == id);

    if (noteIndex >= 0) {
      _notes.removeAt(noteIndex);

      return _plugin.setString(kNotesKey, json.encode(_notes));
    } else {
      throw NoteNotFoundException();
    }
  }

  void _initialize() {
    final jsonString = _plugin.getString(kNotesKey);

    if (jsonString == null || jsonString.isEmpty) {
      return;
    }

    try {
      _notes.clear();
      final jsonObject = json.decode(jsonString) as List<dynamic>;
      final jsonList = List<JsonMap>.from(jsonObject);

      for (final entry in jsonList) {
        if (entry.containsKey('content')) {
          _notes.add(TextNote.fromJson(entry));
        } else if (entry.containsKey('items')) {
          _notes.add(TodoNote.fromJson(entry));
        }
      }
    } catch (e) {
      return;
    }
  }
}
