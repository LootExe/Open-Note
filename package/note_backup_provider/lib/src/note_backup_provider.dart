import 'dart:convert';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:note_provider/note_provider.dart';

/// {@template note_backup_provider}
/// A provider that handles note backups to and from file.
/// {@endtemplate}
class NoteBackupProvider {
  /// {@macro note_backup_provider}
  const NoteBackupProvider({FileSystem fileSystem = const LocalFileSystem()})
      : _fileSystem = fileSystem;

  final FileSystem _fileSystem;

  /// Reads all notes from the file.
  /// Returns a `Future<List<Note>>` that completes with the notes
  /// once the file content has been read.
  Future<List<Note>> readNotes(String file) async {
    final jsonString = await _fileSystem.file(file).readAsString();
    final notes = <Note>[];

    try {
      final jsonObject = json.decode(jsonString) as List<dynamic>;
      final jsonList = List<JsonMap>.from(jsonObject);

      for (final entry in jsonList) {
        if (entry.containsKey('content')) {
          notes.add(TextNote.fromJson(entry));
        } else if (entry.containsKey('items')) {
          notes.add(TodoNote.fromJson(entry));
        }
      }
    } catch (e) {
      throw const FormatException('Wron Json format.');
    }

    return notes;
  }

  /// Writes all notes to a file.
  /// Returns a `Future` that completes once the content has been written.
  Future<void> saveNotes(String file, List<Note> notes) async {
    final jsonString = json.encode(notes);

    await _fileSystem.file(file).writeAsString(
          jsonString,
          mode: FileMode.writeOnly,
        );
  }
}
