import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String currentLocal = "en";
 // ThemeMode currentTheme = ThemeMode.light;

  changeLanguage(String newLanguage) {
    if (currentLocal == newLanguage) return;
    currentLocal = newLanguage;
    notifyListeners();
  }
}
