import 'package:test/test.dart';

import '../lib/src/model/text_data.dart';

void main() {
  group('TextData compareTo', () {
    test('Compare same data', () {
      final data1 = TextData(
        title: 'Data1',
        editTime: DateTime(2021),
        text: 'Test Text',
      );

      final data2 = TextData(
        title: 'Data1',
        editTime: DateTime(2021),
        text: 'Test Text',
      );

      final bool result = data1.compareTo(data2);

      expect(result, true);
    });

    test('Compare different title', () {
      final data1 = TextData(
        title: 'Data1',
        editTime: DateTime(2021),
        text: 'Test Text',
      );

      final data2 = TextData(
        title: 'Data2',
        editTime: DateTime(2021),
        text: 'Test Text',
      );

      final bool result = data1.compareTo(data2);

      expect(result, false);
    });

    test('Compare different content', () {
      final data1 = TextData(
        title: 'Data1',
        editTime: DateTime(2021),
        text: 'Test Text',
      );

      final data2 = TextData(
        title: 'Data1',
        editTime: DateTime(2021),
        text: 'Test Text 2',
      );

      final bool result = data1.compareTo(data2);

      expect(result, false);
    });
  });
}
