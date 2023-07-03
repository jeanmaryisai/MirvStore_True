import 'package:flutter/material.dart';
import 'package:hello/utils/myTextStyle.dart';
import 'package:hello/widgets/appButton.dart';
import 'package:hello/widgets/myTextField.dart';
import 'package:hello/widgets/myTextWidget.dart';
import 'package:hello/widgets/pinkCircle.dart';
import 'package:hello/widgets/yellowCircles.dart';

import '../size_config.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;

    bool autoValidate = false;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              BigCircle(
                size: size,
                left: 80,
                bottom: 530,
                height: 320,
                width: size.width,
              ),

              //yellow circle on the left
              Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 125,
                  bottom: 620,
                  child: Container(
                    height: 250,
                    width: size.width,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //  color: Colors.yellow,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF6DC79),
                            Color(0xFFF9C87A),
                            Color(0xFFFCB47B),
                            Color(0XFFFFA17B),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        )),
                  )),

              //small yellow circles on the left
              YellowCircle(
                size: size,
                top: 245,
                left: 85,
                height: 6,
                width: 6,
              ),
              YellowCircle(
                size: size,
                top: 200,
                left: 110,
                height: 7,
                width: 7,
              ),
              YellowCircle(
                size: size,
                top: 175,
                left: 95,
                height: 4,
                width: 4,
              ),

              //small yellow cirlces on the right
              YellowCircle(
                size: size,
                top: 170,
                left: 255,
                height: 8,
                width: 8,
              ),
              YellowCircle(
                size: size,
                top: 199,
                left: 245,
                height: 4,
                width: 4,
              ),
              YellowCircle(
                size: size,
                top: 227,
                left: 270,
                height: 11,
                width: 11,
              ),

              //back button
              Positioned(
                  top: 0,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16),
                        vertical: getProportionateScreenWidth(15)),
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  )),
              Positioned(
                  top: 60,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      children: [
                        Text('Hello!',
                            style:
                                myStyle(fontSize: 14.0, color: Colors.white)),
                        SizedBox(height: 5),
                        Text('Sign up to started.',
                            style:
                                myStyle(color: Colors.white, fontSize: 14.0)),
                        SizedBox(height: getProportionateScreenHeight(50)),
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage('assets/images/user.jpg'),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(40),
                        ),
                        MyTextField(
                          enableSuggestions: true,
                          autoValidate: autoValidate,
                          size: size,
                          labelText: 'FULL NAME',
                          obscureText: false,
                          hintText: 'full name',
                          validator: (String) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          enableSuggestions: true,
                          autoValidate: autoValidate,
                          size: size,
                          labelText: 'EMAIL ADDRESS',
                          obscureText: false,
                          hintText: 'email',
                          validator: (String) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          enableSuggestions: true,
                          autoValidate: autoValidate,
                          size: size,
                          labelText: 'PASSWROD',
                          obscureText: true,
                          validator: (String) {},
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        MyButton(
                            onPressed: () {},
                            elevation: 2,
                            child: Center(
                                child: Text('Sign up',
                                    style: myStyle(
                                        color: Colors.white,
                                        fontSize: 13)))),
                        SizedBox(height: 25),
                        TextWidget(
                            firstText: "Already have an account?",
                            secondText: " Sign in",
                            onPressed: () => gotoSiginIn(context))
                      ],
                    ),
                  )),
              Positioned(
                  top: 225,
                  right: 125,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Container(
                      height: 25,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ))
            ],
          )),
    );
  }

  gotoSiginIn(context) {
    Navigator.pop(context);
  }
}
