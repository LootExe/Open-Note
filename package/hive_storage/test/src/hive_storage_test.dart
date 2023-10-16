// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_storage/hive_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockBox extends Mock implements Box<String> {}

void main() {
  group('HiveStorage', () {
    late HiveStorage storage;

    final cwd = Directory.current.absolute.path;
    final storageDirectory = Directory(cwd);

    tearDown(() async {
      await storage.clear();
      try {
        await Hive.deleteFromDisk();
      } catch (_) {}
    });

    group('build', () {
      setUp(() async {
        final storage = await HiveStorage.build(
          storageDirectory: storageDirectory,
        );
        await storage.clear();
        await storage.close();
      });

      test('reuses existing instance when called multiple times', () async {
        final instanceA = storage = await HiveStorage.build(
          storageDirectory: storageDirectory,
        );
        final instanceB = await HiveStorage.build(
          storageDirectory: storageDirectory,
        );

        expect(instanceA, instanceB);
      });

      test('creates new instance if storage was closed', () async {
        final instanceA = await HiveStorage.build(
          storageDirectory: storageDirectory,
        );

        await instanceA.close();

        final instanceB = storage = await HiveStorage.build(
          storageDirectory: storageDirectory,
        );

        expect(instanceA, isNot(instanceB));
      });
    });

    group('default constructor', () {
      const key = '__key__';
      const value = '__value__';
      late Box<String> box;

      setUp(() {
        box = MockBox();
        when(() => box.isOpen).thenReturn(true);
        when(() => box.keys).thenReturn({key});
        when(() => box.get(any<String>())).thenReturn(value);
        when(() => box.put(any<String>(), any<String>()))
            .thenAnswer((_) async {});
        when(() => box.delete(any<String>())).thenAnswer((_) async {});
        when(() => box.clear()).thenAnswer((_) async => 0);
        when(() => box.close()).thenAnswer((_) async {});
        storage = HiveStorage(box: box);
      });

      group('readKeys', () {
        test('returns null when box is not open', () {
          when(() => box.isOpen).thenReturn(false);

          expect(storage.readKeys(), completion(isNull));
        });

        test('returns correct keys when box is open', () {
          expect(storage.readKeys(), completion({key}));
          verify(() => box.keys).called(1);
        });
      });

      group('read', () {
        test('returns null when box is not open', () {
          when(() => box.isOpen).thenReturn(false);
          expect(storage.read(key), completion(isNull));
        });

        test('returns correct value when box is open', () {
          expect(storage.read(key), completion(value));
          verify(() => box.get(key)).called(1);
        });
      });

      group('write', () {
        test('does nothing when box is not open', () async {
          when(() => box.isOpen).thenReturn(false);
          await storage.write(key, value);

          verifyNever(() => box.put(any<String>(), any<String>()));
        });

        test('puts key/value in box when box is open', () async {
          await storage.write(key, value);
          verify(() => box.put(key, value)).called(1);
        });
      });

      group('delete', () {
        test('does nothing when box is not open', () async {
          when(() => box.isOpen).thenReturn(false);
          await storage.delete(key);
          verifyNever(() => box.delete(any<String>()));
        });

        test('deletes key/value when box is open', () async {
          await storage.delete(key);
          verify(() => box.delete(key)).called(1);
        });
      });

      group('clear', () {
        test('does nothing when box is not open', () async {
          when(() => box.isOpen).thenReturn(false);
          await storage.clear();
          verifyNever(() => box.clear());
        });

        test('clears box when box is open', () async {
          await storage.clear();
          verify(() => box.clear()).called(1);
        });
      });
    });
  });
}
