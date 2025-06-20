import 'package:flutter/material.dart';
import 'package:tasky/screens/welcome_screen/widget/appbar_section.dart';
import 'package:tasky/screens/welcome_screen/widget/start_section.dart';
import 'package:tasky/screens/welcome_screen/widget/welcome_section.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              AppbarSection(),
              SizedBox(height: 116),
              WelcomeSection(),
              SizedBox(height: 28),
              StartSection(),
            ],
          ),
        ),
      ),
    );
  }
}
