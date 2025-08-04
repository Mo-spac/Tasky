import 'package:flutter/material.dart';
import 'package:tasky/core/services/preference_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/screens/main_screen/main_screen.dart';
import 'package:tasky/screens/welcome_screen/welcome_screen.dart';

// Value Notifire
ValueNotifier<ThemeMode> themeNotifire = ValueNotifier(ThemeMode.dark);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();

  bool result = PreferenceManager().getBool("theme") ?? true;
  if (result) {
    themeNotifire.value = ThemeMode.dark;
  } else {
    themeNotifire.value = ThemeMode.light;
  }

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
      valueListenable: themeNotifire,
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
