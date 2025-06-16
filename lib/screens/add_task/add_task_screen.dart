import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      appBar: AppBar(
        backgroundColor: Color(0xFF181818),
        centerTitle: false,
        title: Text("New Task"),
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFCFC),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
      ),
      body: Column(),
    );
  }
}
