import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardText extends StatelessWidget {
  Color textColor;
  double fontSize;
  String textContent;
  String? textWeight = 'No';
  CardText(
      {required this.textContent,
      required this.textColor,
      required this.fontSize,
      this.textWeight,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (textWeight == 'No') {
      return Text(
        textContent,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        ),
      );
    } else {
      return Text(
        textContent,
        style: TextStyle(
            fontSize: fontSize, color: textColor, fontWeight: FontWeight.bold),
      );
    }
  }
}
