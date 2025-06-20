import 'package:flutter/material.dart';

class CompleteTasksScreen extends StatelessWidget {
  const CompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "completed Screen",
          style: TextStyle(color: Colors.red, fontSize: 50),
        ),
      ),
    );
  }
}
