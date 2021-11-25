import 'package:flutter/material.dart';

import '../utils/unilabs_constants.dart';

class MyTheme {
  final ThemeData myAppTheme = buildTheme();

  static ThemeData buildTheme() {
    final ThemeData theme = ThemeData(
        brightness: Brightness.light,
        primaryColor: UnilabsColors.red,
        buttonColor: UnilabsColors.yellow,
        fontFamily: 'Roboto',
        textTheme: TextTheme(bodyText1:TextStyle(),bodyText2: TextStyle(fontSize: 13)));
    return theme;
  }
}
