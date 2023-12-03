// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:movies_app_flutter/api/environment.dart';
// import 'package:movies_app_flutter/screens/home_screen.dart';
// import 'package:movies_app_flutter/services/api/index.dart';
// import 'package:movies_app_flutter/widgets/test.dart';

// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController _username = TextEditingController();
//   TextEditingController _password = TextEditingController();
//   void submit() async {
//     var res = await ApiService()
//         .postRequest('${Environment.apiUrl}/Videos/vtypecorp/1', body: {}, isAuth: false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           alignment: Alignment.center,
//           child: SingleChildScrollView(
//             child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
//               SizedBox(height: 58),
//               Container(
//                 height: 55,
//                 width: 322,
//                 decoration: BoxDecoration(
//                     color: Color(0xF6F6F6),
//                     borderRadius: BorderRadius.circular(15)),
//                 child: TextField(
//                   controller: _username,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     hintText: 'нэвтрэх нэрээ оруулна уу',
//                     prefixIcon: IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.account_circle_outlined),
//                     ),
//                   ),
//                   style: TextStyle(),
//                 ),
//               ),
//               SizedBox(height: 25),
//               Container(
//                 height: 55,
//                 width: 322,
//                 child: TextField(
//                   obscureText: true,
//                   controller: _password,
//                   decoration: InputDecoration(
//                     hintText: '*********',
//                     fillColor: Color(0xf6f6f6),
//                     filled: false,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide:
//                             BorderSide(width: 20, color: Color(0xf6f6f6))),
//                     prefixIcon: IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.lock),
//                     ),
//                   ),
//                   style: TextStyle(),
//                 ),
//               ),
//               SizedBox(height: 25),
//               _Button('Нэвтрэх', 55, 322),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _Button(String s, double _height, double width) {
//     return Container(
//       height: _height,
//       width: width,
//       decoration: BoxDecoration(
//           color: Color(0xff2650FF), borderRadius: BorderRadius.circular(15)),
//       child: TextButton(
//         onPressed: () {
//           print(_username.text);
//           print(_password.text);
//           // UserCheck(password: _username.text, username: _password.text);
//           // loginController.loginWithEmail();
//           // Navigator.of(context).push(
//           //   MaterialPageRoute(
//           //     builder: (context) => HomeScreen(),
//           //   ),
//           // );
//         },
//         child: Text(
//           s,
//           style: TextStyle(
//               color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }
// }
