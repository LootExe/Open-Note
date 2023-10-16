/// {@template storage_provider}
/// An interface for a storage provider implementation
/// {@endtemplate}
abstract class StorageProvider {
  /// {@macro storage_provider}
  const StorageProvider();

  /// Reads all keys from the storage.
  /// Returns a `Future` that completes once the keys have been read.
  Future<Set<String>?> readKeys();

  /// Reads the value as `String` from the storage with the specified [key].
  /// Returns a `Future` that completes once the value has been read.
  Future<String?> read(String key);

  /// Writes the [value] with the specified [key] to the storage.
  /// Returns a `Future` that completes once the value has been written.
  Future<void> write(String key, String value);

  /// Deletes the key value pair from the storage.
  /// Returns a `Future` that completes once the operation has been finished.
  Future<void> delete(String key);

  /// Clears all key value pairs from the storage.
  /// Returns a `Future` that completes once the operation has been finished.
  Future<void> clear();

  /// Close the storage instance which will free any allocated resources.
  /// A storage instance can no longer be used once it is closed.
  Future<void> close();
}
