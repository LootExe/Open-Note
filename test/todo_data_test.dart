import 'package:test/test.dart';

import '../lib/src/model/todo_data.dart';
import '../lib/src/model/todo_item.dart';

void main() {
  group('TodoData compareTo', () {
    test('Compare same data', () {
      final data1 = TodoData(title: 'Data 1', editTime: DateTime(2021), items: [
        TodoItem(text: 'Item1', isChecked: true),
        TodoItem(text: 'Item2', isChecked: false),
        TodoItem(text: 'Item3', isChecked: true)
      ]);

      final data2 = TodoData(title: 'Data 1', editTime: DateTime(2021), items: [
        TodoItem(text: 'Item1', isChecked: true),
        TodoItem(text: 'Item2', isChecked: false),
        TodoItem(text: 'Item3', isChecked: true)
      ]);

      final bool result = data1.compareTo(data2);

      expect(result, true);
    });

    test('Compare different title', () {
      final data1 = TodoData(title: 'Data 1', editTime: DateTime(2021), items: [
        TodoItem(text: 'Item1', isChecked: true),
        TodoItem(text: 'Item2', isChecked: false),
        TodoItem(text: 'Item3', isChecked: true)
      ]);

      final data2 = TodoData(title: 'Data 2', editTime: DateTime(2021), items: [
        TodoItem(text: 'Item1', isChecked: true),
        TodoItem(text: 'Item2', isChecked: false),
        TodoItem(text: 'Item3', isChecked: true)
      ]);

      final bool result = data1.compareTo(data2);

      expect(result, false);
    });

    test('Compare different content', () {
      final data1 = TodoData(title: 'Data 1', editTime: DateTime(2021), items: [
        TodoItem(text: 'Item1', isChecked: true),
        TodoItem(text: 'Item2', isChecked: false),
        TodoItem(text: 'Item3', isChecked: true)
      ]);

      final data2 = TodoData(title: 'Data 1', editTime: DateTime(2021), items: [
        TodoItem(text: 'Item1', isChecked: false),
        TodoItem(text: 'Item2', isChecked: false),
        TodoItem(text: 'Item4', isChecked: true)
      ]);

      final bool result = data1.compareTo(data2);

      expect(result, false);
    });
  });
}
