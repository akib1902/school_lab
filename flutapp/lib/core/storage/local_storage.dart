import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_time') ?? true;
  }

  static Future<void> saveUserSelection(
      String dept, String batch) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dept', dept);
    await prefs.setString('batch', batch);
    await prefs.setBool('first_time', false);
  }
}