import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

getMainTheme() {
  return ThemeData(
      primarySwatch: gold,
      accentColor: Colors.amber,
      fontFamily: 'JFFlat',
      primaryColor: gold,
      textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'JFFlat',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
      appBarTheme: AppBarTheme(
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'JFFlat',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ));
}

const MaterialColor gold = const MaterialColor(
  0xffA2834D,
  const <int, Color>{
    50: const Color(0xffA2834D),
    100: const Color(0xffA2834D),
    200: const Color(0xffA2834D),
    300: const Color(0xffA2834D),
    400: const Color(0xffA2834D),
    500: const Color(0xffA2834D),
    600: const Color(0xffA2834D),
    700: const Color(0xffA2834D),
    800: const Color(0xffA2834D),
    900: const Color(0xffA2834D),
  },
);
