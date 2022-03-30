import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight? fontWeight;
  final double fontSize;
  final double? letterSpacing;
  final double? height;

  const AppText(
      {Key? key,
        required this.text,
        required this.color,
        this.fontWeight,
        required this.fontSize,
        this.letterSpacing,
        this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontStyle: FontStyle.normal,
          color: color,
          fontWeight: fontWeight,
          fontFamily: "Poppins",
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          height: height),
    );
  }
}