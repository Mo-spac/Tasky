import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task/add_task_screen.dart';
import 'package:tasky/screens/home_screen/widgets/acheived_tasks.dart';
import 'package:tasky/screens/home_screen/widgets/greeting.dart';
import 'package:tasky/screens/home_screen/widgets/high_priority_tasks.dart';
import 'package:tasky/screens/widgets/tasks_list_widget.dart';

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
    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString("tasks");

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
    final pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("username");
    });
    print("Usernameee = $username");
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
            HighPriorityTasks(
              tasks: tasks,
              onToggle: (TaskModel task, bool? value) async {
                setState(() {
                  task.isDone = value ?? false;
                  _caculatePercentProgress();
                });
                await _saveTasksToPrefs();
              },
            ),

            Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My Tasks",
                  style: TextStyle(
                    color: Color(0xffFFFCFC),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                  isLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffFFFCFC),
                        ),
                      )
                      : tasks.isEmpty
                      ? Center(
                        child: Text(
                          "No Tasks",
                          style: TextStyle(
                            color: Color(0xffFFFCFC),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                      : TasksListWidget(
                        tasks: tasks,
                        onTap: (bool? value, int? index) async {
                          setState(() {
                            tasks[index!].isDone = value ?? false;
                            _caculatePercentProgress();
                          });
                          await _saveTasksToPrefs();
                        },
                        // When I use Function for both:
                        // (bool? value, int? index) async {
                        //     if (index != null) {
                        //       _updateTaskStatus(tasks[index], value);
                        //     }
                        //   },
                      ),
            ),

            // if (tasks.isNotEmpty)
            //   Column(
            //     children: [
            //       Text(
            //         tasks[0].taskName,
            //         style: TextStyle(color: Colors.red),
            //       ),
            //       Text(
            //         tasks[0].taskDescription,
            //         style: TextStyle(color: Colors.red),
            //       ),
            //       Text(
            //         "${tasks[0].isHighPriority}",
            //         style: TextStyle(color: Colors.red),
            //       ),
            //     ],
            //   ),

            //   Spacer(),
            //   Align(
            //     alignment: Alignment.bottomRight,
            //     child: ElevatedButton.icon(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (BuildContext context) => AddTask(),
            //           ),
            //         );
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Color(0xFF15B86C),
            //         foregroundColor: Color(0xFFFFFCFC),
            //         fixedSize: Size(167, 40),
            //       ),
            //       icon: Icon(Icons.add),
            //       label: Text(
            //         "Add New Task",
            //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            //       ),
            //     ),
            //   ),
          ],
        ),
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
          backgroundColor: Color(0xFF15B86C),
          foregroundColor: Color(0xFFFFFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          label: Text(
            "Add New Task",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
