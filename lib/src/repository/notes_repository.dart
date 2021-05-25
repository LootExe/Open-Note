import '../model/note_data.dart';
import '../model/text_data.dart';
import '../model/todo_data.dart';
import '../provider/storage_provider.dart';

class NotesRepository {
  static const String _storageKey = 'notes';

  final List<NoteData> notes = [];

  NoteData? _jsonToNoteData(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return null;
    }

    try {
      final type = json['type'] as String;

      final noteType =
          NoteType.values.firstWhere((e) => e.toString() == 'NoteType.' + type);

      switch (noteType) {
        case NoteType.Todo:
          return TodoData.fromJson(json);
        case NoteType.Text:
          return TextData.fromJson(json);
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> readNotes() async {
    notes.clear();

    final jsonList = await StorageProvider.readJsonList(_storageKey);

    jsonList.forEach((json) {
      final note = _jsonToNoteData(json);

      if (note != null) {
        notes.add(note);
      }
    });

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
    final jsonList = notes.map((e) => e.toJson()).toList();

    return await StorageProvider.writeJsonList(_storageKey, jsonList);
  }
}
