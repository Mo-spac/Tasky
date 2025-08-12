import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/wedgits/custom_check_box.dart';
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
  // final Function(int?, bool?) onToggle;
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

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      highPriorityTasks.length >= 4
                          ? 4
                          : highPriorityTasks.length,
                  itemBuilder: (context, index) {
                    final element = highPriorityTasks[index];
                    return Row(
                      children: [
                        CustomCheckBox(
                          value: element.isDone,
                          onChanged: (value) {
                            // final index = tasks.indexWhere((e) {
                            //   return e.id == element.id;
                            // });
                            onToggle(element, value);
                          },
                        ),
                        Expanded(
                          child: Text(
                            element.taskName,
                            style:
                                element.isDone
                                    ? Theme.of(context).textTheme.titleLarge
                                    : Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // ...highPriorityTasks.map(
                //   (element) => Row(
                //     children: [
                //       CustomCheckBox(
                //         value: element.isDone,
                //         onChanged: (value) {
                //           onToggle(element, value);
                //         },
                //       ),

                //       Expanded(
                //         child: Text(
                //           element.taskName,
                //           style:
                //               element.isDone
                //                   ? Theme.of(context).textTheme.titleLarge
                //                   : Theme.of(context).textTheme.titleMedium,
                //           maxLines: 1,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff6E6E6E)),
                ),
                child: SvgPicture.asset(
                  "assets/icons/arrow-up-right.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    ThemeController.isDark()
                        ? Color(0xff6E6E6E)
                        : Color(0xffD1DAD6),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
