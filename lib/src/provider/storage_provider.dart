import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider {
  static Future<Set<String>> readKeys() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getKeys();
  }

  static Future<Map<String, dynamic>> readJson(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(key);
    var json = Map<String, dynamic>();

    if (data == null) {
      return json;
    }

    try {
      json = jsonDecode(data) as Map<String, dynamic>;
    } finally {
      return json;
    }
  }

  static Future<List<Map<String, dynamic>>> readJsonList(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key);

    if (data != null) {
      return data.map<Map<String, dynamic>>((e) {
        var json = Map<String, dynamic>();

        try {
          json = jsonDecode(e) as Map<String, dynamic>;
        } finally {
          return json;
        }
      }).toList();
    }

    return [];
  }

  static Future<bool> writeJson(String key, Map<dynamic, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, jsonEncode(value));
  }

  static Future<bool> writeJsonList(
      String key, List<Map<dynamic, dynamic>> values) async {
    final prefs = await SharedPreferences.getInstance();

    final list = values.map<String>((e) => jsonEncode(e)).toList();

    return prefs.setStringList(key, list);
  }

  static Future<bool> removeEntry(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.remove(key);
  }

  static Future<bool> clearStorage() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }
}
