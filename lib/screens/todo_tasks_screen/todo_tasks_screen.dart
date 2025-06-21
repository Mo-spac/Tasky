import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/tasks_list_widget.dart';

class TodoTasksScreen extends StatefulWidget {
  const TodoTasksScreen({super.key});

  @override
  State<TodoTasksScreen> createState() => _TodoTasksScreenState();
}

class _TodoTasksScreenState extends State<TodoTasksScreen> {
  List<TaskModel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString("tasks");

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        // task = taskAfterDecode;
        tasks =
            taskAfterDecode
                .map((element) => TaskModel.fromJson(element))
                .where((element) => element.isDone == false)
                .toList();
        // Short for this code
        // tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
        // tasks = tasks.where((element) => element.isDone == false).toList();
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveTasksToPrefs() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final updatedTasks = tasks.map((e) => e.toMap()).toList();
      final valueEncode = jsonEncode(updatedTasks);
      await pref.setString("tasks", valueEncode);
      log("✅ Tasks saved successfully.");
    } catch (e) {
      log("❌ Error saving tasks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do Tasks")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child:
            isLoading
                ? Center(
                  child: CircularProgressIndicator(color: Color(0xffFFFCFC)),
                )
                : tasks.isEmpty
                ? Center(
                  child: Text(
                    "No Task Found",
                    style: TextStyle(color: Color(0xffFFFCFC), fontSize: 24),
                  ),
                )
                : TasksListWidget(
                  tasks: tasks,
                  onTap: (bool? value, int? index) async {
                    setState(() {
                      tasks[index!].isDone = value ?? false;
                    });
                    await _saveTasksToPrefs();
                    _loadTask();
                  },
                ),
      ),
    );
  }
}
