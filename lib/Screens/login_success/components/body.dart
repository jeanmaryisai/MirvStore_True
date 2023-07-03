

import 'package:flutter/material.dart';

import '../../../components/data.dart';
import '../../../size_config.dart';
import '../../Home/HomeScreen.dart';
import '../../sign_in/components/sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name= currentUser.username;
    return Center(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Image.asset(
            "assets/images/success.png",
            height: SizeConfig.screenHeight * 0.4, //40%
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Text(
            "Welcome $name",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.6,
            child: DefaultButton(
              text: "Go to home",
              press: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=> HomeScreen()));
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
