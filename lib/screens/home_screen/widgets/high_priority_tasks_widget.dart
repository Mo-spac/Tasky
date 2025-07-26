import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/high_priority_screen/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.refresh,
  });

  final List<TaskModel> tasks;
  final Function(TaskModel, bool?) onToggle;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    final highPriorityTasks =
        tasks.reversed.where((task) => task.isHighPriority).take(4).toList();
    return Container(
      padding: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "High Priority Tasks",
                    style: TextStyle(
                      color: Color(0xff15B86C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ...highPriorityTasks.map(
                  (element) => Row(
                    children: [
                      Checkbox(
                        value: element.isDone,
                        onChanged: (value) {
                          onToggle(element, value);
                        },
                        activeColor: Color(0xFF15B86C),
                        checkColor: Color(0xffFFFCFC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          element.taskName,
                          style: TextStyle(
                            color:
                                element.isDone
                                    ? Color(0xffA0A0A0)
                                    : Color(0xffFFFCFC),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            decoration:
                                element.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                            decorationColor: Color(0xffC6C6C6),
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HighPriorityScreen(),
                ),
              );

              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 48,
                height: 56,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xff282828),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff6E6E6E)),
                ),
                child: SvgPicture.asset("assets/icons/arrow-up-right.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
