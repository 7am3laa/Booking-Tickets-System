// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

class CustomTxtField extends StatelessWidget {
  final String labelText;
  final String validatorMessage;
  final FormFieldSetter<String> onSaved;
  final TextInputType keyboardType;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool isobscureText;
  CustomTxtField({
    Key? key,
    required this.labelText,
    required this.onSaved,
    required this.isobscureText,
    this.suffixIcon,
    this.prefixIcon,
    required this.validatorMessage,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color = theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMessage;
          }
          return null;
        },
        cursorWidth: 3,
        onSaved: onSaved,
        obscureText: isobscureText,
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
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color, width: .5),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: labelText,
          hintStyle: TextStyle(
            fontSize: 20,
            color: color.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
