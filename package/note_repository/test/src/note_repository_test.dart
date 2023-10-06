// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:note_backup_provider/note_backup_provider.dart';
import 'package:note_provider/note_provider.dart';
import 'package:note_repository/note_repository.dart';
import 'package:test/test.dart';

class MockNoteProvider extends Mock implements NoteProvider {}

class MockBackupProvider extends Mock implements NoteBackupProvider {}

class FakeNote extends Fake implements Note {}

void main() {
  group('NoteRepository', () {
    late NoteProvider noteProvider;
    late NoteBackupProvider backupProvider;

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

    setUpAll(() {
      registerFallbackValue(FakeNote());
    });

    setUp(() {
      noteProvider = MockNoteProvider();
      backupProvider = MockBackupProvider();

      when(() => noteProvider.readNotes())
          .thenAnswer((_) => Future.value(notes));
      when(() => noteProvider.saveNote(any())).thenAnswer((_) async {});
      when(() => noteProvider.deleteNote(any())).thenAnswer((_) async {});
      when(() => backupProvider.readNotes(any()))
          .thenAnswer((_) => Future.value(notes));
      when(() => backupProvider.saveNotes(any(), any()))
          .thenAnswer((_) async {});
    });

    NoteRepository createSubject() => NoteRepository(
          noteProvider: noteProvider,
          backupProvider: backupProvider,
        );

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('readNotes', () {
      test('makes correct provider request', () {
        expect(
          createSubject().readNotes(),
          completion(equals(notes)),
        );

        verify(() => noteProvider.readNotes()).called(1);
      });
    });

    group('saveNote', () {
      test('makes correct provider request', () {
        final newNote = TextNote(
          id: '4',
          title: 'note 4',
          content: 'content 4',
        );

        final subject = createSubject();

        expect(subject.saveNote(newNote), completes);

        verify(() => noteProvider.saveNote(newNote)).called(1);
      });
    });

    group('deleteNote', () {
      test('makes correct provider request', () {
        final subject = createSubject();

        expect(subject.deleteNote(notes[0].id), completes);

        verify(() => noteProvider.deleteNote(notes[0].id)).called(1);
      });
    });

    group('readNotesFromFile', () {
      test('makes correct provider request', () {
        final subject = createSubject();

        expect(subject.readNotesFromFile(file), completion(equals(notes)));

        verify(() => backupProvider.readNotes(file)).called(1);
      });
    });

    group('saveNotesToFile', () {
      test('makes correct provider request', () {
        final subject = createSubject();

        expect(subject.saveNotesToFile(file, notes), completes);

        verify(() => backupProvider.saveNotes(file, notes)).called(1);
      });
    });
  });
}
