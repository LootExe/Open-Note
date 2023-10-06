// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:local_note_provider/local_note_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:note_provider/note_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LocalNoteProvider', () {
    late SharedPreferences plugin;

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
      plugin = MockSharedPreferences();
      when(() => plugin.getString(any())).thenReturn(json.encode(notes));
      when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
    });

    LocalNoteProvider createSubject() {
      return LocalNoteProvider(plugin: plugin);
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
        final subject = createSubject();

        expect(subject.readNotes(), completion(equals(notes)));
        verify(
          () => plugin.getString(LocalNoteProvider.kNotesKey),
        ).called(1);
      });

      test('with empty list if no notes present', () {
        when(() => plugin.getString(any())).thenReturn(null);

        final subject = createSubject();

        expect(subject.readNotes(), completion(equals(const <Note>[])));
        verify(
          () => plugin.getString(LocalNoteProvider.kNotesKey),
        ).called(1);
      });

      test('with empty list if corrupted json', () {
        when(() => plugin.getString(any())).thenReturn('corrupted date');

        final subject = createSubject();

        expect(subject.readNotes(), completion(equals(const <Note>[])));
        verify(
          () => plugin.getString(LocalNoteProvider.kNotesKey),
        ).called(1);
      });
    });

    group('saveNote', () {
      test('saves new note', () {
        final newNote = TextNote(
          id: '4',
          title: 'note 4',
          content: 'content 4',
        );

        final newNotes = [...notes, newNote];

        final subject = createSubject();

        expect(subject.saveNote(newNote), completes);
        expect(subject.readNotes(), completion(equals(newNotes)));

        verify(
          () => plugin.setString(
            LocalNoteProvider.kNotesKey,
            json.encode(newNotes),
          ),
        ).called(1);
      });

      test('updates existing note', () {
        final updatedNote = TextNote(
          id: '1',
          title: 'new title 1',
          content: 'new content 1',
        );
        final newNotes = [updatedNote, ...notes.sublist(1)];

        final subject = createSubject();

        expect(subject.saveNote(updatedNote), completes);
        expect(subject.readNotes(), completion(equals(newNotes)));

        verify(
          () => plugin.setString(
            LocalNoteProvider.kNotesKey,
            json.encode(newNotes),
          ),
        ).called(1);
      });
    });

    group('deleteNote', () {
      test('deletes existing note', () {
        final newNotes = notes.sublist(1);

        final subject = createSubject();

        expect(subject.deleteNote(notes[0].id), completes);
        expect(subject.readNotes(), completion(equals(newNotes)));

        verify(
          () => plugin.setString(
            LocalNoteProvider.kNotesKey,
            json.encode(newNotes),
          ),
        ).called(1);
      });

      test(
        'throws NoteNotFoundException if note '
        'with provided id is not found',
        () {
          final subject = createSubject();

          expect(
            () => subject.deleteNote('non-existing-id'),
            throwsA(isA<NoteNotFoundException>()),
          );
        },
      );
    });
  });
}
