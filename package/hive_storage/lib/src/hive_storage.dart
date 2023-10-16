import 'dart:io';

import 'package:hive/hive.dart';
import 'package:storage_provider/storage_provider.dart';
import 'package:synchronized/synchronized.dart';

/// {@template hive_storage}
/// A Hive implementation of the StorageProvider interface
/// {@endtemplate}
class HiveStorage implements StorageProvider {
  /// {@macro hive_storage}
  const HiveStorage({required Box<String> box}) : _box = box;

  static final _lock = Lock();
  static HiveStorage? _instance;

  final Box<String> _box;

  /// Returns an instance of `HiveStorage`.
  static Future<HiveStorage> build({required Directory storageDirectory}) {
    return _lock.synchronized(() async {
      if (_instance != null) {
        return _instance!;
      }

      Hive.init(storageDirectory.path);
      final box = await Hive.openBox<String>('storage_box');

      return _instance = HiveStorage(box: box);
    });
  }

  @override
  Future<Set<String>?> readKeys() async =>
      _box.isOpen ? Set<String>.from(_box.keys) : null;

  @override
  Future<String?> read(String key) async => _box.isOpen ? _box.get(key) : null;

  @override
  Future<void> write(String key, String value) async {
    if (_box.isOpen) {
      return _lock.synchronized(() => _box.put(key, value));
    }
  }

  @override
  Future<void> delete(String key) async {
    if (_box.isOpen) {
      return _lock.synchronized(() => _box.delete(key));
    }
  }

  @override
  Future<void> clear() async {
    if (_box.isOpen) {
      _instance = null;
      return _lock.synchronized(_box.clear);
    }
  }

  @override
  Future<void> close() async {
    if (_box.isOpen) {
      _instance = null;
      return _lock.synchronized(_box.close);
    }
  }
}
