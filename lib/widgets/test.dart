import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserCheck extends StatefulWidget {
  const UserCheck({required String password, required String username});

  @override
  State<UserCheck> createState() => _UserCheckState();
}

class _UserCheckState extends State<UserCheck> {
  List<User> Users = [
    User(password: '1234', username: 'tttt'),
    User(password: '1111', username: 'ssss'),
    User(password: '3333', username: 'xxxx'),
    User(password: '4444', username: 'yyyy'),
    User(password: '5555', username: 'pppp'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
