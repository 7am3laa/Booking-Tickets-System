// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:projectf/constant.dart';

class CustomTxtField extends StatefulWidget {
  final String labelText;
  final TextEditingController Controller;
  Widget? icon;
  bool isobscureText;
  CustomTxtField({
    Key? key,
    required this.labelText,
    required this.Controller,
    required this.isobscureText,
    @required this.icon,
  }) : super(key: key);

  @override
  State<CustomTxtField> createState() => _CustomTxtFieldState();
}

class _CustomTxtFieldState extends State<CustomTxtField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppLayout.getWidth(context) / 1.5,
      child: TextField(
        obscuringCharacter: '*',
        controller: widget.Controller,
        obscureText: widget.isobscureText,
        style: const TextStyle(
            fontSize: 20, fontFamily: 'pa', fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: .5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: .5),
          ),
          suffixIcon: widget.icon,
          hintText: widget.labelText,
          hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.white.withOpacity(.5),
            fontFamily: 'pa',
          ),
        ),
      ),
    );
  }
}
