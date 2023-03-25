import 'package:flutter/material.dart';
import 'package:budget_recorder/models/SharedPreference.dart';

class ThemeProvider with ChangeNotifier {
  AppSharedPreferences themePreference = const AppSharedPreferences();
  bool _darkTheme = false;
  String _currency = "LKR";

  bool get darkTheme => _darkTheme;
  String get appCurrency => _currency;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    themePreference.setAppTheme(value);
    notifyListeners();
  }

  set setAppCurrency(String value) {
    _currency = value;
    themePreference.setAppCurrency(value);
    notifyListeners();
  }

}