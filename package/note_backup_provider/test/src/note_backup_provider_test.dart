// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:note_backup_provider/note_backup_provider.dart';
import 'package:note_provider/note_provider.dart';
import 'package:test/test.dart';

void main() {
  group('NoteBackupProvider', () {
    late FileSystem fileSystem;

    const file = 'test/notes.txt';

    final notes = [
      TextNote(
        id: '1',
        title: 'note 1',
        editTime: DateTime(2023, 09, 15),
        content: 'content 1',
      ),
      TodoNote(
        id: '2',
        title: 'note 2',
        editTime: DateTime(2023, 09, 16),
        items: [TodoItem(id: '11', text: 'todo item', isChecked: true)],
      ),
      TextNote(
        id: '3',
        title: 'note 3',
        editTime: DateTime(2023, 09, 17),
        content: 'content 2',
      ),
    ];

    setUp(() {
      fileSystem = MemoryFileSystem();
      fileSystem.directory('test').createSync(recursive: true);
    });

    NoteBackupProvider createSubject() {
      return NoteBackupProvider(fileSystem: fileSystem);
    }

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('readNotes', () {
      test('with existing notes if present', () {
        fileSystem.file(file).writeAsStringSync(json.encode(notes));

        final subject = createSubject();

        expect(subject.readNotes(file), completion(equals(notes)));
      });

      test('throws if file has no json content', () {
        fileSystem.file(file).writeAsStringSync('');

        final subject = createSubject();

        expect(
          subject.readNotes(file),
          throwsA(const TypeMatcher<FormatException>()),
        );
      });

      test('throws if file does not exists', () {
        final subject = createSubject();

        expect(
          subject.readNotes('directory/random.txt'),
          throwsA(const TypeMatcher<FileSystemException>()),
        );
      });
    });

    group('saveNotes', () {
      test('works properly with notes', () {
        final subject = createSubject();

        expect(subject.saveNotes(file, notes), completes);
      });

      test('works properly with empty list of notes', () {
        final subject = createSubject();

        expect(subject.saveNotes(file, const []), completes);
      });

      test('throws if the file path is wrong', () {
        final subject = createSubject();

        expect(
          subject.saveNotes('directory/random.txt', notes),
          throwsA(const TypeMatcher<FileSystemException>()),
        );
      });
    });
  });
}
