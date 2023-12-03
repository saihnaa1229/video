// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app_flutter/screens/home_screen.dart';
import 'package:movies_app_flutter/services/api/index.dart';
import 'package:movies_app_flutter/services/auth/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/environment.dart';
import '/controller/login_controller.dart';
import '/controller/registeration_controller.dart';
import 'widgets/input_fields.dart';
import 'widgets/submit_button.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegisterationController registerationController =
      Get.put(RegisterationController());

  AuthenticationManager _auth = Get.put(AuthenticationManager());

  LoginController loginController = Get.put(LoginController());

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    // _auth.checkLoginStatus();

    // if (_auth.isLogged == true) {
    //   Get.off(HomeScreen(1));
    // }

    // tokenCheck();
  }

  void tokenCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("token") != null) {
      Get.off(HomeScreen(1));
    }
  }

  void submit() async {
    try {
      Map body = {
        'userName': loginController.emailController.text.trim(),
        'passport': loginController.passwordController.text
      };
      var res = await ApiService()
          .postRequest('/Users/login', body: body, isAuth: false);

      print(res.body);

      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        var token = json['token'];
        final SharedPreferences? prefs = await _prefs;

        loginController.emailController.clear();
        loginController.passwordController.clear();
        _auth.login(token);
        Get.off(HomeScreen(
          json['corpid'],
        ));
      } else {
        throw jsonDecode(res.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Center(
            child: Obx(
              () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        'WELCOME',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: !isLogin.value ? Colors.white : Colors.amber,
                          onPressed: () {
                            isLogin.value = false;
                          },
                          child: Text('Register'),
                        ),
                        MaterialButton(
                          color: isLogin.value ? Colors.white : Colors.amber,
                          onPressed: () {
                            isLogin.value = true;
                          },
                          child: Text('Login'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    isLogin.value ? loginWidget() : registerWidget()
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Column(
      children: [
        InputTextFieldWidget(registerationController.nameController, 'name'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.emailController, 'email address'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.passwordController, 'password'),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => registerationController.registerWithEmail(),
          title: 'Register',
        )
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.emailController, 'email address'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.passwordController, 'password'),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: submit,
          title: 'Login',
        )
      ],
    );
  }
}
