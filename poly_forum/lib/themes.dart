import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kScaffoldColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(
      color: kTextColor,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    headline1: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.bold,
      color: kTextColor,
    ),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme();
}
