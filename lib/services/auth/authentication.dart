import 'dart:convert';

import 'package:get/get.dart';
import 'package:movies_app_flutter/screens/auth/auth_screen.dart';
import 'package:movies_app_flutter/services/auth/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
    Get.off(AuthScreen());
  }

  void login(String token) async {
    isLogged.value = true;
    await saveToken(token);
    await saveId(1);
  }

  void checkLoginStatus() async {
    isLogged.value = true;
    String? token;
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("token") != null) {
      token = jsonDecode(pref.getString("token")!);
    }

    if (token == null) {
      isLogged.value = false;
      Get.off(AuthScreen());
    } else {
      isLogged.value = true;
    }
  }
}
