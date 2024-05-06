// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:projectf/Screens/loginscreen.dart';
import 'package:projectf/Screens/mainscreen.dart';
import 'package:projectf/Screens/profilescreen.dart';
import 'package:projectf/Screens/signupscreen.dart';
import 'package:projectf/Screens/splashscreen.dart';
import 'package:projectf/constant.dart';
import 'package:projectf/changetheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyData myData;

  @override
  void initState() {
    super.initState();
    myData = MyData(
      isDark: false,
      onThemeChanged: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeTheme(
      data: myData,
      child: Builder(
        builder: (context) {
          final isDark = ChangeTheme.of(context)?.data?.isDark ?? false;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'PROJECT',
            theme: ThemeData(
              useMaterial3: false,
              brightness: isDark ? Brightness.dark : Brightness.light,
              primaryColor: primary,
            ),
            initialRoute: LoginScreen.id,
            routes: {
              SplashScreen.id: (context) => const SplashScreen(),
              LoginScreen.id: (context) => const LoginScreen(),
              MainScreen.id: (context) => const MainScreen(),
              RegisterScreen.id: (context) => const RegisterScreen(),
              ProfileScreen.id: (context) => const ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}
