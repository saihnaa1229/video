import 'package:shared_preferences/shared_preferences.dart';

mixin CacheManager {
  Future<bool> saveToken(String token) async {
    print(token);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    return true;
  }

  Future<bool> saveId(int id) async {
    print(id);
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", id);
    return true;
  }

  Future<void> removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("token");
  }
}
