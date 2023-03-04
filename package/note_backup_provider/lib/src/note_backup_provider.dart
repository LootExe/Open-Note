import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:note_provider/note_provider.dart';
import 'package:path/path.dart' as path;

class NoteBackupProvider {
  Future<void> saveNotes(List<Note> notes, String directory) async {
    assert(directory.isNotEmpty);

    final dateString = DateFormat('y-MM-dd_HH-mm-ss').format(DateTime.now());
    final filename = 'noteezy_backup_$dateString.txt';
    final fullPath = path.join(directory, filename);
    final jsonString = json.encode(notes);

    await File(fullPath).writeAsString(
      jsonString,
      mode: FileMode.writeOnly,
    );
  }

  Future<List<Note>> readNotes(String file) async {
    assert(file.isNotEmpty);
    final jsonString = await File(file).readAsString();

    try {
      final jsonObject = json.decode(jsonString);
      final List<Note> notes = [];

      for (JsonMap entry in jsonObject) {
        if (entry.containsKey('content')) {
          notes.add(TextNote.fromJson(entry));
        } else if (entry.containsKey('items')) {
          notes.add(TodoNote.fromJson(entry));
        }
      }

      return notes;
    } on FormatException {
      return [];
    }
  }
}
