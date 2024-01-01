import 'package:flutter/material.dart';

class CustomThemes {
  static final lightTheme = ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),),),
      cardColor: Colors.grey,
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.blueAccent,
      iconTheme: IconThemeData(color: Colors.black));
  static final darkTheme = ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),),),
      cardColor: Colors.tealAccent,
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.blueGrey,
      iconTheme: IconThemeData(color: Colors.white));
}
