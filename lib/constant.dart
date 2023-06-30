// import 'package:dara_store/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hello/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Antre non itilizatew la svp";
const String kUsernameNullError = "Antre non itilizatew la svp";
const String kInvalidEmailError = "Svp antre yon bon email";
const String kPassNullError = "Ou bliye mete pasword ou";
const String kShortPassError = "Pasword ou a two kout";
const String kMatchPassError = "Password yo pa menm";
const String kNamelNullError = "Ou bliye mete nonw";
const String kPhoneNumberNullError = "Ou bliye mete numewo telephone ou";
const String kAddressNullError = "Ou bliye mete kotew rete";
const String kAuthentificationError =
    "Nou pa rive konektew, petet se \nnon itilizate a oubyen \nmodpass la ki pa bon(Oswa tou le de)";

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
