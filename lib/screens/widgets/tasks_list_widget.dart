import 'package:flutter/material.dart';
import 'package:tasky/core/wedgits/custom_check_box.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/widgets/sliver_task_item.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({super.key, required this.tasks, required this.onTap});

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 30),
      itemCount: tasks.length,
      itemBuilder:
          (BuildContext context, int index) => SliverTaskItem(
            taskModel: tasks[index],
            onChanged: (bool? value) {
              onTap(value, index);
            },
          ),
    );
  }
}
