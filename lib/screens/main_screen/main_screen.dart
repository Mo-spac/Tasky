import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/screens/complete_tasks_screen/complete_tasks_screen.dart';
import 'package:tasky/screens/home_screen/home_screen.dart';
import 'package:tasky/screens/profile_screen/profile_screen.dart';
import 'package:tasky/screens/todo_tasks_screen/todo_tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomeScreen(),
    TodoTasksScreen(),
    CompleteTasksScreen(),
    ProfileScreen(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int? index) {
          log(index.toString());
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        backgroundColor: Color(0xFF181818),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color(0xffC6C6C6),
        selectedItemColor: Color(0xff15B86C),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/home.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? Color(0xff15B86C) : Color(0xffC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/todo.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? Color(0xff15B86C) : Color(0xffC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "ToDo",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/completed.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? Color(0xff15B86C) : Color(0xffC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "completed",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/profile.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? Color(0xff15B86C) : Color(0xffC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "profile",
          ),
        ],
      ),
      body: screens[_currentIndex],
    );
  }
}
