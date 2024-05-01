// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/constant.dart';

class EditInfo extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final String text;
  final Function(String) onChanged;
  final bool isobscureText;
  final bool enabled;

  EditInfo({
    super.key,
    required this.controller,
    required this.text,
    required this.onChanged,
    required this.isobscureText,
    required this.enabled,
  });

  final Users users = Users();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text,
              style: Styles.headlineStyle3.copyWith(fontSize: 20, color: color),
            ),
          ],
        ),
        const Gap(5),
        TextField(
          enabled: enabled,
          style: const TextStyle(fontSize: 20),
          controller: controller,
          onChanged: onChanged,
          obscureText: isobscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: color),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
