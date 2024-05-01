import 'package:flutter/material.dart';
import 'package:projectf/constant.dart';

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;
  const Button(
      {super.key,
      required this.onTap,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: AppLayout.getWidth(context) / 1.5,
      height: 45,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: Styles.headlineStyle2.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
