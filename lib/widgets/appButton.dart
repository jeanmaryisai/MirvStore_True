import 'package:flutter/material.dart';

import '../size_config.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.elevation,
    // this.shape,
    required this.onPressed,
    // this.color,
    required this.child,
  }) : super(key: key);
  final double elevation;
  // final ShapeBorder shape;
  final VoidCallback onPressed;
  // final color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        // height:53,
        disabledColor: Colors.pink.withAlpha(50),
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        height: getProportionateScreenHeight(53),
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        child: child);
  }
}
