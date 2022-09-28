import 'package:note/src/model/todo_data.dart';
import 'package:test/test.dart';

void main() {
  group('TodoData compareTo', () {
    test('Compare same data', () {
      final data1 = TodoData(title: 'Data 1', editTime: DateTime(2021), items: [
        TodoItemData(text: 'Item1', isChecked: true),
        TodoItemData(text: 'Item2', isChecked: false),
        TodoItemData(text: 'Item3', isChecked: true)
      ]);

      final data2 = TodoData(title: 'Data 1', editTime: DateTime(2021), items: [
        TodoItemData(text: 'Item1', isChecked: true),
        TodoItemData(text: 'Item2', isChecked: false),
        TodoItemData(text: 'Item3', isChecked: true)
      ]);

      final bool result = data1.compareTo(data2);

      expect(result, true);
    });

    test('Compare different title', () {
      final data1 = TodoData(title: 'Data 1', editTime: DateTime(2021), items: [
        TodoItemData(text: 'Item1', isChecked: true),
        TodoItemData(text: 'Item2', isChecked: false),
        TodoItemData(text: 'Item3', isChecked: true)
      ]);

      final data2 = TodoData(title: 'Data 2', editTime: DateTime(2021), items: [
        TodoItemData(text: 'Item1', isChecked: true),
        TodoItemData(text: 'Item2', isChecked: false),
        TodoItemData(text: 'Item3', isChecked: true)
      ]);

      final bool result = data1.compareTo(data2);

      expect(result, false);
    });

    test('Compare different content', () {
      final data1 = TodoData(title: 'Data 1', editTime: DateTime(2021), items: [
        TodoItemData(text: 'Item1', isChecked: true),
        TodoItemData(text: 'Item2', isChecked: false),
        TodoItemData(text: 'Item3', isChecked: true)
      ]);

      final data2 = TodoData(title: 'Data 1', editTime: DateTime(2021), items: [
        TodoItemData(text: 'Item1', isChecked: false),
        TodoItemData(text: 'Item2', isChecked: false),
        TodoItemData(text: 'Item4', isChecked: true)
      ]);

      final bool result = data1.compareTo(data2);

      expect(result, false);
    });
  });
}
