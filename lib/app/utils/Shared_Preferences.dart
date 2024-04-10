import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{

  // static SharedPreferences ? prefs;
    static setData({required String key,required String data}) async {
      SharedPreferences ? prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  static Future<String?> getData({required String key}) async {
    SharedPreferences ? prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(key);
      return data;
  }

}