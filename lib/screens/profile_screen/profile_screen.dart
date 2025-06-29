import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "My Profile",
            style: TextStyle(color: Color(0xffFFFCFC), fontSize: 20),
          ),
        ),
      ],
    );
  }
}
