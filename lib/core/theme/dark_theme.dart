import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(primaryContainer: Color(0xff282828)),
  scaffoldBackgroundColor: Color(0xFF181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF181818),
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
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
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFCFC),
        ),
      ),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    extendedTextStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFFFFFCFC),
    ),
  ),

  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ),

    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFFFF),
    ),

    displayLarge: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),

    titleSmall: TextStyle(
      color: Color(0xffC6C6C6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    titleMedium: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),

    // for Done task
    titleLarge: TextStyle(
      color: Color(0xffA0A0A0),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xffA0A0A0),
      overflow: TextOverflow.ellipsis,
    ),

    labelSmall: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),

    labelMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    labelLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: Color(0xff6D6D6D),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    filled: true,
    fillColor: Color(0xff282828),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(color: Color(0xff6E6E6E), width: 2),
  ),

  iconTheme: IconThemeData(color: Color(0xffC6C6C6)),
);
