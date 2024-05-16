import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme);
  static final lightTheme = ThemeData.light();
  static final darkTheme = ThemeData.dark();
  void toggleTheme() {
    emit(state == lightTheme ? darkTheme : lightTheme);
  }
}
