import 'package:flutter/material.dart';

import 'app_text_theme.dart';
import 'button_theme.dart';
import 'colors.dart';

final appTheme = ThemeData(
  fontFamily: 'Roboto',
  textTheme: appTextTheme,
  scaffoldBackgroundColor: backgroundColor,
  elevatedButtonTheme: elevatedButtonTheme,
  buttonTheme: const ButtonThemeData(
    splashColor: Colors.transparent,
  ),
  checkboxTheme: CheckboxThemeData(
    side: const BorderSide(
      color: Color(0xFFE6E8EA),
      width: 1,
    ),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return textColor;
      }
      return primaryColor;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        4,
      ),
    ),
    overlayColor: const MaterialStatePropertyAll(
      Colors.transparent,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 3,
    shadowColor: Color.fromARGB(109, 218, 222, 232),
    toolbarHeight: 60,
  ),
);
