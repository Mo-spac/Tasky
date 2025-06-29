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
  List<TaskModel> todoTasks = [];
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
        todoTasks =
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

  Future<void> _saveTasksToPrefs(int? index) async {
    try {
      //  if (index == null) return;
      final pref = await SharedPreferences.getInstance();
      // final updatedTasks = tasks.map((e) => e.toMap()).toList();
      final allData = pref.getString("tasks");

      if (allData != null) {
        List<TaskModel> allDataList =
            (jsonDecode(allData) as List)
                .map((e) => TaskModel.fromJson(e))
                .toList();
        final int newIndex = allDataList.indexWhere(
          (e) => e.id == todoTasks[index!].id,
        );
        if (newIndex != -1) {
          allDataList[newIndex] = todoTasks[index!];
          log(" mmmmmmmmmmmmm :${allDataList.toString()}");
        } else {
          log("⚠️ Task not found in saved data.");
        }
        // allDataList[newIndex] = tasks[index!];

        // final valueEncode = jsonEncode(allDataList);
        final valueEncode = jsonEncode(
          allDataList.map((e) => e.toMap()).toList(),
        );

        await pref.setString("tasks", valueEncode);
        log("✅ Tasks saved successfully.");
      }
    } catch (e) {
      log("❌ Error saving tasks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Text(
            "To Do Tasks",
            style: TextStyle(color: Color(0xffFFFCFC), fontSize: 20),
          ),
        ),
        Expanded(
          child:
              isLoading
                  ? Center(
                    child: CircularProgressIndicator(color: Color(0xffFFFCFC)),
                  )
                  : todoTasks.isEmpty
                  ? Center(
                    child: Text(
                      "No Task Found",
                      style: TextStyle(color: Color(0xffFFFCFC), fontSize: 24),
                    ),
                  )
                  : TasksListWidget(
                    tasks: todoTasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        todoTasks[index!].isDone = value ?? false;
                      });
                      await _saveTasksToPrefs(index);
                      _loadTask();
                    },
                  ),
        ),
      ],
    );
  }
}
