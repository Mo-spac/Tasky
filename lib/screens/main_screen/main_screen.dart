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

        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture(path: "assets/icons/home.svg", index: 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture(path: "assets/icons/todo.svg", index: 1),
            label: "ToDo",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture(
              path: "assets/icons/completed.svg",
              index: 2,
            ),

            label: "completed",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture(path: "assets/icons/profile.svg", index: 3),
            label: "profile",
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: screens[_currentIndex],
        ),
      ),
    );
  }

  SvgPicture _buildSvgPicture({required String path, required int index}) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
