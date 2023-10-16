// ignore_for_file: avoid_redundant_argument_values

import 'package:note_repository/src/model/note.dart';
import 'package:test/test.dart';

void main() {
  group('TextNote tests', () {
    TextNote createSubject({
      String? id = '1',
      String title = 'title',
      DateTime? editTime,
      String content = 'content',
    }) {
      return TextNote(
        id: id,
        title: title,
        editTime: editTime ?? DateTime(2023, 09, 15),
        content: content,
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

      test('sets editTime if not provided', () {
        final note = TextNote(
          id: '1',
          title: 'title',
          content: 'content',
        );

        expect(
          note.editTime,
          isNotNull,
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
          'title', // title
          DateTime(2023, 09, 15), // editTime
          'content', // content
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
            title: null,
            editTime: null,
            content: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            id: '2',
            title: 'new title',
            editTime: DateTime(2000, 01, 01),
            content: 'new content',
          ),
          equals(
            createSubject(
              id: '2',
              title: 'new title',
              editTime: DateTime(2000, 01, 01),
              content: 'new content',
            ),
          ),
        );
      });
    });

    group('Json serialization', () {
      test('from Json works correctly', () {
        expect(
          TextNote.fromJson(<String, dynamic>{
            'id': '1',
            'title': 'title',
            'editTime': DateTime(2023, 09, 15).toIso8601String(),
            'content': 'content',
          }),
          equals(createSubject()),
        );
      });

      test('to Json works correctly', () {
        expect(
          createSubject().toJson(),
          equals(<String, dynamic>{
            'id': '1',
            'title': 'title',
            'editTime': DateTime(2023, 09, 15).toIso8601String(),
            'content': 'content',
          }),
        );
      });
    });

    test('toString returns the content text', () {
      expect(
        createSubject().toString(),
        equals('content'),
      );
    });
  });
}
