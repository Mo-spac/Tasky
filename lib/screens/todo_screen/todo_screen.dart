import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "ToDOOOO",
          style: TextStyle(color: Colors.red, fontSize: 50),
        ),
      ),
    );
  }
}
