import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/screens/home_screen/home_screen.dart';
import 'package:tasky/screens/main_screen/main_screen.dart';
import 'package:tasky/screens/welcome_screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  String? username = pref.getString("username");

  print("Username = $username");

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      theme: ThemeData(
        useMaterial3: true,
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
            // ,
          ),
        ),
      ),

      home: username == null ? WelcomeScreen() : MainScreen(),
    );
  }
}
