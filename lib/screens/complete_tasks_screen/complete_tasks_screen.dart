import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/tasks_list_widget.dart';

class CompleteTasksScreen extends StatefulWidget {
  const CompleteTasksScreen({super.key});

  @override
  State<CompleteTasksScreen> createState() => _CompleteTasksScreenState();
}

class _CompleteTasksScreenState extends State<CompleteTasksScreen> {
  List<TaskModel> CompleteTasks = [];
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
        CompleteTasks =
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
      final pref = await SharedPreferences.getInstance();
      // final updatedTasks = tasks.map((e) => e.toMap()).toList();
      final allData = pref.getString("tasks");

      if (allData != null) {
        List<TaskModel> allDataList =
            (jsonDecode(allData) as List)
                .map((e) => TaskModel.fromJson(e))
                .toList();
        final int newIndex = allDataList.indexWhere(
          (e) => e.id == CompleteTasks[index!].id,
        );
        if (newIndex != -1) {
          allDataList[newIndex] = CompleteTasks[index!];
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
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "Completed Tasks",
            style: TextStyle(color: Color(0xffFFFCFC), fontSize: 20),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child:
                isLoading
                    ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffFFFCFC),
                      ),
                    )
                    : CompleteTasks.isEmpty
                    ? Center(
                      child: Text(
                        "No Task Found",
                        style: TextStyle(
                          color: Color(0xffFFFCFC),
                          fontSize: 24,
                        ),
                      ),
                    )
                    : TasksListWidget(
                      tasks: CompleteTasks,
                      onTap: (bool? value, int? index) async {
                        setState(() {
                          CompleteTasks[index!].isDone = value ?? false;
                        });
                        await _saveTasksToPrefs(index);
                        _loadTask();
                      },
                    ),
          ),
        ),
      ],
    );
  }
}
