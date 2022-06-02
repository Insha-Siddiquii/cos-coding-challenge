import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtils {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async {
    instance = await SharedPreferences.getInstance();
    return instance;
  }

  static String? getString({required String key}) {
    return instance.getString(key);
  }

  static Future<bool> setString(String key, String value) async {
    return instance.setString(key, value);
  }

  static Future<bool> remove(String key) async {
    return instance.remove(key);
  }
}
