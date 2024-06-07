import 'package:shared_preferences/shared_preferences.dart';

class Prefrences {
  static Future<void> setDisplayName(String displayName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('displayName', displayName);
  }

  static Future<String> getDisplayName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String displayName = preferences.getString('displayName') ?? "";
    return displayName;
  }

  static Future<void> setId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('id', id);
  }

  static Future<String> getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id') ?? "";
    return id;
  }

  static Future<void> setLoginStatus(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isLoggedIn', value);
  }

  static Future<bool> checkLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLoggedIn = preferences.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }
}
