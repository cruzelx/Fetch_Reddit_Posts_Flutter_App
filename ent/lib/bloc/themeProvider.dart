import 'package:ent/constants/themes.dart';
import 'package:ent/utils/sharedPrefData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode;
  ThemeProvider() {
    SharedPreferences.getInstance().then((prefs) {
      String temp = prefs.getString("theme");
      _themeMode = checkTheme(temp);
    });
  }

  ThemeMode get themeMode => _themeMode;

  setThemeMode(dynamic themeMode) async {
    themeMode = themeMode == null ? "system" : themeMode;
    setThemeModeToSP(themeMode);
    _themeMode = checkTheme(themeMode);
    notifyListeners();
  }
}

ThemeMode checkTheme(String temp) {
  if (temp == "system") {
    return ThemeMode.system;
  } else if (temp == "dark") {
    return ThemeMode.dark;
  } else if (temp == "light") {
    return ThemeMode.light;
  } else {
    return ThemeMode.system;
  }
}
