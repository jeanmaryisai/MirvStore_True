// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hello/utils/myTextStyle.dart';

class MyTextField extends StatelessWidget {
  final Size size;
  final String labelText;
  final String? hintText;
  final Widget? suffix;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autoValidate;
  final void Function(String)? onChanged;
  final void Function(String)? onsaved;
  final void Function(String) validator;
  const MyTextField({
    Key? key,
    required this.size,
    required this.labelText,
    this.hintText,
    this.suffix,
    required this.obscureText,
    required this.enableSuggestions,
    required this.autoValidate,
    this.onChanged,
    this.onsaved,
    required this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width,
        child: TextFormField(
          onChanged: onChanged,
          style: myStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
          obscureText: obscureText,
          onSaved: null,
          validator: null,
          enableSuggestions: enableSuggestions,
          decoration: InputDecoration(
              labelText: labelText,
              labelStyle: myStyle(fontSize: 13.0, color: Colors.grey),
              hintText: hintText,
              suffix: suffix,
              suffixIconConstraints: BoxConstraints(maxWidth: 20)),
        ));
  }
}
