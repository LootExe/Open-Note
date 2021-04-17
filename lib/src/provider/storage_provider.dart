import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider {
  static Future<bool> saveData(String key, Map<dynamic, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, jsonEncode(value));
  }

  static Future<Map<String, dynamic>> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString(key);
    var jsonResult = Map<String, dynamic>();

    if (data != null) {
      try {
        jsonResult = jsonDecode(data);
      } on FormatException {}
    }

    return jsonResult;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.remove(key);
  }
}
