import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task/add_task_screen.dart';
import 'package:tasky/widgets/tasks_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel> tasks = [];
  bool isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  "assets/images/Thumbnail.png",
                  width: 42,
                  height: 42,
                ),
              ),
              title: Text(
                "Good Evening , $username",
                style: TextStyle(
                  color: Color(0xffFFFCFC),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                "One task at a time.One step closer.",
                style: TextStyle(
                  color: Color(0xffC6C6C6),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: SvgPicture.asset("assets/icons/Light.svg"),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Yuhuu ,Your work Is ",
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "almost done ! ",
                  style: TextStyle(
                    color: Color(0xFFFFFCFC),
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SvgPicture.asset(
                  "assets/icons/waving-hand-medium-light-skin-tone.svg",
                ),
              ],
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
                          ),
                        ),
                      )
                      : TasksListWidget(
                        tasks: tasks,
                        onTap: (bool? value, int? index) async {
                          setState(() {
                            tasks[index!].isDone = value ?? false;
                          });
                          await _saveTasksToPrefs();
                        },
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
