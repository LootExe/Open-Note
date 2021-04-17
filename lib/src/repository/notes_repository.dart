import '../provider/storage_provider.dart';
import '../model/note_storage_data.dart';
import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';

class NotesRepository {
  static const String _storageKeyScheme = 'scheme';
  static const String _storageKeyNote = 'note';

  List<NoteData> notes = [];

  Future<bool> readNotes() async {
    notes.clear();

    final NoteStorageData scheme = await _readStorageScheme();

    for (var entry in scheme.storageDetails.entries) {
      final storageKey = _storageKeyNote + entry.key.toString();
      final json = await StorageProvider.readData(storageKey);

      if (json.isNotEmpty) {
        switch (entry.value) {
          case NoteType.Text:
            notes.add(TextData.fromJson(json));
            break;
          case NoteType.Todo:
            notes.add(TodoData.fromJson(json));
            break;
        }
      }
    }

    /* notes = [
      TextData(
        title: 'Liabilities',
        editTime: DateTime(2021, 4, 10, 17, 30),
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ' +
            'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ' +
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ' +
            'ut aliquip ex ea commodo consequat. Duis aute irure dolor in ' +
            'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
            'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia ' +
            'deserunt mollit anim id est laborum.' +
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ' +
            'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ' +
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ' +
            'ut aliquip ex ea commodo consequat. Duis aute irure dolor in ' +
            'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
            'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia ' +
            'deserunt mollit anim id est laborum.' +
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ' +
            'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ' +
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ' +
            'ut aliquip ex ea commodo consequat. Duis aute irure dolor in ' +
            'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
            'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia ' +
            'deserunt mollit anim id est laborum.' +
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ' +
            'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ' +
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ' +
            'ut aliquip ex ea commodo consequat. Duis aute irure dolor in ' +
            'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
            'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia ' +
            'deserunt mollit anim id est laborum.',
      ),
      TodoData(
        title: 'Shopping List',
        editTime: DateTime(2021, 4, 12, 10, 05),
        items: [
          TodoItem(text: 'Milk', isChecked: false),
          TodoItem(text: 'Flour', isChecked: false),
          TodoItem(text: 'Bread', isChecked: true),
        ],
      ),
      TextData(
        title: 'Australia',
        editTime: DateTime(2021, 4, 2, 08, 0),
        text: 'Phone Number: +61 456 312 494',
      ),
    ]; */

    return true;
  }

  Future<bool> writeNotes() async {
    await _writeStorageScheme();

    for (int i = 0; i < notes.length; i++) {
      Map<String, dynamic> json = {};

      switch (notes[i].type) {
        case NoteType.Text:
          json = (notes[i] as TextData).toJson();
          break;
        case NoteType.Todo:
          json = (notes[i] as TodoData).toJson();
          break;
      }

      final storageKey = _storageKeyNote + i.toString();

      await StorageProvider.saveData(storageKey, json);
    }

    return true;
  }

  Future<NoteStorageData> _readStorageScheme() async {
    final json = await StorageProvider.readData(_storageKeyScheme);

    if (json.isNotEmpty) {
      return NoteStorageData.fromJson(json);
    }

    return NoteStorageData(storageDetails: {});
  }

  Future<bool> _writeStorageScheme() async {
    int index = 0;

    final scheme = NoteStorageData(
      storageDetails: Map.fromIterable(
        notes,
        key: (_) => index++,
        value: (e) => e.type,
      ),
    );

    return await StorageProvider.saveData(_storageKeyScheme, scheme.toJson());
  }
}
