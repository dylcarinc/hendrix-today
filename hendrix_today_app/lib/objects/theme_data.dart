import 'package:flutter/material.dart';

final ThemeData hendrixTodayThemeData = ThemeData(
  fontFamily: 'Merriweather-Sans',
);

extension HendrixTodayColorScheme on ColorScheme {
  Color get htOrange => const Color(0xFFCA5127);
  Color get htBlack => const Color(0xFF000000);
  Color get htGray => const Color(0xFF808080);
  Color get htBackground => const Color(0xFFFFFFFF);
}

extension HendrixTodayTextTheme on TextTheme {
  TextStyle get htAppBarTitle => const TextStyle(
    color: Colors.white,
    fontFamily: 'MuseoBold',
    fontSize: 30,
  );
  TextStyle get htResourceButton => const TextStyle(
    color: Colors.white,
    fontFamily: 'MuseoBold',
    fontSize: 30,
  );
  TextStyle get htDropdownText => const TextStyle(
    color: Colors.white,
    fontFamily: 'Museo',
    fontSize: 15,
  );
  TextStyle get htSearchBarLabel => const TextStyle(
    color: Colors.black,
    fontFamily: 'Museo',
    fontWeight: FontWeight.w500,
  );
  TextStyle get htEventDialogTitle => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  TextStyle get htEventCardTitle => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  TextStyle get htBoldText => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  TextStyle get htEventDetails => const TextStyle(
    color: Color.fromARGB(255, 128, 128, 128),
    fontStyle: FontStyle.italic,
    fontSize: 14,
    fontWeight: FontWeight.w200,
  );
  TextStyle get htDate => const TextStyle(
    color: Color.fromARGB(255, 128, 128, 128),
    fontStyle: FontStyle.italic,
    fontSize: 14,
    fontWeight: FontWeight.w200,
  );
  TextStyle get htBodyText => const TextStyle(
    color: Colors.black,
  );
  TextStyle get htBodyLink => const TextStyle(
    color: Color.fromARGB(255, 202, 81, 39),
    decoration: TextDecoration.underline,
  );

  TextStyle htBoldTextColored(Color color) => TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
}
