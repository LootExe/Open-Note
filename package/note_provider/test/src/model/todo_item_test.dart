// ignore_for_file: avoid_redundant_argument_values

import 'package:note_provider/src/model/note.dart';
import 'package:test/test.dart';

void main() {
  group('TodoItem tests', () {
    TodoItem createSubject({
      String? id = '1',
      String text = 'text',
      bool isChecked = true,
    }) {
      return TodoItem(
        id: id,
        text: text,
        isChecked: isChecked,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      test('throws AssertionError when id is empty', () {
        expect(
          () => createSubject(id: ''),
          throwsA(isA<AssertionError>()),
        );
      });

      test('sets id if not provided', () {
        expect(
          createSubject(id: null).id,
          isNotEmpty,
        );
      });
    });

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals([
          '1', // id
          'text', // text
          true, // isChecked
        ]),
      );
    });

    group('copyWith', () {
      test('returns the same object if no arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            id: null,
            text: null,
            isChecked: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            id: '2',
            text: 'new text',
            isChecked: false,
          ),
          equals(
            createSubject(
              id: '2',
              text: 'new text',
              isChecked: false,
            ),
          ),
        );
      });
    });

    group('Json serialization', () {
      test('from Json works correctly', () {
        expect(
          TodoItem.fromJson(const <String, dynamic>{
            'id': '1',
            'text': 'text',
            'isChecked': true,
          }),
          equals(createSubject()),
        );
      });

      test('to Json works correctly', () {
        expect(
          createSubject().toJson(),
          equals(<String, dynamic>{
            'id': '1',
            'text': 'text',
            'isChecked': true,
          }),
        );
      });
    });

    test('toString returns the item text', () {
      expect(
        createSubject().toString(),
        equals('text'),
      );
    });
  });
}
