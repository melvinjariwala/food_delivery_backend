// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:food_delivery_backend/config/material_color.dart';

ThemeData theme() {
  print("Theme is running");
  return ThemeData(
      primarySwatch: buildMaterialColor(const Color(0xFFEED70B)),
      primaryColor: const Color(0xFFEED70B),
      primaryColorDark: const Color(0xFFBBA802),
      primaryColorLight: const Color(0xFFFFF068),
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: const Color(0xFFF5F5F5),
      cardColor: const Color(0xFFFC9C3C),
      fontFamily: 'Futura',
      textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 36,
              fontFamily: 'Futura'),
          headline2: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Futura'),
          headline3: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          headline4: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          headline5: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          headline6: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
          bodyText1: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              fontFamily: 'Futura'),
          bodyText2: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 12)));
}
