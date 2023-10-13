// ignore_for_file: prefer_const_constructors
import 'package:storage_provider/src/storage_provider.dart';
import 'package:test/test.dart';

class TestStorageProvider implements StorageProvider {
  TestStorageProvider() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('StorageProvider', () {
    test('can be constructed', () {
      expect(TestStorageProvider.new, returnsNormally);
    });
  });
}
