import 'package:note_repository/note_repository.dart';
import 'package:open_note/note_list/util/note_list_sorter.dart';
import 'package:test/test.dart';

void main() {
  test('sortManual should return empty list on empty inputs', () {
    const notes = <Note>[];
    const order = <String>[];

    final result = sortManual(notes, order);

    expect(result, isEmpty);
  });

  test('sortManual should return non-empty list on inputs', () {
    final notes = <Note>[TextNote(title: 'note1')];
    final order = <String>[notes.first.id];

    final result = sortManual(notes, order);

    expect(result, isNotEmpty);
  });

  test('sortManual should return notes sorted by order', () {
    final notes = <Note>[
      TextNote(title: 'note1'),
      TextNote(title: 'note2'),
      TextNote(title: 'note3'),
    ];
    final order = <String>[
      notes[2].id,
      notes[1].id,
      notes[0].id,
    ];

    final result = sortManual(notes, order);

    expect(result.length, 3);
    expect(result[0], notes[2]);
    expect(result[1], notes[1]);
    expect(result[2], notes[0]);
  });

  test('sortManual should return notes with invalid inputs', () {
    final notes = <Note>[
      TextNote(title: 'note1'),
      TextNote(title: 'note2'),
      TextNote(title: 'note3'),
    ];
    final order = <String>[
      notes[2].id,
      notes[1].id,
      'Invalid Id',
    ];

    final result = sortManual(notes, order);

    expect(result.length, 3);
    expect(result[0], notes[2]);
    expect(result[1], notes[1]);
    expect(result[2], notes[0]);
  });

  test(
      'sortManual should add notes, that are not in the order list, at the end',
      () {
    final notes = <Note>[
      TextNote(title: 'note1'),
      TextNote(title: 'note2'),
      TextNote(title: 'note3'),
    ];
    final order = <String>[
      notes[2].id,
      notes[0].id,
    ];

    final result = sortManual(notes, order);

    expect(result.length, 3);
    expect(result[0], notes[2]);
    expect(result[1], notes[0]);
    expect(result[2], notes[1]);
  });

  test('sortManual should ignore ids, that does not have a corresponding note',
      () {
    final notes = <Note>[
      TextNote(title: 'note1'),
      TextNote(title: 'note2'),
      TextNote(title: 'note3'),
    ];
    final order = <String>[
      notes[2].id,
      'Another id',
      notes[1].id,
      notes[0].id,
    ];

    final result = sortManual(notes, order);

    expect(result.length, 3);
    expect(result[0], notes[2]);
    expect(result[1], notes[1]);
    expect(result[2], notes[0]);
  });
}
