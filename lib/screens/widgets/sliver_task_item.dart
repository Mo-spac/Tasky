import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasky/core/wedgits/custom_check_box.dart';
import 'package:tasky/models/task_model.dart';

class SliverTaskItem extends StatelessWidget {
  const SliverTaskItem({
    super.key,
    required this.taskModel,
    required this.onChanged,
  });

  final TaskModel taskModel;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        // side: BorderSide(color: Color(0xffD1DAD6)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CustomCheckBox(
          value: taskModel.isDone,
          onChanged: (value) {
            onChanged(value);
          },
        ),

        title: Text(
          taskModel.taskName,
          style: TextStyle(
            color: taskModel.isDone ? Color(0xffA0A0A0) : Color(0xffFFFCFC),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            decoration:
                taskModel.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
            decorationColor: Color(0xffC6C6C6),
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),

        subtitle:
            taskModel.taskDescription.isNotEmpty
                ? Text(
                  taskModel.taskDescription,
                  style: TextStyle(
                    color: Color(0xffC6C6C6),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration:
                        taskModel.isDone
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
            color: taskModel.isDone ? Color(0xffA0A0A0) : Color(0xffC6C6C6),
          ),
        ),
      ),
    );
  }
}
