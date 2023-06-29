import 'package:flutter/material.dart';
import 'package:hello/utils/myTextStyle.dart';
import 'package:hello/utils/routes.dart';
import 'package:hello/widgets/appButton.dart';
import 'package:hello/widgets/myTextField.dart';
import 'package:hello/widgets/myTextWidget.dart';
import 'package:hello/widgets/pinkCircle.dart';
import 'package:hello/widgets/yellowCircles.dart';

import '../size_config.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String email;
  late String password;
  bool autoValidate = false;
  bool isbuttonEnabled = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
        SizeConfig().init(context);
    var size = MediaQuery.of(context).size;

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;


    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              BigCircle(
                size: size,
                left: 80,
                bottom: 550,
                height: 320,
                width: size.width,
              ),
              YellowCircle(
                size: size,
                top: 130,
                left: 250,
                height: 8,
                width: 8,
              ),
              YellowCircle(
                size: size,
                top: 156,
                left: 230,
                height: 4,
                width: 4,
              ),
              YellowCircle(
                size: size,
                top: 172,
                left: 260,
                height: 11,
                width: 11,
              ),
              YellowCircle(
                size: size,
                top: 145,
                left: 90,
                height: 4,
                width: 4,
              ),
              YellowCircle(
                top: 170,
                left: 120,
                height: 7,
                width: 7,
                size: size,
              ),
              YellowCircle(
                size: size,
                top: 200,
                left: 85,
                height: 6,
                width: 6,
              ),
              Positioned(
                  //  top:0.0,
                  //  left:0.0,
                  right: 140,
                  bottom: 650,
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
              Positioned(
                top: 130,
                left: 135,
                child: Container(
                  height: 95.43,
                  width: 90.43,
                  // color: Colors.green,
                  child: Card(
                      elevation: 9.0,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.5),
                        child: Image(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/images.jfif'),
                        ),
                      )),
                ),
              ),
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
                  top: 250,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(22)),
                    child: Form(
                      key: formKey,
                      // autovalidate: autoValidate,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Hello again.',
                              style: myStyle(
                                fontSize: 16.0,
                                color: Colors.black54,
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Welcome back',
                            style: myStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(70),
                          ),
                          MyTextField(
                            enableSuggestions: true,
                            autoValidate: autoValidate,
                            size: size,
                            labelText: 'EMAIL ADDRESS',
                            hintText: 'Enter email',
                            obscureText: false,
                            onsaved: (val) => email = val,
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Please enter username';
                            //   }
                            //   if (value != 'olson.minnie@ellen.biz') {
                            //     return "Email address is not registered with us";
                            //   }
                            //   isbuttonEnabled = true;
                            //   return null;
                            // },
                            onChanged: (val) {
                              setState(() {});
                            },
                            validator: (String) {},
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          MyTextField(
                            enableSuggestions: true,
                            autoValidate: autoValidate,
                            size: size,
                            labelText: 'PASSWROD',
                            obscureText: true,
                            suffix: Text('Forgot Password',
                                style: myStyle(
                                    color: Colors.black54, fontSize: 12.0)),
                            hintText: 'Enter password',
                            validator: (String) {},
                          ),
                          SizedBox(height: 40),
                          MyButton(
                              onPressed: () {
                                isbuttonEnabled ? _signin() : null;
                              },
                              elevation: 2,
                              child: Center(
                                  child: Text('Sign in',
                                      style: myStyle(
                                          color: Colors.white,
                                          fontSize: 13)))),//smth wrong
                          SizedBox(height: 25),
                          TextWidget(
                            firstText: "New to Friendly Desi?",
                            secondText: " Sign up",
                            onPressed: () => gotoSignUp(context),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          )),
    );
  }

  void _signin() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      setState(() {
        isbuttonEnabled = true;
      });

      Navigator.of(context).pushReplacementNamed(IndexViewRoute);
    } else {
      setState(() {
        autoValidate = true;
        isbuttonEnabled = false;
      });
    }
  }

  gotoSignUp(context) {
    Navigator.of(context).pushNamed(SignUpViewRoute);
  }
}
