import 'package:flutter/material.dart';

const primaryColor = Color(0xff119d49);
const backgroundLightColor = Colors.white;
const backgroundDarkColor = Color(0xFF1F2026);
const navigationBarLightColor = Colors.white;
const navigationBarLDarkColor = Color(0xFF30313C);

class Themes {
  static final themeLight = ThemeData.light().copyWith(
      primaryColor: primaryColor,
      backgroundColor: backgroundLightColor,
      secondaryHeaderColor: primaryColor,
      canvasColor: backgroundLightColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor, foregroundColor: Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[100],
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey[300]),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),
      ));

  static final themeDark = ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      backgroundColor: backgroundDarkColor,
      secondaryHeaderColor: primaryColor,
      canvasColor: backgroundDarkColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor, foregroundColor: Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: navigationBarLDarkColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey[300]),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
      ));
}
