import 'package:local_note_provider/local_note_provider.dart';
import 'package:note_provider/note_provider.dart';
import 'package:test/test.dart';

void main() {
  Future<void> setupPreferences(String key, String value) async {
    SharedPreferences.setMockInitialValues(
        <String, Object>{'flutter.$key': value});
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  setUp(() {
    setupPreferences(LocalNoteProvider.kNotesKey, '');
  });

  test('getNotes should return 2 entry', () async {
    setupPreferences(LocalNoteProvider.kNotesKey,
        '[{"title":"textNote","content":"text note content"},{"title":"todoNote","items":[{"text":"item","isChecked":true}]}]');

    final NoteProvider provider =
        LocalNoteProvider(plugin: await SharedPreferences.getInstance());

    final result = provider.getNotes().length;

    expect(result, 2);
  });

  test('getNotes should return 1 TextNote and 1 TodoNote', () async {
    setupPreferences(LocalNoteProvider.kNotesKey,
        '[{"title":"textNote","content":"text note content"},{"title":"todoNote","items":[{"text":"item","isChecked":true}]}]');

    final NoteProvider provider =
        LocalNoteProvider(plugin: await SharedPreferences.getInstance());

    final note1 = provider.getNotes().first;
    final note2 = provider.getNotes()[1];

    expect(note1, const TypeMatcher<TextNote>());
    expect(note2, const TypeMatcher<TodoNote>());
  });

  test('getNotes should return 1 TodoNote with 1 TodoItem', () async {
    setupPreferences(LocalNoteProvider.kNotesKey,
        '[{"title":"todoNote","items":[{"text":"item","isChecked":true}]}]');

    final NoteProvider provider =
        LocalNoteProvider(plugin: await SharedPreferences.getInstance());

    final result = provider.getNotes().first as TodoNote;

    expect(result.items.length, 1);
    expect(result.items.first.text, 'item');
    expect(result.items.first.isChecked, true);
  });

  test('saveNote increases List by 1', () async {
    final NoteProvider provider =
        LocalNoteProvider(plugin: await SharedPreferences.getInstance());
    final note = TextNote(title: 'textNote', content: 'text note content');

    await provider.saveNote(note);

    final result = provider.getNotes().length;

    expect(result, 1);
  });

  test('saveNote with existing note does not increase list length', () async {
    final NoteProvider provider =
        LocalNoteProvider(plugin: await SharedPreferences.getInstance());
    final note = TextNote(title: 'textNote', content: 'text note content');
    await provider.saveNote(note);

    await provider.saveNote(note.copyWith(title: 'changedNote'));

    final result = provider.getNotes().length;

    expect(result, 1);
  });

  test('saveNote and creating a new instance should return the same notes',
      () async {
    final NoteProvider provider =
        LocalNoteProvider(plugin: await SharedPreferences.getInstance());
    final note = TextNote(title: 'textNote', content: 'text note content');
    final note2 = TodoNote(title: 'todoNote', items: [
      TodoItem(
        text: 'item',
        isChecked: true,
      )
    ]);

    await provider.saveNote(note);
    await provider.saveNote(note2);

    final NoteProvider result =
        LocalNoteProvider(plugin: await SharedPreferences.getInstance());

    expect(result.getNotes().length, 2);
    expect(result.getNotes().first, const TypeMatcher<TextNote>());
    expect(result.getNotes()[1], const TypeMatcher<TodoNote>());
    expect((result.getNotes()[1] as TodoNote).items.first.text, 'item');
    expect((result.getNotes()[1] as TodoNote).items.first.isChecked, true);
  });

  test('deleteNote should decrease List by 1', () async {
    setupPreferences(LocalNoteProvider.kNotesKey,
        '[{"title":"textNote","content":"text note content"},{"title":"todoNote","items":[{"text":"item","isChecked":true}]}]');

    final NoteProvider provider =
        LocalNoteProvider(plugin: await SharedPreferences.getInstance());

    final noteId = provider.getNotes().last.id;
    await provider.deleteNote(noteId);

    final result = provider.getNotes().length;

    expect(result, 1);
  });

  test('deleteNote with unknown id should throw exception', () async {
    setupPreferences(LocalNoteProvider.kNotesKey,
        '[{"title":"textNote","content":"text note content"},{"title":"todoNote","items":[{"text":"item","isChecked":true}]}]');

    final NoteProvider provider =
        LocalNoteProvider(plugin: await SharedPreferences.getInstance());

    expect(() => provider.deleteNote('Wrong id'),
        throwsA(const TypeMatcher<NoteNotFoundException>()));
  });
}
