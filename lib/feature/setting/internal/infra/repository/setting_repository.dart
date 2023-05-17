import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

final class SettingRepository {
  static Future<String?> loadString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(key);
  }

  static Future<void> saveString(String key, String value) async {
    await SharedPreferences.getInstance()
      ..setString(key, value);
  }

  static Future<List<String>?> loadVisibleSourceCurrencyCodes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getStringList("visibleSourceCurrencyCodes");
  }

  static Future<void> saveVisibleSourceCurrencyCodes(List<String> currencyCodes) async {
    //log(currencyCodes.join(","));
    await SharedPreferences.getInstance()
      ..setStringList("visibleSourceCurrencyCodes", currencyCodes);
  }

  static Future<List<String>?> loadVisibleTargetCurrencyCodes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getStringList("visibleTargetCurrencyCodes");
  }

  static Future<void> saveVisibleTargetCurrencyCodes(List<String> currencyCodes) async {
    //log(currencyCodes.join(","));
    await SharedPreferences.getInstance()
      ..setStringList("visibleTargetCurrencyCodes", currencyCodes);
  }
}