import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:movies_app_flutter/api/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<dynamic> getRequest(String path, [bool isAuth = false]) async {
    if (isAuth) {
      // String token = await getToken();
      return await http.get(Uri.parse('${Environment.apiUrl}${path}'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer reoprkpweokrkweopkpwerkw'
          });
    } else {
      return await http.get(Uri.parse('${Environment.apiUrl}${path}'));
    }
  }

  Future<dynamic> postRequest(String path,
      {bool isAuth = true, dynamic body}) async {
    if (isAuth) {
      SharedPreferences pref = await SharedPreferences.getInstance();

      return await http.Client().post(Uri.parse('${Environment.apiUrl}${path}'),
          body: body,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("token")}'
          });
    } else {
      print('${Environment.apiUrl}${path}');
      return await http.Client().post(Uri.parse('${Environment.apiUrl}${path}'),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      // http.Response response = await http.post(
      //     Uri.parse('${Environment.apiUrl}${path}'),
      //     body: jsonEncode({'email': "test", 'password': "test"}),
      //     headers: {'Content-Type': 'application/json'});
    }
  }

  Future<dynamic> putRequest(String path,
      {bool isAuth = true, dynamic body}) async {
    if (isAuth) {
      return await http.Client().put(Uri.parse('${Environment.apiUrl}${path}'),
          body: body,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer reoprkpweokrkweopkpwerkw'
          });
    } else {
      return await http.Client()
          .post(Uri.parse('${Environment.apiUrl}${path}'), body: body);
    }
  }

  Future<dynamic> deleteRequest(String path,
      {bool isAuth = true, dynamic body}) async {
    if (isAuth) {
      return await http.Client().delete(
          Uri.parse('${Environment.apiUrl}${path}'),
          body: body,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer reoprkpweokrkweopkpwerkw'
          });
    } else {
      return await http.Client()
          .post(Uri.parse('${Environment.apiUrl}${path}'), body: body);
    }
  }
}
