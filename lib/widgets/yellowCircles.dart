// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';

class YellowCircle extends StatelessWidget {

  final Size size;
  final double left;
  final double right;
  final double top;
  final double bottom;
  final double height;
  final double width;
  const YellowCircle({
    Key? key,
    required this.size ,
     this.left=0.0,
     this.right=0.0,
     this.top=0.0,
     this.bottom=0.0,
     this.height=0.0,
     this.width=0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: Container(
          height: height,
          width: width,
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
        ));
  }
}

class BigYellowCircle extends StatelessWidget {

  final Size size;
  final double left;
  final double right;
  final double top;
  final double bottom;
  final double height;
  final double width;
  const BigYellowCircle({
    Key? key,
    required this.size,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: Container(
          height: height,
          width:size.width,
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
        ));
  }
}
