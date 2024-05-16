// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectf/Cubits/theme-Cubit/theme_cubit.dart';
import 'package:projectf/Screens/loginscreen.dart';
import 'package:projectf/Screens/mainscreen.dart';
import 'package:projectf/Screens/profilescreen.dart';
import 'package:projectf/Screens/signupscreen.dart';
import 'package:projectf/Screens/splashscreen.dart';
import 'package:projectf/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'PROJECT',
            theme: ThemeData(
              brightness: state.brightness,
              useMaterial3: false,
              primaryColor: primary,
            ),
            initialRoute: LoginScreen.id,
            routes: {
              SplashScreen.id: (context) => SplashScreen(),
              LoginScreen.id: (context) => const LoginScreen(),
              MainScreen.id: (context) => MainScreen(),
              RegisterScreen.id: (context) => const RegisterScreen(),
              ProfileScreen.id: (context) => const ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}
