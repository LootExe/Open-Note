import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:note_provider/note_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNoteProvider extends NoteProvider {
  @visibleForTesting
  static const kNotesKey = 'notesKey';

  final SharedPreferences _plugin;
  final List<Note> _notes = [];

  LocalNoteProvider({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _initialize();
  }

  @override
  List<Note> getNotes() => _notes;

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

    final jsonObject = json.decode(jsonString);

    for (JsonMap entry in jsonObject) {
      if (entry.containsKey('content')) {
        _notes.add(TextNote.fromJson(entry));
      } else if (entry.containsKey('items')) {
        _notes.add(TodoNote.fromJson(entry));
      }
    }
  }
}
