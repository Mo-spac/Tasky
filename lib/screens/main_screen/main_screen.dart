import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/screens/complete_tasks_screen/complete_tasks_screen.dart';
import 'package:tasky/screens/home_screen/home_screen.dart';
import 'package:tasky/screens/profile_screen/profile_screen.dart';
import 'package:tasky/screens/todo_screen/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomeScreen(),
    TodoScreen(),
    CompleteTasksScreen(),
    ProfileScreen(),
  ];
  Widget _currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int? index) {
          log(index.toString());
          setState(() {
            // if (index == 0) {
            //   screen = HomeScreen();
            // } else if (index == 1) {
            //   screen = TodoScreen();
            // } else if (index == 2) {
            //   screen = CompleteTasksScreen();
            // } else {
            //   screen = ProfileScreen();
            // }
            _currentScreen = screens[index ?? 0];
          });
        },
        backgroundColor: Color(0xFF181818),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color(0xffC6C6C6),
        selectedItemColor: Color(0xff15B86C),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/home.svg"),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/todo.svg"),
            label: "ToDo",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/completed.svg"),
            label: "completed",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/profile.svg"),
            label: "profile",
          ),
        ],
      ),
      body: _currentScreen,
    );
  }
}
