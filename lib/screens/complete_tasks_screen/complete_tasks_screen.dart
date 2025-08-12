import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preference_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/widgets/tasks_list_widget.dart';

class CompleteTasksScreen extends StatefulWidget {
  const CompleteTasksScreen({super.key});

  @override
  State<CompleteTasksScreen> createState() => _CompleteTasksScreenState();
}

class _CompleteTasksScreenState extends State<CompleteTasksScreen> {
  List<TaskModel> completeTasks = [];
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
        completeTasks =
            taskAfterDecode
                .map((element) => TaskModel.fromJson(element))
                .where((element) => element.isDone)
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
      // final updatedTasks = tasks.map((e) => e.toMap()).toList();
      final allData = PreferenceManager().getString("tasks");

      if (allData != null) {
        List<TaskModel> allDataList =
            (jsonDecode(allData) as List)
                .map((e) => TaskModel.fromJson(e))
                .toList();
        final int newIndex = allDataList.indexWhere(
          (e) => e.id == completeTasks[index!].id,
        );
        if (newIndex != -1) {
          allDataList[newIndex] = completeTasks[index!];
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Text(
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child:
              isLoading
                  ? Center(
                    child: CircularProgressIndicator(color: Color(0xffFFFCFC)),
                  )
                  : completeTasks.isEmpty
                  ? Center(
                    child: Text(
                      "No Task Found",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )
                  : TasksListWidget(
                    tasks: completeTasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        completeTasks[index!].isDone = value ?? false;
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
