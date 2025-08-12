import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preference_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/widgets/tasks_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
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
    final finalTask = PreferenceManager().getString("tasks");

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        // task = taskAfterDecode;
        highPriorityTasks =
            taskAfterDecode
                .map((element) => TaskModel.fromJson(element))
                .where((element) => element.isHighPriority)
                .toList();
        highPriorityTasks = highPriorityTasks.reversed.toList();
        // Short for this code:
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
      // final updatedTasks = tasks.map((e) => e.toMap()).toList();
      final allData = PreferenceManager().getString("tasks");

      if (allData != null) {
        List<TaskModel> allDataList =
            (jsonDecode(allData) as List)
                .map((e) => TaskModel.fromJson(e))
                .toList();
        final int newIndex = allDataList.indexWhere(
          (e) => e.id == highPriorityTasks[index!].id,
        );
        if (newIndex != -1) {
          allDataList[newIndex] = highPriorityTasks[index!];
          log(" mmmmmmmmmmmmm :${allDataList.toString()}");
        } else {
          log("⚠️ Task not found in saved data.");
        }
        // allDataList[newIndex] = tasks[index!];

        // final valueEncode = jsonEncode(allDataList);
        final valueEncode = jsonEncode(
          allDataList.map((e) => e.toMap()).toList(),
        );

        await PreferenceManager().setString("tasks", valueEncode);
        log("✅ Tasks saved successfully.");
      }
    } catch (e) {
      log("❌ Error saving tasks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("High Priorty Tasks")),
        body: Padding(
          padding: EdgeInsets.all(16),
          child:
              isLoading
                  ? Center(
                    child: CircularProgressIndicator(color: Color(0xffFFFCFC)),
                  )
                  : highPriorityTasks.isEmpty
                  ? Center(
                    child: Text(
                      "No High Priority Tasks",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )
                  : TasksListWidget(
                    tasks: highPriorityTasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        highPriorityTasks[index!].isDone = value ?? false;
                      });
                      await _saveTasksToPrefs(index);
                      _loadTask();
                    },
                  ),
        ),
      ),
    );
  }
}
