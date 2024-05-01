import 'package:flutter/material.dart';

class ChangeTheme extends InheritedWidget {
  final MyData? data;

  const ChangeTheme({Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  static ChangeTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ChangeTheme>();
  }

  @override
  bool updateShouldNotify(covariant ChangeTheme oldWidget) {
    return false; 
  }
}

class MyData {
  late bool isDark;
  late VoidCallback onThemeChanged;

  MyData({required this.isDark, required this.onThemeChanged});

  void toggleTheme() {
    isDark = !isDark;
    onThemeChanged();
  }
}