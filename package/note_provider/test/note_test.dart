import 'dart:convert';

import 'package:note_provider/note_provider.dart';
import 'package:test/test.dart';

void main() {
  group('TextNote tests', () {
    test('toString returns content', () {
      const content = 'This is a text note';
      final note = TextNote(title: 'Text Note', content: content);

      final result = note.toString();

      expect(result, content);
    });

    test('Encode to json returns non-null String', () {
      final result = jsonEncode(TextNote(title: 'Text Note'));
      expect(result, isNotNull);
    });

    test('Encode to json returns non-empty String', () {
      final result = jsonEncode(TextNote(title: 'Text Note'));
      expect(result, isNotEmpty);
    });

    test('Encode to json returns valid json String', () {
      final note = TextNote(title: 'textNote', content: 'text note content');
      final result = jsonEncode(note);

      expect(result, contains('id'));
      expect(result, contains('textNote'));
      expect(result, contains('text note content'));
    });

    test('Decode from json returns TextNote', () {
      const jsonString =
          '{"title": "textNote", "content": "text note content"}';

      final jsonObject = json.decode(jsonString) as JsonMap;
      final result = TextNote.fromJson(jsonObject);

      expect(result.title, 'textNote');
      expect(result.content, 'text note content');
    });
  });

  group('TodoNote tests', () {
    test('toString returns items with comma separated', () {
      final items = [
        TodoItem(text: 'item1', isChecked: false),
        TodoItem(text: 'item2', isChecked: true),
      ];
      final note = TodoNote(title: 'Todo Note', items: items);

      final result = note.toString();

      expect(result, 'item1, item2');
    });

    test('Encode to json returns non-null String', () {
      final result = jsonEncode(TodoNote(title: 'Todo Note'));
      expect(result, isNotNull);
    });

    test('Encode to json returns non-empty String', () {
      final result = jsonEncode(TodoNote(title: 'Todo Note'));
      expect(result, isNotEmpty);
    });

    test('Encode to json returns valid json String', () {
      final note = TodoNote(
          title: 'todoNote', items: [TodoItem(text: 'item', isChecked: true)]);
      final result = jsonEncode(note);

      expect(result, contains('id'));
      expect(result, contains('todoNote'));
      expect(result, contains('"text":"item","isChecked":true'));
    });

    test('Decode from json returns TodoNote', () {
      const jsonString =
          '{"title":"todoNote","items":[{"text":"item","isChecked":true}]}';

      final jsonObject = json.decode(jsonString) as JsonMap;
      final result = TodoNote.fromJson(jsonObject);

      expect(result.title, 'todoNote');
      expect(result.items.length, 1);
      expect(result.items[0].text, 'item');
      expect(result.items[0].isChecked, true);
    });
  });
}
