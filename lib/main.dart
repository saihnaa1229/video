import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movies_app_flutter/api/environment.dart';
import 'package:movies_app_flutter/screens/auth/auth_screen.dart';
import 'package:movies_app_flutter/screens/login_screen.dart';
import 'package:sizer/sizer.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';

Future<void> main() async {

  

  await dotenv.load(fileName: Environment.fileName);
  //await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies App',
            theme: ThemeData.dark().copyWith(
              platform: TargetPlatform.iOS,
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: kPrimaryColor,
            ),
            home: AuthScreen());
      },
    );
  }
}
