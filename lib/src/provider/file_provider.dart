import 'package:flutter/foundation.dart';
import 'package:shared_storage/saf.dart' as saf;

class FileProvider {
  static Future<String> readFile(Uri file) async {
    final canRead = await saf.canRead(file);

    if (canRead == null || canRead == false) {
      return '';
    }

    final bytes = await saf.getDocumentContent(file);

    if (bytes == null || bytes.isEmpty) {
      return '';
    }

    return _uint8ListToString(bytes);
  }

  static Future<bool> writeFile({
    required Uri directory,
    required String filename,
    required String content,
  }) async {
    // SAF package createFileAsString doesn't work with int16 unicode
    // Create custom uint8 byte array from string
    final buffer = _stringToUint8List(content);

    final createdFile = await saf.createFileAsBytes(
      directory,
      mimeType: 'text/plain',
      displayName: filename,
      bytes: buffer,
    );

    return createdFile != null;
  }

  static Future<bool> deleteFile(Uri file) async {
    return await saf.delete(file) ?? false;
  }

  static String _uint8ListToString(Uint8List bytes) {
    final buffer = StringBuffer();

    for (int i = 0; i < bytes.length;) {
      int firstWord = (bytes[i] << 8) + bytes[i + 1];

      if (0xD800 <= firstWord && firstWord <= 0xDBFF) {
        int secondWord = (bytes[i + 2] << 8) + bytes[i + 3];
        buffer.writeCharCode(
            ((firstWord - 0xD800) << 10) + (secondWord - 0xDC00) + 0x10000);
        i += 4;
      } else {
        buffer.writeCharCode(firstWord);
        i += 2;
      }
    }

    return buffer.toString();
  }

  static Uint8List _stringToUint8List(String content) {
    final list = <int>[];

    for (var rune in content.runes) {
      if (rune >= 0x10000) {
        rune -= 0x10000;
        int firstWord = (rune >> 10) + 0xD800;
        list.add(firstWord >> 8);
        list.add(firstWord & 0xFF);
        int secondWord = (rune & 0x3FF) + 0xDC00;
        list.add(secondWord >> 8);
        list.add(secondWord & 0xFF);
      } else {
        list.add(rune >> 8);
        list.add(rune & 0xFF);
      }
    }

    return Uint8List.fromList(list);
  }
}
