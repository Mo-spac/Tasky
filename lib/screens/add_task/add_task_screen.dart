import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/home_screen/home_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // TO DO : Dispose this controlers
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isHighPriority = true;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Name",
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: taskNameController,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? false) {
                    return "Please, Enter your Task's name";
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Finish UI design for login screen",
                  filled: true,
                  fillColor: Color(0xff282828),
                  hintStyle: TextStyle(
                    color: Color(0xff6D6D6D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                cursorColor: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                "Task Description",
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: taskDescriptionController,
                // validator: (String? value) {
                //   if (value?.trim().isEmpty ?? false) {
                //     return "Please, Enter your Task's description";
                //   }
                //   return null;
                // },
                style: TextStyle(color: Colors.white),
                maxLines: 5,
                decoration: InputDecoration(
                  hintText:
                      "Finish onboarding UI and hand off to devs by Thursday.",
                  filled: true,
                  fillColor: Color(0xff282828),
                  hintStyle: TextStyle(
                    color: Color(0xff6D6D6D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                cursorColor: Colors.white,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "High Priority",
                    style: TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Switch(
                    value: isHighPriority,
                    onChanged: (bool value) {
                      setState(() {
                        isHighPriority = value;
                      });
                    },
                    activeTrackColor: Color(0xFF15B86C),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    TaskModel taskModel = TaskModel(
                      taskName: taskNameController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    // Map<String, dynamic> task = {
                    //   "taskName": taskNameController.text,
                    //   "taskDescription": taskDescriptionController.text,
                    //   "isHighPriority": isHighPriority,d
                    // };

                    final pref = await SharedPreferences.getInstance();
                    final taskJson = pref.getString("tasks");
                    log(taskJson.toString());
                    List<dynamic> listTasks = [];
                    if (taskJson != null) {
                      listTasks = jsonDecode(taskJson);
                    }
                    log("List Tasks before added : $listTasks");
                    // listTasks.add(task);
                    listTasks.add(taskModel.toMap());
                    log("List Tasks after added : $listTasks");
                    final tasksEncode = jsonEncode(listTasks);
                    await pref.setString("tasks", tasksEncode);

                    // ******************** One Task **************************
                    // final taskEncode = jsonEncode(task);
                    // await pref.setString("task", taskEncode);

                    // log("task: $task".toString());
                    // log("taskEncode: $taskEncode".toString());

                    // final finalTask = pref.getString("task");

                    // log("finalTask: $finalTask".toString());

                    // final taskAfterDecode =
                    //     jsonDecode(finalTask ?? "") as Map<String, dynamic>;

                    // log("taskAfterDecode: $taskAfterDecode".toString());
                    // log(taskAfterDecode["taskName"].toString());

                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF15B86C),
                  foregroundColor: Color(0xFFFFFCFC),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                icon: Icon(Icons.add),
                label: Text(
                  "Add Task",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
