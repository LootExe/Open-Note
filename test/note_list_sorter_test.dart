import 'package:note_repository/note_repository.dart';
import 'package:open_note/src/note_overview/util/note_list_sorter.dart';
import 'package:test/test.dart';

void main() {
  test('sortManual should return empty list on empty inputs', () {
    const List<Note> notes = [];
    const List<String> order = [];

    final result = NoteListSorter.sortManual(notes, order);

    expect(result, isEmpty);
  });

  test('sortManual should return non-empty list on inputs', () {
    final List<Note> notes = [TextNote(title: 'note1')];
    final List<String> order = [notes.first.id];

    final result = NoteListSorter.sortManual(notes, order);

    expect(result, isNotEmpty);
  });

  test('sortManual should return notes sorted by order', () {
    final List<Note> notes = [
      TextNote(title: 'note1'),
      TextNote(title: 'note2'),
      TextNote(title: 'note3'),
    ];
    final List<String> order = [
      notes[2].id,
      notes[1].id,
      notes[0].id,
    ];

    final result = NoteListSorter.sortManual(notes, order);

    expect(result.length, 3);
    expect(result[0], notes[2]);
    expect(result[1], notes[1]);
    expect(result[2], notes[0]);
  });

  test('sortManual should return notes with invalid inputs', () {
    final List<Note> notes = [
      TextNote(title: 'note1'),
      TextNote(title: 'note2'),
      TextNote(title: 'note3'),
    ];
    final List<String> order = [
      notes[2].id,
      notes[1].id,
      'Invalid Id',
    ];

    final result = NoteListSorter.sortManual(notes, order);

    expect(result.length, 3);
    expect(result[0], notes[2]);
    expect(result[1], notes[1]);
    expect(result[2], notes[0]);
  });

  test(
      'sortManual should add notes, that are not in the order list, at the end',
      () {
    final List<Note> notes = [
      TextNote(title: 'note1'),
      TextNote(title: 'note2'),
      TextNote(title: 'note3'),
    ];
    final List<String> order = [
      notes[2].id,
      notes[0].id,
    ];

    final result = NoteListSorter.sortManual(notes, order);

    expect(result.length, 3);
    expect(result[0], notes[2]);
    expect(result[1], notes[0]);
    expect(result[2], notes[1]);
  });

  test('sortManual should ignore ids, that does not have a corresponding note',
      () {
    final List<Note> notes = [
      TextNote(title: 'note1'),
      TextNote(title: 'note2'),
      TextNote(title: 'note3'),
    ];
    final List<String> order = [
      notes[2].id,
      'Another id',
      notes[1].id,
      notes[0].id,
    ];

    final result = NoteListSorter.sortManual(notes, order);

    expect(result.length, 3);
    expect(result[0], notes[2]);
    expect(result[1], notes[1]);
    expect(result[2], notes[0]);
  });
}
