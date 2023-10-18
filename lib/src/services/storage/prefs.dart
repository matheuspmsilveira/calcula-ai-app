// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

// Common Keys (Delete if Unnecessary)
const PROFILEKEY = "PROFILEKEY";
const TOKENKEY = "TOKENKEY";
const LOCALEKEY = "LOCALEKEY";

class Prefs {
  static late SharedPreferences _prefs;
  Prefs._();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveString(String key, String value) =>
      _prefs.setString(key, value);

  static String? getString(String key) => _prefs.getString(key);

  static deleteString(String key) async {
    _prefs.remove(key);
  }

}
