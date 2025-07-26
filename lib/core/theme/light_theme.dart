import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(primaryContainer: Color(0xffFFFFFF)),
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Color(0xffFFFCFC);
    }),
    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xffFFFCFC);
      }
      return Color(0xff9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xff9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
      // minimumSize: WidgetStateProperty.all(Size.fromHeight(40)),
    ),
  ),

  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),

    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),

    displayLarge: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),

    titleSmall: TextStyle(
      color: Color(0xff3A4640),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    titleMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),

    labelMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xff9E9E9E)),
    filled: true,
    fillColor: Color(0xffFFFFFF),
    focusColor: Color(0xffD1DAD6),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
  ),
);
