// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hello/utils/myTextStyle.dart';

class TextWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String firstText;
  final String secondText;
  const TextWidget({
    Key? key,
    required this.onPressed,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: RichText(
        text: TextSpan(
            text: firstText,
            style: myStyle(color: Colors.grey, fontSize: 14.0),
            children: <TextSpan>[
              TextSpan(
                  text: secondText,
                  style: myStyle(color: Theme.of(context).primaryColor))
            ]),
      ),
    );
  }
}
