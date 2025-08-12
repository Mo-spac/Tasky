import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preference_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task_screen/add_task_screen.dart';
import 'package:tasky/screens/home_screen/widgets/acheived_tasks.dart';
import 'package:tasky/screens/home_screen/widgets/greeting.dart';
import 'package:tasky/screens/home_screen/widgets/high_priority_tasks_widget.dart';
import 'package:tasky/screens/widgets/sliver_tasks_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTask = 0;
  double percent = 0;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    // await Future.delayed(Duration(seconds: 3));
    final finalTask = PreferenceManager().getString("tasks");

    log("finalTask: $finalTask".toString());
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      log("taskAfterDecode: $taskAfterDecode".toString());
      log("******************");
      log(taskAfterDecode[0]["taskName"].toString());

      // final tasks =
      //     taskAfterDecode.map((e) {
      //       // return TaskModel(
      //       //   taskName: e["taskName"],
      //       //   taskDescription: e["taskDescription"],
      //       //   isHighPriority: e["isHighPriority"],
      //       // );
      //       return TaskModel.fromJson(e);
      //     }).toList();

      // log("tasks : $tasks");

      setState(() {
        // task = taskAfterDecode;
        tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
        _caculatePercentProgress();
      });
      // log("task : ${task[0]["taskName"]}");
      log("task : ${tasks[0].taskName}");
    }

    setState(() {
      isLoading = false;
    });
  }

  void _loadUsername() async {
    setState(() {
      username = PreferenceManager().getString("username");
    });
    print("Usernameee = $username");
  }

  Future<void> _saveTasksToPrefs() async {
    try {
      final updatedTasks = tasks.map((e) => e.toMap()).toList();
      final valueEncode = jsonEncode(updatedTasks);
      await PreferenceManager().setString("tasks", valueEncode);
      log("✅ Tasks saved successfully.");
    } catch (e) {
      log("❌ Error saving tasks: $e");
    }
  }

  _caculatePercentProgress() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : totalDoneTask / totalTask;
  }

  // To use just high piriority status:
  // void _updateTaskStatus(TaskModel task, bool? value) async {
  //   setState(() {
  //     task.isDone = value ?? false;
  //     _caculatePercentProgress();
  //   });
  //   await _saveTasksToPrefs();
  // }

  // To both status:
  // void _updateTaskStatus(TaskModel task, bool? value) async {
  //   final index = tasks.indexWhere((e) => e.id == task.id);
  //   if (index != -1) {
  //     setState(() {
  //       tasks[index].isDone = value ?? false;
  //       _caculatePercentProgress();
  //     });
  //     await _saveTasksToPrefs();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Greeting(username: username ?? ""),
                SizedBox(height: 16),
                AcheivedTasks(
                  totalTask: totalTask,
                  totalDoneTask: totalDoneTask,
                  percent: percent,
                ),
                SizedBox(height: 8),
                HighPriorityTasksWidget(
                  tasks: tasks,
                  onToggle: (TaskModel task, bool? value) async {
                    setState(() {
                      task.isDone = value ?? false;
                      _caculatePercentProgress();
                    });
                    await _saveTasksToPrefs();
                  },
                  refresh: () {
                    _loadTask();
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My Tasks",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xffFFFCFC)),
                ),
              )
              : tasks.isEmpty
              ? SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "No Tasks",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              )
              : SliverTasksListWidget(
                tasks: tasks,
                onTap: (bool? value, int? index) async {
                  setState(() {
                    tasks[index!].isDone = value ?? false;
                    _caculatePercentProgress();
                  });
                  await _saveTasksToPrefs();
                },
              ),
        ],
      ),

      floatingActionButton: SizedBox(
        width: 167,
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AddTaskScreen(),
              ),
            );
            log(result.toString());
            print(result);
            if (result != null && result == true) {
              _loadTask();
            }
          },

          label: Text("Add New Task"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
