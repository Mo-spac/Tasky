import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preference_manager.dart';
import 'package:tasky/core/wedgits/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';

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
      appBar: AppBar(title: Text("New Task")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: _key,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                title: "Task Name",
                controller: taskNameController,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? false) {
                    return "Please, Enter your Task's name";
                  }
                  return null;
                },
                hintText: "Finish UI design for login screen",
              ),
              SizedBox(height: 20),
              SizedBox(height: 8),
              CustomTextFormField(
                title: "Task Description",
                controller: taskDescriptionController,
                hintText:
                    "Finish onboarding UI and hand off to devs by Thursday.",
                maxLines: 5,
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
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    final taskJson = PreferenceManager().getString("tasks");
                    log(taskJson.toString());

                    List<dynamic> listTasks = [];

                    if (taskJson != null) {
                      listTasks = jsonDecode(taskJson);
                    }

                    TaskModel taskModel = TaskModel(
                      id: listTasks.length + 1,
                      taskName: taskNameController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    log("List Tasks before added : $listTasks");
                    // listTasks.add(task);
                    listTasks.add(taskModel.toMap());
                    log("List Tasks after added : $listTasks");

                    final tasksEncode = jsonEncode(listTasks);
                    await PreferenceManager().setString("tasks", tasksEncode);

                    // Map<String, dynamic> task = {
                    //   "taskName": taskNameController.text,
                    //   "taskDescription": taskDescriptionController.text,
                    //   "isHighPriority": isHighPriority,d
                    // };

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

                    Navigator.of(context).pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
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
