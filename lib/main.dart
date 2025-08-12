import 'package:flutter/material.dart';
import 'package:tasky/core/services/preference_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/screens/main_screen/main_screen.dart';
import 'package:tasky/screens/welcome_screen/welcome_screen.dart';

// Value Notifire
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();

  ThemeController().init();

  String? username = PreferenceManager().getString("username");
  print("Username = $username");

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
