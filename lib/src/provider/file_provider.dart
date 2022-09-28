import 'package:shared_storage/saf.dart' as saf;

class FileProvider {
  static Future<String> readFile(Uri file) async {
    final canRead = await saf.canRead(file);

    if (canRead == null || canRead == false) {
      return '';
    }

    return await saf.getDocumentContentAsString(file) ?? '';
  }

  static Future<bool> writeFile({
    required Uri directory,
    required String filename,
    required String content,
  }) async {
    final createdFile = await saf.createFileAsString(
      directory,
      mimeType: 'text/plain',
      displayName: filename,
      content: content,
    );

    return createdFile != null;
  }

  static Future<bool> deleteFile(Uri file) async {
    return await saf.delete(file) ?? false;
  }
}
