import 'package:flutter/material.dart';
import 'package:projectf/Screens/loginscreen.dart';
import 'package:projectf/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: primary, useMaterial3: false),
     home: const LoginScreen(),
    );
  }
}
