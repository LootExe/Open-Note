// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:note_repository/note_repository.dart';
import 'package:storage_provider/storage_provider.dart';
import 'package:test/test.dart';

class MockStorageProvider extends Mock implements StorageProvider {}

void main() {
  group('NoteRepository', () {
    late StorageProvider provider;

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
      provider = MockStorageProvider();
      when(() => provider.read(notes[0].id))
          .thenAnswer((_) => Future.value(json.encode(notes[0])));
      when(() => provider.read(notes[1].id))
          .thenAnswer((_) => Future.value(json.encode(notes[1])));
      when(() => provider.read(notes[2].id))
          .thenAnswer((_) => Future.value(json.encode(notes[2])));
      when(() => provider.readKeys())
          .thenAnswer((_) => Future.value({'1', '2', '3'}));
      when(() => provider.write(any(), any())).thenAnswer((_) async {});
      when(() => provider.clear()).thenAnswer((_) async {});
    });

    NoteRepository createSubject() => NoteRepository(provider: provider);

    group('constructor', () {
      test('works properly', () {
        expect(createSubject, returnsNormally);
      });
    });

    group('readNotes', () {
      test('returns empty list if storage is empty', () {
        when(() => provider.readKeys()).thenAnswer((_) => Future.value());

        expect(createSubject().readNotes(), completion([]));

        verify(() => provider.readKeys()).called(1);
        verifyNever(() => provider.read(any()));
      });

      test('returns correct notes from storage', () async {
        final readNotes = await createSubject().readNotes();

        expect(readNotes, notes);

        verify(() => provider.readKeys()).called(1);
        verify(() => provider.read(any())).called(3);
      });

      test('skips notes that have no data', () async {
        when(() => provider.read(notes[1].id))
            .thenAnswer((_) => Future.value());

        final readNotes = await createSubject().readNotes();

        expect(readNotes, [notes[0], notes[2]]);

        verify(() => provider.readKeys()).called(1);
        verify(() => provider.read(any())).called(3);
      });

      test('skips notes with empty json data', () async {
        when(() => provider.read(notes[1].id))
            .thenAnswer((_) => Future.value(''));

        final readNotes = await createSubject().readNotes();

        expect(readNotes, [notes[0], notes[2]]);

        verify(() => provider.readKeys()).called(1);
        verify(() => provider.read(any())).called(3);
      });

      test('skips notes with corrupted json data', () async {
        when(() => provider.read(notes[1].id))
            .thenAnswer((_) => Future.value('ooops'));

        final readNotes = await createSubject().readNotes();

        expect(readNotes, [notes[0], notes[2]]);

        verify(() => provider.readKeys()).called(1);
        verify(() => provider.read(any())).called(3);
      });

      test('updates public member `notes`', () async {
        final subject = createSubject();
        expect(subject.notes, <String>[]);

        await subject.readNotes();

        expect(subject.notes, notes);

        verify(() => provider.readKeys()).called(1);
        verify(() => provider.read(any())).called(3);
      });
    });

    group('writeNotes', () {
      test('makes correct provider request', () async {
        await createSubject().writeNotes(notes);

        //expect(result, completes);
        verify(() => provider.write(any(), any())).called(3);
      });

      test('updates public member `notes`', () async {
        final subject = createSubject();
        expect(subject.notes, <String>[]);

        await subject.writeNotes(notes);

        expect(subject.notes, notes);
        verify(() => provider.write(any(), any())).called(3);
      });
    });

    group('clearNotes', () {
      test('makes correct provider request', () {
        expect(createSubject().clearNotes(), completes);
        verify(() => provider.clear()).called(1);
      });

      test('updates public member `notes`', () async {
        final subject = createSubject();
        await subject.readNotes();

        expect(subject.notes, notes);

        await subject.clearNotes();

        expect(subject.notes, <String>[]);
        verify(() => provider.clear()).called(1);
      });
    });

    group('writeNote', () {
      test('adds new note if current note does not exists in notes', () {
        final newNote = TextNote(
          id: '11',
          title: 'newNote',
          content: 'newContent',
        );

        expect(createSubject().writeNote(newNote), completes);
        verify(() => provider.write(any(), any())).called(1);
      });

      test('updates note if note already exists', () {
        final subject = createSubject();
        subject.notes.addAll(notes);

        final changedNote = notes[0].copyWith(title: 'updatedTitle');

        expect(subject.writeNote(changedNote), completes);
        expect(subject.notes[0], changedNote);
      });
    });

    group('deleteNote', () {
      test('deletes note if note exists', () {
        final subject = createSubject();
        subject.notes.addAll(notes);

        expect(subject.deleteNote(notes[0].id), completes);
        expect(subject.notes.length, 2);
      });

      test('does nothing if note does not exists', () {
        final subject = createSubject();
        subject.notes.addAll(notes);

        expect(subject.deleteNote('random ID'), completes);
        expect(subject.notes.length, 3);

        verifyNever(() => provider.write(any(), any()));
      });
    });
  });
}
