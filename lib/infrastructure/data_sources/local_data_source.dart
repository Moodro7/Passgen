import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSource(this.sharedPreferences);

  Future<List<Map<String, String>>> loadPasswords() async {
    final data = sharedPreferences.getString('passwords');
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      return jsonList.map((json) => Map<String, String>.from(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> savePasswords(List<Map<String, String>> passwords) async {
    final data = json.encode(passwords);
    await sharedPreferences.setString('passwords', data);
  }
}
