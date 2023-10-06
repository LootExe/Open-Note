// ignore_for_file: prefer_const_constructors
import 'package:note_provider/note_provider.dart';
import 'package:test/test.dart';

class TestNoteProvider implements NoteProvider {
  TestNoteProvider() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('NoteProvider', () {
    test('can be constructed', () {
      expect(TestNoteProvider.new, returnsNormally);
    });
  });
}
