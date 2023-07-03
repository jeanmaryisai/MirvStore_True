import 'package:flutter/material.dart';
import 'package:hello/components/data.dart';
// import 'package:hello/main.dart';

import '../../database.dart';
import 'components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    retrieveAllData();
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Welcome "),
      ),
      body: Body(),
    );
  }
}
