import 'package:flutter/material.dart';
import 'package:projectf/constant.dart';

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;
  final Color textColor;
  final double width;
  const Button(
      {super.key,
      required this.onTap,
      required this.text,
      required this.color,
      required this.textColor,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / width,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: Styles.headlineStyle2.copyWith(color: textColor),
        ),
      ),
    );
  }
}
