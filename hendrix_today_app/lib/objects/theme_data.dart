import 'package:flutter/material.dart';

final ThemeData hendrixTodayLightMode = ThemeData(
  fontFamily: 'Merriweather-Sans',
  brightness: Brightness.light,

  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 202, 81, 39),
    onPrimary: Colors.white,
    secondary: Colors.black,
    onSecondary: Colors.white,
    tertiary: Color.fromARGB(255, 128, 128, 128),
    onTertiary: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    error: Color.fromARGB(255, 255, 170, 170),
    onError: Color.fromARGB(255, 255, 100, 100),
    surface: Color.fromARGB(255, 228, 223, 221),
    onSurface: Color.fromARGB(255, 128, 128, 128),
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle( // app bar title, resource button
      color: Colors.white,
      fontFamily: 'MuseoBold',
      fontSize: 30,
    ),
    headlineLarge: TextStyle( // event dialog title
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    headlineMedium: TextStyle( // event card title
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    headlineSmall: TextStyle( // dates and event details
      color: Color.fromARGB(255, 128, 128, 128),
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w200,
      fontSize: 14,
    ),
    bodySmall: TextStyle( // body text
      color: Colors.black,
      fontFamily: 'Merriweather-Sans',
      fontSize: 14,
    ),
    labelLarge: TextStyle( // dropdown text, search bar label
      color: Colors.white,
      fontFamily: 'Museo',
      fontSize: 15,
    ),
    labelMedium: TextStyle( // bold text
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    labelSmall: TextStyle( // body link
      color: Color.fromARGB(255, 202, 81, 39),
      fontFamily: 'Merriweather-Sans',
      decoration: TextDecoration.underline,
      letterSpacing: 0,
      fontSize: 14,
    ),
  ),
);

final ThemeData hendrixTodayDarkMode = ThemeData(
  fontFamily: 'Merriweather-Sans',
  brightness: Brightness.dark,

  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 202, 81, 39),
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.black,
    tertiary: Color.fromARGB(255, 128, 128, 128),
    onTertiary: Colors.white,
    background: Color.fromARGB(255, 36, 36, 36),
    onBackground: Colors.white,
    error: Color.fromARGB(255, 255, 170, 170),
    onError: Color.fromARGB(255, 255, 100, 100),
    surface: Color.fromARGB(255, 36, 36, 36),
    onSurface: Color.fromARGB(255, 128, 128, 128),
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle( // app bar title, resource button
      fontFamily: 'MuseoBold',
      fontSize: 30,
    ),
    headlineLarge: TextStyle( // event dialog title
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    headlineMedium: TextStyle( // event card title
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    headlineSmall: TextStyle( // dates and event details
      color: Color.fromARGB(255, 128, 128, 128),
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w200,
      fontSize: 14,
    ),
    bodySmall: TextStyle( // body text
      fontFamily: 'Merriweather-Sans',
      fontSize: 14,
    ),
    labelLarge: TextStyle( // dropdown text, search bar label
      // color: Colors.white,
      fontFamily: 'Museo',
      fontSize: 15,
    ),
    labelMedium: TextStyle( // bold text
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    labelSmall: TextStyle( // body link
      color: Color.fromARGB(255, 202, 81, 39),
      fontFamily: 'Merriweather-Sans',
      decoration: TextDecoration.underline,
      letterSpacing: 0,
      fontSize: 14,
    ),
  ),
);
