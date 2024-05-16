// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

class CustomTxtField extends StatefulWidget {
  final String labelText;
  final String validatorMessage;
  final TextEditingController Controller;
  final TextInputType keyboardType;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool isobscureText;
  CustomTxtField({
    Key? key,
    required this.labelText,
    required this.Controller,
    required this.isobscureText,
    @required this.suffixIcon,
    @required this.prefixIcon,
    required this.validatorMessage,
    required this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomTxtField> createState() => _CustomTxtFieldState();
}

class _CustomTxtFieldState extends State<CustomTxtField> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.validatorMessage;
          }
          return null;
        },
        cursorWidth: 3,
        controller: widget.Controller,
        obscureText: widget.isobscureText,
        style: const TextStyle(
            color: Color.fromARGB(221, 13, 9, 23),
            fontSize: 20,
            fontFamily: 'pa',
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: color),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color, width: .5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color, width: .5),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          hintText: widget.labelText,
          hintStyle: TextStyle(
            fontSize: 20,
            color: color.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
