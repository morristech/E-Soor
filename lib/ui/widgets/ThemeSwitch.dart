import 'package:E_Soor/helpers/logic/constants.dart';
import 'package:E_Soor/helpers/sharedPrefs.dart';
import 'package:E_Soor/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {
  @override
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool _darkTheme = false;

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(Constants.kDarkTheme)
        : themeNotifier.setTheme(Constants.kLightTheme);
    final _sharedPrefsUtils = SharedPrefsUtils.getInstance();
    // ignore: unused_local_variable
    var isSuccess = await _sharedPrefsUtils.saveData<bool>(
        SharedPreferencesKeys.isDarkTheme, value);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == Constants.kDarkTheme);
    return Switch(
      activeColor: Theme.of(context).cursorColor,
      onChanged: (value) {
        setState(() {
          _darkTheme = value;
        });
        onThemeChanged(value, themeNotifier);
      },
      value: _darkTheme,
    );
  }
}
