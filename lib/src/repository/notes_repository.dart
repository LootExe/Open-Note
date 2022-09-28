import 'dart:convert';

import 'package:intl/intl.dart';

import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';
import '../provider/file_provider.dart';
import '../provider/storage_provider.dart';

class NotesRepository {
  static const String _storageKey = 'notes';

  final List<NoteData> notes = [];

  NoteData? _jsonToNoteData(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return null;
    }

    try {
      final type = (json['type'] as String).toLowerCase();

      final noteType =
          NoteType.values.firstWhere((e) => e.toString() == 'NoteType.$type');

      switch (noteType) {
        case NoteType.todo:
          return TodoData.fromJson(json);
        case NoteType.text:
          return TextData.fromJson(json);
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> readNotes([Uri? fromFile]) async {
    String json = '';

    if (fromFile == null) {
      json = await StorageProvider.readEntry(_storageKey);
    } else {
      json = await FileProvider.readFile(fromFile);
    }

    if (json.isEmpty) {
      return false;
    }

    notes.clear();

    try {
      final decodedList = jsonDecode(json);

      for (Map<String, dynamic> entry in decodedList) {
        final note = _jsonToNoteData(entry);

        if (note != null) {
          notes.add(note);
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> writeNotes([Uri? toDirectory]) async {
    String json = '';

    try {
      json = jsonEncode(notes);
    } catch (e) {
      return false;
    }

    if (toDirectory == null) {
      return await StorageProvider.writeEntry(_storageKey, json);
    } else {
      final timestamp = DateFormat('yyyyMMdd_hhmm').format(DateTime.now());
      final filename = 'note_export_$timestamp.txt';

      return await FileProvider.writeFile(
        directory: toDirectory,
        filename: filename,
        content: json,
      );
    }
  }
}
