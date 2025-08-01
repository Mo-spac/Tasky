import 'package:flutter/material.dart';
import 'package:tasky/core/wedgits/custom_check_box.dart';
import 'package:tasky/models/task_model.dart';

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
          (BuildContext context, int index) => Card(
            color: Color(0xff282828),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CustomCheckBox(
                value: tasks[index].isDone,
                onChanged: (value) {
                  onTap(value, index);
                },
              ),

              title: Text(
                tasks[index].taskName,
                style: TextStyle(
                  color:
                      tasks[index].isDone
                          ? Color(0xffA0A0A0)
                          : Color(0xffFFFCFC),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  decoration:
                      tasks[index].isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                  decorationColor: Color(0xffC6C6C6),
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),

              subtitle:
                  tasks[index].taskDescription.isNotEmpty
                      ? Text(
                        tasks[index].taskDescription,
                        style: TextStyle(
                          color: Color(0xffC6C6C6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration:
                              tasks[index].isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                          decorationColor: Color(0xffC6C6C6),
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      )
                      : null,
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color:
                      tasks[index].isDone
                          ? Color(0xffA0A0A0)
                          : Color(0xffC6C6C6),
                ),
              ),
            ),
          ),
    );
  }
}
